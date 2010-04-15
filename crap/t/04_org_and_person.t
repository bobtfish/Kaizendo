#!/usr/bin/env perl
use strict;
use lib 't/lib';
use ReqMgmt::Storage;
use ReqMgmt::Person;
use Test::More tests => 13;
use KiokuX::User::Util qw(crypt_password);
use TestModel qw/TestModel TestModelUnlink/;
TestModelUnlink;
my $model = TestModel;

{
    my $scope = $model->new_scope;

    my $organisation = ReqMgmt::Organisation->new(
        name => 'Mau5',
    );
    my $admin = $model->new_user(
        id => 'test@test.com',
        organisation => $organisation,
        password => crypt_password('test'),
        admin => 1,
        firstname => 'Admin',
        surname => 'McTest',
    );
    my $user = $model->new_user(
        id => 'test2@test.com',
        organisation => $organisation,
        password => crypt_password('test'),
        firstname => 'Testy',
        surname => 'McTest',
    );
    $model->store($organisation);
    $model->store($admin);
    $model->store($user);	
}
{
    my $scope = $model->new_scope;
    my $orgs = $model->get_all_organisations;
    is ref($orgs), 'ARRAY';
    is scalar(@$orgs), 1, 'An org';
    is $orgs->[0]->name, 'Mau5', 'Is called Mau5';
    is $orgs->[0]->kiokudb_object_id, 'ReqMgmt::Organisation::Mau5';
}
{
    my $scope = $model->new_scope;
    my $person = $model->get_user_by_uid('test@test.com');
    ok($person, 'Got user test@test.com by uid');
    isa_ok($person, 'ReqMgmt::Person');
    is($person->id, 'test@test.com');
    is($person->organisation->name, 'Mau5');
    ok($person->admin, 'Is admin');
}
{
    my $scope = $model->new_scope;
    my $person = $model->get_user_by_uid('test2@test.com');
    ok($person, 'Got user test2@test.com by uid');
    is($person->id, 'test2@test.com');
    ok(!$person->admin, 'Is NOT admin');
}
{
    my $scope = $model->new_scope;
    my $set = $model->root_set;
    my $entries = 0;
    while (my $item = $set->next) {
        $entries++;
    }
    ok( $entries > 0, $entries . ' entries in the root set' );
}

