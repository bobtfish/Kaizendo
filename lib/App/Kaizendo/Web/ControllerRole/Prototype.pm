package App::Kaizendo::Web::ControllerRole::Prototype;
use Moose::Role;
use namespace::autoclean;

requires qw/
  base
  /;

=head1 NAME

App::Kaizendo::Web::ControllerRole::Prototype

=cut

after base => sub {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world' );
};

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

1;
