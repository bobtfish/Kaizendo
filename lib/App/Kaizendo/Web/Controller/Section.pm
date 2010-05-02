package App::Kaizendo::Web::Controller::Section;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';
with qw/
  App::Kaizendo::Web::ControllerRole::Aspect
  App::Kaizendo::Web::ControllerRole::User
  App::Kaizendo::Web::ControllerRole::Comment
  /;

sub base : Chained('/project/item') PathPart('') CaptureArgs(0) {
}

sub item : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $chapter_no ) = @_;
    my $chapter = $c->stash->{project}->latest_snapshot->get_chapter_by_number($chapter_no)
        or $c->detach('/error404');
    $c->stash(chapter => $chapter);
}


sub view : Chained('item') PathPart('') Args(0) {
}

__PACKAGE__->config(
    action => {
        aspect_base  => { Chained => 'item' },
        user_base    => { Chained => 'item' },
        comment_base => { Chained => 'item' },
    },
);

=head1 NAME

App::Kaizendo::Web::Controller::Section

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
