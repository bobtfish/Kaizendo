package App::Kaizendo::Web::ControllerRole::User;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

=head1 NAME

App::Kaizendo::Web::ControllerRole::User

=head1 METHODS

=head2 user_base

FIXME

=cut

sub user_base : Chained('base') PathPart('_user') CaptureArgs(0) {
}

=head2 user_list

List users

=cut

sub user_list : Chained('user_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world _user' );
}

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

1;
