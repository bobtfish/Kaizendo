#!/usr/bin/env perl
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use Class::MOP;
use Test::More;

use TestDatastore;

my $store = buildTestData(getTestDatastore());

use_ok 'Catalyst::Test', 'App::Kaizendo::Web';

ok( request('/')->is_success, 'Request should succeed' );
is( request('/hopefully/this/path/will/never/ever/work')->code,
    404, '404 for unknown path' );

done_testing();
