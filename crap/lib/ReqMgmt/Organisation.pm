package ReqMgmt::Organisation;
use Moose;
use MooseX::Types::Moose qw/Str ArrayRef/;
use KiokuDB::Util qw(set);
use namespace::autoclean;

with 'ReqMgmt::Id::Simple';

has name => ( isa => Str, is => 'ro' );

# FIXME - Why is this an ArrayRef, not a set?
has users => ( isa => ArrayRef, is => 'ro', default => sub { [] } );

has documents => ( does => 'KiokuDB::Set', default => sub { set() }, required => 1, is => 'ro');

sub _id_attribute { 'name' }

__PACKAGE__->meta->make_immutable;

