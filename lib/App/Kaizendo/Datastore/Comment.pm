package App::Kaizendo::Datastore::Comment;
use App::Kaizendo::Moose;  # Set up Moose for this package
use DateTime;

type 'DateTime' => as 'Object' => where { $_->isa('DateTime') };

class_type 'App::Kaizendo::Datastore::Project';
has project => ( is => 'ro', required => 1, isa => 'App::Kaizendo::Datastore::Project' );

# List of data points is from the Atom specification
# See RFC 4287, section 4.1 (Container Elements)
# and RFC 4685, section 3 (The 'in-reply-to' Extension Element)
has author         => ( is => 'ro', required => 1, isa => 'App::Kaizendo::Datastore::Person' );
has id             => ( is => 'ro', default  => 1 );  # FIXME: Generate unique Message-ID
has in_reply_to    => ( is => 'ro', isa => 'App::Kaizendo::Datastore::Comment' ); # FIXME: Pick a better way of referring to parents
has published_date => ( is => 'ro', isa => 'DateTime', default => sub { DateTime->now(); } );
has content        => ( is => 'ro', required => 1 );

__PACKAGE__->meta->make_immutable;
1;

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
