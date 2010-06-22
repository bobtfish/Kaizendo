package App::Kaizendo::Web::Controller::Aspect;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';

sub base : Chained('/base') PathPart(';') CaptureArgs(0) {
}

sub list : Chained('base') PathPart('') Args(0) {
}

__PACKAGE__->meta->make_immutable;

=head1 NAME

App::Kaizendo::Web::Controller::Aspect

=head1 METHODS

=head2 base

FIXME

=head2 list

FIXME

=cut

sub list : Chained('base') PathPart('') Args(0) {
}

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
