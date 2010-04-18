#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'App::Kaizendo::Web';

foreach my $uri (qw{
    /
    /;
    /_c
    /project_name
    /project_name/;
}) { test_uri($uri) }

sub test_uri {
    my $uri = shift || '';
    ok( request($uri)->is_success, "Request to $uri should succeed" );
}

done_testing();
