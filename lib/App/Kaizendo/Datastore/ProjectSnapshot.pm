package App::Kaizendo::Datastore::ProjectSnapshot;
use App::Kaizendo::Moose;  # Set up Moose environment
use MooseX::Types::Moose qw/ ArrayRef /;

use aliased 'App::Kaizendo::Datastore::Section';

# Predeclare type to avoid circular class refereneces
class_type 'App::Kaizendo::Datastore::Project'; 

has project => (
    isa => 'App::Kaizendo::Datastore::Project',
    is => 'ro',
    required => 1,
    handles => [qw/
        name
    /],
    weak_ref => 1,
);

has sections => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [] },
    traits     => ['Array'],
    handles => {
        no_of_sections => 'count',
        get_section_by_number => 'get',
    },
);

around get_section_by_number => sub {
    my ($orig, $self, $no) = @_;
    $self->$orig($no - 1);  # Sections start at 1, arrays at 0
};

method append_section (%args) {

    # Set up new section object
    my $new_section = Section->new(
        project => $self->project,
        id      => $self->no_of_sections + 1,
        content => $args{content},
        author  => $args{author}, );

    my $new_snapshot = blessed($self)->new(
        project => $self->project,
        sections => [
            $self->sections->flatten,
            $new_section, # Append section
        ],
    );
    $self->project->_add_snapshot($new_snapshot);
    return $new_snapshot;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::Datastore::ProjectSnapshot - A project at a specific point in time

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
