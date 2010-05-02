package TestDataStore;
use Exporter ();
use Test::More;
use aliased 'App::Kaizendo::DataStore';
use aliased 'App::Kaizendo::DataStore::Project';
use aliased 'App::Kaizendo::DataStore::Comment';

our @EXPORT = qw/getTestDataStore buildTestData/;

my $to_unlink;
my $fn;

sub import {
    my ($class, $args) = @_;
    pop if $args;
    $fn = 'kiokudb.sqlite3';
    unless ($args->{no_unlink}) {
        $to_unlink = $fn;
    }
    goto &Exporter::import;
}

sub getTestDataStore {
    unlink $fn if -f $fn;
    my $storage = DataStore->new(
        dsn => "dbi:SQLite:dbname=$fn",
        extra_args => { create => 1, },
    );
    system("chmod 666 $fn");
    return $storage;
}

sub buildTestData {
    my ($store) = @_;
    my $s = $store->new_scope;

    my $doc = Project->new(name => 'TestProject');
    ok $doc;

    ok $store->store($doc);

    for my $n (1..5) {
        ok $store->store($doc->add_chapter( text => "Chapter $n text" )), 'Added chapter';
    }
    $store->store($doc);

    my $comment = Comment->new( project => $doc, text => 'A comment' );
    ok $comment;

    ok $store->store($comment);

    return $store;
}

END {
    if ($to_unlink) {
        unlink $to_unlink;
    }
    else {
        diag "Left database $fn un cleaned up";
    }
}

1;
