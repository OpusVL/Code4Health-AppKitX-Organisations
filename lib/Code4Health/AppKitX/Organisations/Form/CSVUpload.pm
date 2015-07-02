package Code4Health::AppKitX::Organisations::Form::CSVUpload;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';

with 'HTML::FormHandler::Widget::Wrapper::Bootstrap3';

has '+widget_wrapper' => (
    default => 'Bootstrap3'
);

has '+is_html5' => (
    default => 1
);

has '+enctype' => ( default => 'multipart/form-data');

has_field csv_file => (
    type => 'Upload',
    label => "CSV File",
    max_size => undef,
);

1;
