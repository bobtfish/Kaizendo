package App::Kaizendo::Web::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with qw/
  App::Kaizendo::Web::ControllerRole::Aspect
  App::Kaizendo::Web::ControllerRole::User
  App::Kaizendo::Web::ControllerRole::Comment
  /;

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=head1 NAME

Kaizendo::Controller::Root - Root Controller for Kaizendo

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 base

FIXME

=cut

sub base : Chained('/') PathPart('') CaptureArgs(0) {
}

=head2 index

The root page (/). List (projects).

=cut

sub index : Chained('base') PathPart('') Args(0) : ActionClass('REST') {
    my ( $self, $c ) = @_;
    $c->stash( projects => $c->model('Projects')->get_all_projects );
}

=head2 index_GET

The root page (/) GET handler

=cut

sub index_GET { }

=head2 default

Standard 404 error page

=cut

sub default : Chained('base') PathPart('') Args() {
    my ( $self, $c ) = @_;
    $c->detach('/error404');
}

sub error404 : Action {
    my ($self, $c) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 serialize

Causes the REST serialization of the output.

=cut

sub serialize : ActionClass('Serialize') {}

=head2 end

Forwards to content serializer if there's no response body

=cut

sub end : Action {
    my ( $self, $c ) = @_;
    $c->forward('serialize')
      unless $c->response->body;
    die("Forced debug") if $c->debug && $c->request->param('')
}

=head1 AUTHOR

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

__PACKAGE__->meta->make_immutable;

1;
