package Code4Health::AppKitX::Organisations::Controller::Organisations;

use Moose;
use namespace::autoclean;
use Try::Tiny;
use Code4Health::AppKitX::Organisations::Form::CSVUpload;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; };
with 'OpusVL::AppKit::RolesFor::Controller::GUI';

__PACKAGE__->config
(
    appkit_name                 => 'Organisations',
    appkit_myclass              => 'Code4Health::AppKitX::Organisations',
    appkit_method_group         => 'Organisations',
    appkit_shared_module        => 'Organisations',
);

has upload_form => (
    is => 'ro',
    isa => 'Object',
    builder => '_build_upload_form'
);

sub _build_upload_form {
    my $self = shift;

    return Code4Health::AppKitX::Organisations::Form::CSVUpload->new(
        name => "csv_upload_form",
        field_list => [
            submit => {
                type => 'Submit',
                value => 'Upload',
            }
        ]
    );
}

sub index
    : Local
    : Args(0)
    : NavigationName('List Organisations')
    : AppKitFeature('Organisations')
{
    my ($self, $c) = @_;

    my $organisations = [$c->model('Users')->resultset('Organisation')->all];

    $c->stash->{organisations} = $organisations;
}

sub upload_csv
    : Local
    : Args(0)
    : NavigationName('Upload')
    : AppKitFeature('Organisations')
{
    my ($self, $c) = @_;

    my $form = $self->upload_form;

    my $upload = $c->req->upload('csv_file');
    my %process = (
        params => {
            csv_file => $upload,
        },
    );

    if ($c->req->method eq 'POST') {
        if ($form->process(%process)) {
            try {
                $c->model('Users::Organisation')->import_csv(
                    $upload->filename,
                    $upload->fh
                );
                $c->flash->{status_msg} = "CSV uploaded successfully";
                $c->res->redirect($c->uri_for($self->action_for('index')));
            }
            catch {
                $c->flash->{error_msg} = $_;
            }
            or return;
        }
        else {
            $c->stash->{error_msg} = "Looks like there were some errors here";
        }
    }

    $c->stash->{form} = $form;
}

sub organisation
    : Chained('/')
    : PathPart('organisation')
    : CaptureArgs(1)
    : AppKitFeature('Organisations')
{

}

1;
