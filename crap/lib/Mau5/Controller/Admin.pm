package Mau5::Controller::Admin;
use Moose;
use KiokuX::User::Util qw(crypt_password);
use namespace::autoclean;

BEGIN { extends 'Mau5::Controller' }

sub dashboard : Private {
    my ($self, $c) = @_;
    $c->forward('/admin/organisation/list');
}

sub root : Chained('/root') PathPart('') CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->res->redirect($c->uri_for('/'))
        unless ($c->user && $c->user->get_object->admin);
}

sub admin : Chained('root') PathPart('admin') CaptureArgs(0) {}

sub organisation : Chained('admin') PathPart('organisation') CaptureArgs(0) {}

sub user : Chained('admin') PathPart('user') CaptureArgs(0) {}

__PACKAGE__->meta->make_immutable;

