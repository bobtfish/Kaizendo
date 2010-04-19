package App::Kaizendo::Web::ControllerRole::User;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

sub user_base : Chained('base') PathPart('_user') CaptureArgs(0) {}

sub user_list : Chained('user_base') PathPart('') Args(0) {
    my ($self, $c) = @_;
    $c->stash(template => \'Hello world _user');
}

1;
