package App::Kaizendo::DataStore::Comment;
use Moose;
use Method::Signatures::Simple;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

class_type 'App::Kaizendo::DataStore::Project';
has document => ( is => 'ro', required => 1, isa => 'App::Kaizendo::DataStore::Project' );
has text => ( is => 'ro', required => 1 );

__PACKAGE__->meta->make_immutable;
1;
