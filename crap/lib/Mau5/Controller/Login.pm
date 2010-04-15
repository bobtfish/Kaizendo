package Mau5::Controller::Login;
use Moose;
use Moose::Autobox;
use namespace::clean -except => 'meta';

BEGIN { extends 'Mau5::Controller' }

sub login : Chained('/root') PathPart('login') Args(0) {
    my ($self, $c) = @_;
    $c->res->redirect($c->uri_for('/'))
        if $c->user;
    $c->detach('do_login') if $c->req->method eq 'POST';
}

sub do_login : Private {
    my ($self, $c) = @_;
    $c->detach('/error400') unless $c->req->method eq 'POST';
    if ($c->authenticate({
        id => [ $c->req->body_parameters->{'email'}->flatten ]->[0],
        password => [ $c->req->body_parameters->{'password'}->flatten ]->[0],
    })) {
        $c->res->redirect($c->uri_for('/'));
    }
    else {
        $c->stash->{email} = $c->req->param('email'); # FIXME XSS
        $c->stash->{login_failed} = 1;
    };
}

sub logout : Chained('/root') PathPath('logout') Args(0) {
    my ($self, $c) = @_;
    $c->logout;
    $c->res->redirect($c->uri_for('/'));
}

__PACKAGE__->meta->make_immutable;

