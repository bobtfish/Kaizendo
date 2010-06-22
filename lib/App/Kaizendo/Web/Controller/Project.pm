package App::Kaizendo::Web::Controller::Project;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with qw/
  App::Kaizendo::Web::ControllerRole::Aspect
  App::Kaizendo::Web::ControllerRole::User
  App::Kaizendo::Web::ControllerRole::Comment
  /;


sub base : Chained('/base') PathPart('') CaptureArgs(0) {
}

=head2 section

FIXME

=cut

sub section : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $project_name ) = @_;
    my $project = $c->model('Projects')->get_project_by_name( $project_name )
        or $c->detach('/error404');
    $c->stash( project => $project->latest_snapshot );
}

sub view : Chained('section') PathPart('') Args(0) {
}

__PACKAGE__->config(
    action => {
        aspect_base  => { Chained => 'section' },
        user_base    => { Chained => 'section' },
        comment_base => { Chained => 'section' },
    },
);

=head1 NAME

Kaizendo::Controller::Project - Project Controller for Kaizendo

=head1 DESCRIPTION

Handles information about the individual text project.

=head1 METHODS

=head2 base

FIXME

=head2 item

FIXME

=head2 view

FIXME

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

__PACKAGE__->meta->make_immutable;
