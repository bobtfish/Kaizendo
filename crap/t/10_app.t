use strict;
use warnings;
use HTTP::Request::Common;
use Test::More tests => 5;

BEGIN { use_ok 'Catalyst::Test', 'Mau5' }

ok( request('/')->is_success, 'Request / should succeed' );

{
    ok( request('/login')->is_success, 'Request /login should succeed' );
    my $res = request( POST('/login', { email => 'test@test.com', password => 'test' }) );
    is( $res->code, 302, 'POST to /login success redirect' );
    like( $res->header('Set-Cookie'), qr/mau5_session=/, 'Set-Cookie' );
}

