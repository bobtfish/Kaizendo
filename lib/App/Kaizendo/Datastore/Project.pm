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
    } );

method add_chapter (%args) {
    # FIXME - persist
    Chapter->new( project => $self, number => $self->no_of_chapters + 1, text => $args{text} );
}

__PACKAGE__->meta->make_immutable;
1;
