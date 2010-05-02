package App::Kaizendo::DataStore::Chapter;
use App::Kaizendo::Moose;
use MooseX::Types::Moose qw/ Int HashRef /;

class_type 'App::Kaizendo::DataStore::Project';
has project => ( is => 'ro', required => 1, isa => 'App::Kaizendo::DataStore::Project', weak_ref => 1 );
has number => ( isa => Int, is => 'rw', required => 1 );
has aspects => ( isa => HashRef, default => sub { {} } );

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
