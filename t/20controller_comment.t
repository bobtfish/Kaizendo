use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use Test::More;

use TestDataStore;

my $store = buildTestData(getTestDataStore());

use_ok 'Catalyst::Test', 'App::Kaizendo::Web';
use_ok 'App::Kaizendo::Web::ControllerRole::Comment';

ok( request('/_c')->is_success, 'Request should succeed' );
done_testing();
