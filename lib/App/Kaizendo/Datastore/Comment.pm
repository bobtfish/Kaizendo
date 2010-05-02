package App::Kaizendo::DataStore::Comment;
use Moose;
use Method::Signatures::Simple;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

class_type 'App::Kaizendo::DataStore::Project';
has project => ( is => 'ro', required => 1, isa => 'App::Kaizendo::DataStore::Project' );
has text => ( is => 'ro', required => 1 );

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
