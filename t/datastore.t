use strict;
use warnings;
use Test::More;
use FindBin qw/$Bin/;
use lib "$Bin/lib";

use TestDataStore;

use aliased 'App::Kaizendo::DataStore::Document';
use aliased 'App::Kaizendo::DataStore::Comment';

my $store = getTestDataStore();
ok $store;

my $s = $store->new_scope;

my $doc = Document->new(name => 'Foo');
ok $doc;

ok $store->store($doc);

my $comment = Comment->new( document => $doc, text => 'A comment' );
ok $comment;

ok $store->store($comment);

done_testing;
