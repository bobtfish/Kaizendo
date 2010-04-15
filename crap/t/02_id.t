#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;

use ReqMgmt::Id ();
use ReqMgmt::Id::Simple ();

ok( ReqMgmt::Id->meta->does_role('KiokuDB::Role::ID') );
ok( ReqMgmt::Id::Simple->meta->does_role('ReqMgmt::Id') );

lives_ok {
    package Some::Class;
    use Moose;
    with 'ReqMgmt::Id::Simple';
    has id => ( isa => 'Int', required => 1, is => 'ro' );
    sub _id_attribute { 'id' }
} 'Can compose';

my $i = Some::Class->new(id => 1);
is( $i->kiokudb_object_id, 'Some::Class::1' );

