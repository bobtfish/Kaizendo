#!/usr/bin/env perl
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use Test::More;

use TestDataStore;

my $store = buildTestData(getTestDataStore());

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
    /TestProject/a_section
    /TestProject/a_section/;
    /TestProject/a_section/_user
    /TestProject/a_section/_c
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
