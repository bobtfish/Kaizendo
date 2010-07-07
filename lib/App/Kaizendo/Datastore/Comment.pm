package App::Kaizendo::Datastore::Comment;
use App::Kaizendo::Moose;  # Set up Moose for this package

class_type 'App::Kaizendo::Datastore::Project';
has project => ( is => 'ro', required => 1, isa => 'App::Kaizendo::Datastore::Project' );

# List of data points is from the Atom specification
has author    => ( is => 'ro', required => 1, isa => 'App::Kaizendo::Datastore::Person' );
has id        => ( is => 'ro', default  => 1 );  # FIXME: Generate unique Message-ID
has parent_id => ( is => 'ro' );
has published => ( is => 'ro' );  # FIXME: Should be DateTime
has content   => ( is => 'ro', required => 1 );

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
