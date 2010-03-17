use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Kaizendo' }
BEGIN { use_ok 'Kaizendo::Controller::Comments' }

ok( request('/_c')->is_success, 'Request should succeed' );
done_testing();
