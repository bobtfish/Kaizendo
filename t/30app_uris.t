#!/usr/bin/env perl
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use Class::MOP;
use Test::More;

use TestDatastore;

my $store = buildTestData(getTestDatastore());

use Catalyst::Test 'App::Kaizendo::Web';

foreach my $uri (
    qw{
    /
    /;
    /_c
    /_user
    /TestProject
    /TestProject/;
    /TestProject/_user
    /TestProject/_c
    /TestProject/1
    /TestProject/1/;
    /TestProject/1/_user
    /TestProject/1/_c
    }
  )
{
    test_uri($uri);
}

sub test_uri {
    my $uri = shift || '';
    ok( request($uri)->is_success, "Request to $uri should succeed" );
}

done_testing();
