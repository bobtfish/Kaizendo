package App::Kaizendo::Moose;
use strict;
use warnings;

use Moose ();
use Moose::Autobox;
use Method::Signatures::Simple ();
use Moose::Util::TypeConstraints ();
use Moose::Autobox ();

my ( $import, $unimport, $init_meta );

# Basically this invokes all the modules (as documented in the description) into
# the calling package, ergo avoiding boilerplate code being repeated in every module..

# I appreciate that the code below is fairly cryptic, please see the docs for Moose::Exporter
# for more information...
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

1;

=head1 NAME

App::Kaizendo::Moose - Moose customised for Kaizendo.

=head1 SYNOPSIS

    package App::Kaizendo::SomeModule;
    use App::Kaizendo::Moose;

=head1 DESCRIPTION

This module replaces a lot of boilerplate code in Kaizendo modules with one statement.

Instead of saying:

   package App::Kaizendo::SomeModule;
   use Moose;
   use Moose::Autobox;
   use Method::Signatures::Simple;
   use Moose::Util::TypeConstraints;
   use namespace::autoclean;

you can just C<use App::Kaizendo::Moose>, which does all of that for you.

=head1 FUNCTIONS

=head2 import

Imports all of the goodness in the DESCRIPTION into your package

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
