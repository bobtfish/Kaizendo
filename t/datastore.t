use strict;
use warnings;
use Test::More;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use TestDataStore { no_unlink => 1 };

my $store = buildTestData(getTestDataStore());
ok $store;

done_testing;
