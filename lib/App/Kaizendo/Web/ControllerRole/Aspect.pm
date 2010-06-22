package App::Kaizendo::Web::ControllerRole::Aspect;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

=head1 NAME

App::Kaizendo::Web::ControllerRole::Aspect

=head1 METHODS

=head2 aspect_base

FIXME

=cut

sub aspect_base : Chained('base') PathPart(';') CaptureArgs(0) {
}

=head2 aspect_list

FIXME

=cut

sub aspect_list : Chained('aspect_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world, this is ControllerRole::Aspect list' );
}

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Tomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

1;
