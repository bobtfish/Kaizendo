package App::Kaizendo::DataStore::Chapter;
use Moose;
use Method::Signatures::Simple;
use MooseX::Types::Moose qw/ Int /;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

class_type 'App::Kaizendo::DataStore::Project';
has project => ( is => 'ro', required => 1, isa => 'App::Kaizendo::DataStore::Project', weak_ref => 1 );
has number => ( isa => Int, is => 'rw', required => 1 );
has text => ( is => 'rw' );

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
