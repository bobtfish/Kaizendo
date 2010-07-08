package App::Kaizendo::Datastore::Section;
use App::Kaizendo::Moose;  # Set up Moose for this package
use MooseX::Types::Moose qw/ Int /;

class_type 'App::Kaizendo::Datastore::Project';

# Content attributes taken from the Atom spec
# RFC 4287, section 4.1.2  -- http://www.ietf.org/rfc/rfc4287.txt
has project => ( is => 'ro', required => 1, isa => 'App::Kaizendo::Datastore::Project', weak_ref => 1 );
has author => ( isa => 'App::Kaizendo::Datastore::Person', is => 'rw', required => 1 );
has content => ( is => 'rw' );
#has contributor => ( is => 'rw', isa 'Array[Author]' ); # FIXME: Set up contributor type
has id => ( isa => Int, is => 'rw', required => 1 );
has published => ( is => 'rw', isa => 'DateTime' );
has rights => ( is => 'rw' ); # License information
has summary => ( is => 'rw' );
has title => ( is => 'rw' );
has updated => ( is => 'rw', isa => 'DateTime', default => sub { DateTime->now(); } );

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::Datastore::Section - The basic section storage class

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
