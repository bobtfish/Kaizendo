#!/usr/bin/env perl
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use Class::MOP;
use Test::More;

BEGIN {
    my @needed = qw/
DBIx::Class::Optional::Dependencies
/;
    plan skip_all => "One of the required classes for this test $@ (" . join(',', @needed) . ") not found."
        unless eval {
            Class::MOP::load_class($_) for @needed; 1;
        };
    plan skip_all => 'Test needs ' . DBIx::Class::Optional::Dependencies->req_missing_for('deploy')
        unless DBIx::Class::Optional::Dependencies->req_ok_for('deploy');
}

use TestDatastore;

my $store = buildTestData(getTestDatastore());

use_ok 'Catalyst::Test', 'App::Kaizendo::Web';

ok( request('/')->is_success, 'Request should succeed' );
is( request('/hopefully/this/path/will/never/ever/work')->code,
    404, '404 for unknown path' );

done_testing();
