package App::Kaizendo::Web::Controller::Project;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';

sub base : Chained('/base') PathPart('') CaptureArgs(0) {}

sub item : Chained('base') PathPart('') CaptureArgs(1) {
    my ($self, $c, $project_name) = @_;
}

sub view : Chained('item') PathPart('') Args(0) {}

sub view_aspects : Chained('item') PathPart(';') Args(0) {}

__PACKAGE__->meta->make_immutable;
