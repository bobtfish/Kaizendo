use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'Kaizendo::Web' }
BEGIN { use_ok 'Kaizendo::Web::Controller::Comment' }

ok( request('/_c')->is_success, 'Request should succeed' );
done_testing();
