package App::Kaizendo::DataStore::Project;
use Moose;
use Method::Signatures::Simple;
use namespace::autoclean;

has name => ( is => 'rw', required => 1 );

__PACKAGE__->meta->make_immutable;
