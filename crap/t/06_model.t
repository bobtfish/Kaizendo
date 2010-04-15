#!/usr/bin/env perl
use strict;
use lib 't/lib';
use ReqMgmt::Document;
use ReqMgmt::Person;
use Scalar::Util qw/refaddr/;
use Test::More tests => 9;

use Test::Exception;
use TestModel qw/TestModel/;

my $model = TestModel;

my $uid = 'test@test.com';
lives_ok {
    my $scope = $model->new_scope;
    my $person = $model->get_user_by_uid($uid);
    ok($person, 'Can get a user for test@test.com');
    my $document = $model->get_by_simple_id('Document', 'A document');
    ok($document);
    my @documents = $model->get_all_projects;
    ok( scalar(@documents), 'Have projects' );    
} 'Lives';

lives_ok {
    my $name = 'NewOrg';
    my $scope = $model->new_scope;
    my $org = $model->new_organisation( name => $name );
    my $org_from_model = $model->get_organisation_by_name( $name );
    ok $org, 'Have new org';
    is $org->kiokudb_object_id, 'ReqMgmt::Organisation::' . $name;
    ok $org_from_model, 'Have org from model';
    is refaddr($org), refaddr($org_from_model), 'They are the same';
} 'Lives';

