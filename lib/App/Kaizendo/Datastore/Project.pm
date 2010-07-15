package App::Kaizendo::Datastore::Project;
use App::Kaizendo::Moose;  # Set up Moose for this package
use MooseX::Types::Moose qw/ ArrayRef /;

use aliased 'App::Kaizendo::Datastore::ProjectSnapshot';

# A Project has ProjectSnapshots, and ProjectSnapshots have a Project.
# So to avoid circular class refereneces, we Predeclare type
class_type 'App::Kaizendo::Datastore::ProjectSnapshot';

has name => ( is => 'rw', required => 1 );

has snapshots => (
    is => 'ro',
    isa => ArrayRef,
    default => sub {
        my $self = shift;
        return [
            ProjectSnapshot->new(project => $self, tag => "Initial commit"),
        ];
    },
    traits     => ['Array'], # See Moose::Meta::Attribute::Native::Trait::Array
    handles => {
        _add_snapshot => 'push',
    },
);


method latest_snapshot { $self->snapshots->last }

method earliest_snapshot { $self->snapshots->first }

method next_snapshot {
    my $index = $self->snapshots->at;
    $index++ unless $index == $self->snapshots->length;
    $self->snapshots->get($index);
}

method prev_snapshot {
    my $index = $self->snapshots->at;
    $index-- unless $index == 0;
    $self->snapshots->get($index);
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::Datastore::Project - The Kaizendo project class description

=head1 DESCRIPTION

This class is the top level storage class

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
