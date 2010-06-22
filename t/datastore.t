use strict;
use warnings;
use Test::More;
use Moose::Autobox;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use TestDataStore { no_unlink => 1 };

my $store = buildTestData(getTestDataStore());
ok $store;

my $s = $store->new_scope;

my $project = $store->get_project_by_name('TestProject');
ok $project;

my $snap = $project->latest_snapshot;

ok scalar($snap->chapters->flatten), 'Has some chapters';

done_testing;
