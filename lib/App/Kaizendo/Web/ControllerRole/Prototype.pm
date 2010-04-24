package App::Kaizendo::Web::ControllerRole::Prototype;
use Moose::Role;
use namespace::autoclean;

requires qw/
  base
  /;

after base => sub {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world' );
};

1;
