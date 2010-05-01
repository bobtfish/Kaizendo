package App::Kaizendo::Datastore;
use Moose;
use Method::Signatures::Simple;
use namespace::autoclean;

extends qw/ KiokuX::Model /;
with qw/ KiokuDB::Role::API /;

__PACKAGE__->meta->make_immutable;
