use strict;
use warnings;
use inc::Module::Install 0.91;
use Module::Install::AuthorRequires;
use Module::Install::AuthorTests;

name 'Code4Health-AppKitX-Organisations';
all_from 'lib/Code4Health/AppKitX/Organisations.pm';

requires 'Moose';
requires 'namespace::autoclean';
requires 'OpusVL::AppKit';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Code4Health::DB';

test_requires 'OpusVL::AppKitX::PasswordReset';

build_requires 'Catalyst::Runtime' => '5.80015';
build_requires 'Test::WWW::Mechanize::Catalyst';
build_requires 'Test::More' => '0.88';

author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Test::Pod' => '1.14';

author_tests 't/author';

resources repository => 'ssh://git/srv/git/Code4Health-AppKitX-Organisations';

if ($Module::Install::AUTHOR) {
    system("pod2text lib/Code4Health/AppKitX/Organisations.pm > README")
        and die $!;
}

WriteAll();
