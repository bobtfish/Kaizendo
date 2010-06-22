use strict;
use warnings;
use Class::MOP;
use Test::More;
use Moose::Autobox;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

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

use TestDatastore { no_unlink => 1 };

my $store = buildTestData(getTestDatastore());
ok $store;

my $s = $store->new_scope;

my $project = $store->get_project_by_name('TestProject');
ok $project;

my $snap = $project->latest_snapshot;

ok scalar($snap->chapters->flatten), 'Has some chapters';

done_testing;
