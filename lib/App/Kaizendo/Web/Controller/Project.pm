package App::Kaizendo::Web::Controller::Project;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';
with qw/
    App::Kaizendo::Web::ControllerRole::Aspect
    App::Kaizendo::Web::ControllerRole::User
    App::Kaizendo::Web::ControllerRole::Comment
/;

sub base : Chained('/base') PathPart('') CaptureArgs(0) {}

sub item : Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $project_name) = @_;
}

sub view : Chained('item') PathPart('') Args(0) {}

__PACKAGE__->config(
    action => {
        aspect_base => { Chained => 'item' },
        user_base => { Chained => 'item' },
        comment_base => { Chained => 'item' },
    },
);

__PACKAGE__->meta->make_immutable;
