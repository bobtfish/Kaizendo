package App::Kaizendo::Web::ControllerRole::User;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

=head1 NAME

App::Kaizendo::Web::ControllerRole::User

=head1 METHODS

=head2 user_base

FIXME

=head2 user_list

List users

=cut

sub user_base : Chained('base') PathPart('_user') CaptureArgs(0) {
}

sub user_list : Chained('user_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world, this is ControllerRole::User user_list' );
}

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

1;
