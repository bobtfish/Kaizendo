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
