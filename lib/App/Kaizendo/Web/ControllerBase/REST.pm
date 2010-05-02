package App::Kaizendo::Web::ControllerBase::REST;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
    default   => 'text/html',
    stash_key => 'rest',
    map       => {
        'text/html'        => [ 'View', 'HTML', ],
        'application/json' => 'JSON',
        'text/x−json'    => 'JSON',
    },
);

=head1 NAME

App::Kaizendo::Web::ControllerBase::REST

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

__PACKAGE__->meta->make_immutable;
