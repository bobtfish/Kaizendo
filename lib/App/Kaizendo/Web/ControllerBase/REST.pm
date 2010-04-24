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

__PACKAGE__->meta->make_immutable;
