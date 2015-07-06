package Code4Health::AppKitX::Organisations;

use Moose::Role;
use CatalystX::InjectComponent;
use namespace::autoclean;

our $VERSION = '0.02';

after 'setup_components' => sub {
    my $class = shift;
   
    $class->add_paths(__PACKAGE__);
    
    # .. inject your components here ..
    CatalystX::InjectComponent->inject(
        into      => $class,
        component => 'Code4Health::AppKitX::Organisations::Controller::Organisations',
        as        => 'Controller::Organisations'
    );
};

1;

=head1 NAME

Code4Health::AppKitX::Organisations - A brand new AppKitX component

=head1 DESCRIPTION

Frobnicates the whirligigs in a modular and reusable pattern

=head1 COPYRIGHT and LICENSE

Copyright (C) 2015 OpusVL

This software is licensed according to the "IP Assignment Schedule" provided with the development project.
