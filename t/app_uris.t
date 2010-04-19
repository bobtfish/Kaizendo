#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'App::Kaizendo::Web';

foreach my $uri (qw{
    /
    /;
    /_c
    /_user
    /project_name
    /project_name/;
    /project_name/_user
    /project_name/_c
    /project_name/a_section
    /project_name/a_section/;
    /project_name/a_section/_user
    /project_name/a_section/_c
}) { test_uri($uri) }

sub test_uri {
    my $uri = shift || '';
    ok( request($uri)->is_success, "Request to $uri should succeed" );
}

done_testing();
