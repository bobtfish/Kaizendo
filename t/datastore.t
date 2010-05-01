use strict;
use warnings;
use Test::More;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use TestDataStore;

use aliased 'App::Kaizendo::DataStore::Document';

my $store = getTestDataStore();
ok $store;

my $s = $store->new_scope;

my $doc = Document->new(name => 'Foo');
ok $doc;

ok $store->store($doc);

done_testing;
