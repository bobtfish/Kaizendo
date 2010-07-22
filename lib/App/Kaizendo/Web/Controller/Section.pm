package App::Kaizendo::Web::Controller::Section;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with qw/
  App::Kaizendo::Web::ControllerRole::Aspect
  App::Kaizendo::Web::ControllerRole::User
  App::Kaizendo::Web::ControllerRole::Comment
  /;

=head1 NAME

App::Kaizendo::Web::Controller::Section

=head1 METHODS

=head2 base

FIXME

=cut

sub base : Chained('/project/section') PathPart('') CaptureArgs(0) {
}

=head2 section

FIXME

=cut

sub section : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $section_no ) = @_;
    my $section = $c->stash->{project}->get_section_by_number($section_no)
        or $c->detach('/error404');
    $c->stash(section => $section);
}


sub content : Chained('section') PathPart('') Args(0) {
}

__PACKAGE__->config(
    action => {
        aspect_base  => { Chained => 'section' },
        user_base    => { Chained => 'section' },
        comment_base => { Chained => 'section' },
    },
);

=head1 NAME

App::Kaizendo::Web::Controller::Section

=head1 METHODS

=head2 base

FIXME

=head2 section

FIXME

=head2 content

FIXME

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

__PACKAGE__->meta->make_immutable;
