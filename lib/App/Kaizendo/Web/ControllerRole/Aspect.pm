package App::Kaizendo::Web::ControllerRole::Aspect;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

sub aspect_base : Chained('base') PathPart(';') CaptureArgs(0) {
}

=head1 NAME

App::Kaizendo::Web::ControllerRole::Aspect

=head1 METHODS

=head2 aspect_base

FIXME

=head2 aspect_list

FIXME

=cut

sub aspect_list : Chained('aspect_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world, this is ControllerRole::Aspect list' );
}

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

1;
