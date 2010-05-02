package App::Kaizendo::DataStore::ProjectSnapshot;
use Moose;
use Method::Signatures::Simple;
use MooseX::Types::Moose qw/ ArrayRef /;
use namespace::autoclean;

__PACKAGE__->meta->make_immutable;
1;
