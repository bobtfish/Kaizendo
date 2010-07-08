#!/usr/bin/env perl
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use Class::MOP;
use Test::More;
use HTTP::Request;

use TestDatastore;
my $store = buildTestData(getTestDatastore());

use Catalyst::Test 'App::Kaizendo::Web';


# Basic tests
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
    returns_success($uri);
}

# The REST API spec that these tests are based on can be found here:
# <http://spreadsheets.google.com/pub?key=tw0LE2wYspa8DyUaJVVwm_A>

# User URL tests
foreach my $test (
      [[ GET  => '/_user', 'text/html' ], [ 200 ]],
      [[ POST => '/_user', 'application/x-www-form-urlencoded', { id => 'fnord' } ],
       [ 201  => q'/_user/fnord' ]],
      [[ GET  => '/_user/fnord', 'text/html' ], [ 200 ]],
  )
{
    my $test_request      = $test->[0];
    my $expected_reply    = $test->[1];
    my $expected_code     = $expected_reply->[0];
    my $expected_type     = $test->[0]->[2]; # Same as request
    my $expected_location = $expected_reply->[1] || $test->[0]->[1]; # Default: no location change

    my $response = do_request($test_request);

    TODO: {
        local $TODO = 'No /_user handling yet.'; 
        is( $response->code, $expected_code, "Response has code $expected_code" );
        is( $response->content_type, $expected_type, "Response has content-type $expected_type");
        is( $response->header('Location'), $expected_location, "Response redirects to $expected_location");
    }

}

sub do_request {
    my( $req_data ) = shift;
    my $req_method  = $req_data->[0];
    my $req_uri     = $req_data->[1];
    my $req_type    = $req_data->[2] || '';
    my $req_content = $req_data->[3] || '';

    # Set up request headers in order to fetch the wanted data
    my $wanted_data = HTTP::Request->new( $req_method => $req_uri );
    $wanted_data->header(Accept => $req_type) if $req_type;
    $wanted_data->content($req_content) if $req_content;

    request( $wanted_data ); # Do the mambo, then pass on the response
}

sub returns_success {
    my $uri = shift || '';
    ok( request($uri)->is_success, "Request to $uri should succeed" );
}

done_testing();

