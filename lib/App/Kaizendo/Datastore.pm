package App::Kaizendo::Datastore;
use Moose;
use Method::Signatures::Simple;
use Moose::Autobox;
use namespace::autoclean;

extends qw/ KiokuX::Model /;
with qw/ KiokuDB::Role::API /;

# Hack to delete Catalyst::Model::KiokuDB methods that were passed down
around BUILDARGS => sub {
    my ($orig, $self) = (shift, shift);
    my $args = $self->$orig(@_);
    delete $args->{$_} for qw/ clear_leaks manage_scope model_class /; # Ewww
    return $args;
};

# Get all the available projects
method get_all_projects { # Please pay no attention to the contents of this method, it needs to die :)
    my $bulk = $self->root_set;
    my @all = grep { $_->isa('App::Kaizendo::Datastore::Project') } $bulk->all;
    return [ @all ];
}

# Get a specific project
method get_project_by_name ($name) {
    (grep { $_->name eq $name } $self->get_all_projects->flatten)[0];
}

__PACKAGE__->meta->make_immutable;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
