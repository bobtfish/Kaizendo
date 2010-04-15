package Mau5::View::Docbook;
use Mau5 ();
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';
#with qw/Catalyst::View::ContentNegotiation::XHTML/;

after 'process' => sub {
    my ($self, $c) = @_;
    $c->res->content_type('text/xml');
};

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.xml.tt',
    WRAPPER => 'wrapper.xml.tt',
    RECURSION => 1,
    INCLUDE_PATH => [
        Mau5->path_to( 'root', 'docbook' ),
    ],
);

__PACKAGE__->meta->make_immutable(inline_constructor => 0);

