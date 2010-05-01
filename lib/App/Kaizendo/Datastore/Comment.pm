package App::Kaizendo::DataStore::Comment;
use Moose;
use Method::Signatures::Simple;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

class_type 'App::Kaizendo::DataStore::Document';
has document => ( is => 'ro', required => 1, isa => 'App::Kaizendo::DataStore::Document' );
has text => ( is => 'ro', required => 1 );

__PACKAGE__->meta->make_immutable;
