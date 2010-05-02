package App::Kaizendo::Moose;
use strict;
use warnings;

use Moose ();
use Moose::Autobox;
use Method::Signatures::Simple ();
use Moose::Util::TypeConstraints ();
use Moose::Autobox ();

my ( $import, $unimport, $init_meta );

sub import {
    my $class = shift;
    my $into = caller;

    ( $import, $unimport, $init_meta ) = Moose::Exporter->build_import_methods(
        into => $into, also => [qw/ Moose Moose::Util::TypeConstraints /]
    );

    Method::Signatures::Simple->import( into => $into );
    Moose::Autobox->import( into => $into );
    $class->$import({into => $into});
    Moose::Autobox->import({into => $into});
    namespace::autoclean->import(-cleanee => $into);
}

sub unimport { goto &$unimport }

sub init_metd { goto &$init_meta }

1;
