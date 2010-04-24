package App::Kaizendo::Web::ControllerRole::Aspect;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

sub aspect_base : Chained('base') PathPart(';') CaptureArgs(0) {
}

sub aspect_list : Chained('aspect_base') PathPart('') Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( template => \'Hello world ASPECT' );
}

1;
