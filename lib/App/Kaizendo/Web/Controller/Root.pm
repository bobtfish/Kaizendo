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


sub base : Chained('/') PathPart('') CaptureArgs(0) {
}

sub index : Chained('base') PathPart('') Args(0) : ActionClass('REST') {
    my ( $self, $c ) = @_;
    $c->stash( projects => $c->model('Projects')->get_all_projects );
}

sub index_GET { }

sub default : Chained('base') PathPart('') Args() {
    my ( $self, $c ) = @_;
    $c->detach('/error404');
}

sub error404 : Action {
    my ($self, $c) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

sub serialize : ActionClass('Serialize') {}

sub end : Action {
    my ( $self, $c ) = @_;
    $c->forward('serialize')
      unless $c->response->body;
    die("Forced debug") if $c->debug && $c->request->param('')
}

=head1 NAME

Kaizendo::Controller::Root - Root Controller for Kaizendo

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 base

FIXME

=head2 index

The root page (/). List (projects).

=head2 index_GET

The root page (/) GET handler

=head2 default

Standard 404 error page

=head2 serialize

Causes the REST serialization of the output.

=head2 end

Forwards to content serializer if there's no response body

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

__PACKAGE__->meta->make_immutable;

1;
