package App::Kaizendo::Web::ControllerRole::Prototype;
use Moose::Role;
use namespace::autoclean;

requires qw/
  base
  /;

after base => sub {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world, this is ControllerRole::Prototype' );
};

=head1 NAME

App::Kaizendo::Web::ControllerRole::Prototype

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

1;
