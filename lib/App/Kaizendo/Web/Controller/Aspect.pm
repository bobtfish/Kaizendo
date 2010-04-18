package App::Kaizendo::Web::Controller::Aspect;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';

sub base : Chained('/base') PathPart(';') CaptureArgs(0) {}

sub list : Chained('base') PathPart('') Args(0) {}

__PACKAGE__->meta->make_immutable;
