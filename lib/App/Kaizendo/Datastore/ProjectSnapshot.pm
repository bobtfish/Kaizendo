package App::Kaizendo::DataStore::ProjectSnapshot;
use App::Kaizendo::Moose;
use MooseX::Types::Moose qw/ ArrayRef /;

use aliased 'App::Kaizendo::DataStore::Chapter';

class_type 'App::Kaizendo::DataStore::Project';
has project => (
    isa => 'App::Kaizendo::DataStore::Project',
    is => 'ro',
    required => 1,
    handles => [qw/
        name
    /],
    weak_ref => 1,
);

has chapters => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [] },
    traits     => ['Array'],
    handles => {
        no_of_chapters => 'count',
        get_chapter_by_number => 'get',
    },
);

around get_chapter_by_number => sub {
    my ($orig, $self, $no) = @_;
    $self->$orig($no - 1);
};

method add_chapter (%args) {
    my $new_chapter = Chapter->new( project => $self->project, number => $self->no_of_chapters + 1, text => $args{text} );
    my $new_snapshot = blessed($self)->new(
        project => $self->project,
        chapters => [
            $self->chapters->flatten,
            $new_chapter,
        ],
    );
    $self->project->_add_snapshot($new_snapshot);
    return $new_snapshot;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::DataStore::ProjectSnapshot - A projecr at a specific point in time

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
