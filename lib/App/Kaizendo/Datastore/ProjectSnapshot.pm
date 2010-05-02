package App::Kaizendo::DataStore::ProjectSnapshot;
use Moose;
use Method::Signatures::Simple;
use MooseX::Types::Moose qw/ ArrayRef /;
use namespace::autoclean;

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::DataStore::ProjectSnapshot - A projecr at a specific point in time

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
