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


# Every controller chains end up here at /base
sub base : Chained('/') PathPart('') CaptureArgs(0) {}

sub projects : Chained('base') PathPart('') Args(0) : ActionClass('REST') {
    my ( $self, $c ) = @_;
    $c->stash( projects => $c->model('Projects')->get_all_projects );
}

sub projects_GET { }

sub default : Chained('base') PathPart('') Args() { # Capture all args
    my ( $self, $c ) = @_;
    $c->detach('/error404');
}

sub error404 : Action {
    my ($self, $c) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head1 NAME

Kaizendo::Controller::Root - Root Controller for Kaizendo

=head1 DESCRIPTION

This is the root controller, which decides which actions are made based on
the URLs requested.

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


=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

__PACKAGE__->meta->make_immutable;

1;
