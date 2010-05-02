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
        _add_chapter => 'push',
    },
);

method add_chapter (%args) {
    my $chapter = Chapter->new( project => $self->project, number => $self->no_of_chapters + 1, text => $args{text} );
    $self->_add_chapter($chapter);
    return $chapter;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::DataStore::ProjectSnapshot - A projecr at a specific point in time

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
