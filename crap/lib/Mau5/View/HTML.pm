package Mau5::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';
#with qw/Catalyst::View::ContentNegotiation::XHTML/;

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    WRAPPER => 'wrapper.tt',
    RECURSION => 1,
);

__PACKAGE__->meta->make_immutable(inline_constructor => 0);

