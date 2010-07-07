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
            ProjectSnapshot->new(project => $self),
        ];
    },
    traits     => ['Array'],
    handles => {
        _add_snapshot => 'push',
    },
);

method latest_snapshot { $self->snapshots->last }

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::Datastore::Project - The Kaizendo project class description

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
