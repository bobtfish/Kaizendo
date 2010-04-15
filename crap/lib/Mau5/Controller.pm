package Mau5::Controller;
use Moose;
use namespace::clean -except => 'meta';
BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
     'stash_key' => 'rest',
     'map'       => {
        'text/html'          => [qw/ View HTML/],
        'application/json'   => 'JSON',
        'text/x-json'        => 'JSON',
    },
);

__PACKAGE__->meta->make_immutable;
