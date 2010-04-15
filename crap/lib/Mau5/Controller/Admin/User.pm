package Mau5::Controller::Admin::User;
use Moose;
use KiokuX::User::Util qw(crypt_password);
use namespace::autoclean;

BEGIN { extends 'Mau5::Controller' }

sub root : Chained('../user') PathPart('') CaptureArgs(0) {}

sub index_page : Chained('root') PathPart('') Args(0) {
    my ($self, $c) = @_;
    $c->stash->{organisations} = $c->model('Kioku')->get_all_organisations;

    return unless $c->req->method eq 'POST';
    my ($name, $org_name) = map { $c->req->body_params->{$_} }
        qw/name organisation_name/;


    if ($c->req->body_params->{password} eq $c->req->body_params->{password2}) {
        eval {
            $c->model('Kioku')->new_user(
                id => $name,
                organisation => $org_name,
                password => crypt_password($c->req->body_params->{password}),
                (map { $_ => $c->req->body_params->{$_} } qw/admin firstname surname/),
            );
        };
        if (!$@) {
            my $uri = $c->uri_for_action('/admin/organisation/index_page', [], $org_name);
            $c->res->redirect($uri);
        }
        else {
            $c->stash->{error} = $@;
        }
    }
    else {
        $c->stash->{error} = "Passwords do not match";
    }
}

__PACKAGE__->meta->make_immutable;

