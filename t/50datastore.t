use strict;
use warnings;
use Class::MOP;
use Test::More;
use Moose::Autobox;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use TestDatastore { no_unlink => 1 };

my $store = buildTestData(getTestDatastore());
ok $store;

my $s = $store->new_scope;

my $project = $store->get_project_by_name('IHE');# Innovation Happens Elsewhere
ok $project, "We have a project";

my $snap = $project->latest_snapshot;

ok scalar($snap->sections->flatten), '..and it has some chapters';

done_testing;
