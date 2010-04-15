package Mau5::Controller::Admin::Organisation;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Mau5::Controller' }

sub root : Chained('../organisation') PathPart('') CaptureArgs(0) {}

sub index_page : Chained('root') PathPart('') Args(0) {
    my ($self, $c) = @_;
    $c->forward('list');
    return unless $c->req->method eq 'POST';
    my $name = $c->req->body_params->{name};
    $c->model('Kioku')->new_organisation(
        name => $name,
    );
    $c->res->redirect( $c->uri_for( $self->action_for('view'), $name) );
}

sub list : Private {
    my ($self, $c) = @_;
    $c->stash->{orgs} = $c->model('Kioku')->get_all_organisations;
}

sub view : Chained('root') PathPart('') Args(1) {
    my ($self, $c, $name) = @_;
    $c->stash->{organisation}
        = $c->model('Kioku')->get_organisation_by_name($name);
}

__PACKAGE__->meta->make_immutable;

