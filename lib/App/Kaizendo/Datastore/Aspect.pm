package App::Kaizendo::DataStore::Aspect;
use App::Kaizendo::Moose;

class_type 'App::Kaizendo::DataStore::Chapter';
has chapter => ( is => 'ro', isa => 'App::Kaizendo::DataStore::Chapter', required => 1 );
has name => ( is => 'ro', default => 'main' );
has text => ( is => 'rw', required => 1 );

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
