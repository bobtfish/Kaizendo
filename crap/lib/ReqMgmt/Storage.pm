package ReqMgmt::Storage;
use Moose;
use Method::Signatures::Simple;
use namespace::clean -except => 'meta';

extends qw(KiokuX::Model);

method get_user_by_uid ($uid) {
    $self->lookup("user:$uid");
}

sub new_user {
    my $self = shift;
    my $args = $self->BUILDARGS(@_);
    my $class = delete $args->{user_class} || 'ReqMgmt::Person';
    $args->{organisation} = $self->get_organisation_by_name(
        $args->{organisation}) if !blessed($args->{organisation});
    die("Duplicate user id") if $self->get_user_by_uid($args->{id});
    my $user = $class->new($args);
    $self->store($user);
    push(@{$args->{organisation}->users}, $user);
    $self->store($args->{organisation});
    return $user;
}

method get_by_simple_id ($class, $id) {
    $self->lookup('ReqMgmt::' . $class . '::' . $id);
}


method get_project_by_name ($name) {
    $self->get_by_simple_id('Document', $name);
}

method get_organisation_by_name ($name) {
    $self->get_by_simple_id('Organisation', $name);
}

sub new_organisation {
    my $self = shift;
    my $args = $self->BUILDARGS(@_);
    my $class = delete $args->{user_class} || 'ReqMgmt::Organisation';
    my $org = $class->new($args);
    $self->store($org);
    return $org;
}

method get_all_organisations {
    my $bulk = $self->root_set;
    my @all = grep { $_->isa('ReqMgmt::Organisation') } $bulk->all;
    return [ @all ];
}

method get_all_projects {
    my $bulk = $self->root_set;
    my @all = grep { $_->isa('ReqMgmt::Document') } $bulk->all;
    return [ @all ];
}

with 'ReqMgmt::Storage::API';

__PACKAGE__->meta->make_immutable;

