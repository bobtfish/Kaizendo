package App::Kaizendo::DataStore::Project;
use Moose;
use Method::Signatures::Simple;
use MooseX::Types::Moose qw/ ArrayRef /;
use namespace::autoclean;

use aliased 'App::Kaizendo::DataStore::Chapter';

has name => ( is => 'rw', required => 1 );
has chapters => (
    is => 'ro', isa => ArrayRef, default => sub { [] },
    traits     => ['Array'],
    handles => {
        no_of_chapters => 'count',
        get_chapter_by_number => 'get',
        _add_chapter => 'push',
    } );

method add_chapter (%args) {
    # FIXME - persist
    my $chapter = Chapter->new( project => $self, number => $self->no_of_chapters + 1, text => $args{text} );
    $self->_add_chapter($chapter);
    return $chapter;
}

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
