package TestDatastore;
use Exporter ();
use Moose::Autobox;
use Test::More;
use FindBin qw/$Bin/;
use aliased 'App::Kaizendo::Datastore';
use aliased 'App::Kaizendo::Datastore::Project';
use aliased 'App::Kaizendo::Datastore::Comment';

our @EXPORT = qw/getTestDatastore buildTestData/;

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

sub getTestDatastore {
    unlink $fn if -f $fn;
    my $storage = Datastore->new(
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

    is scalar($doc->snapshots->flatten), 1, 'Has 1 snapshot';

    my $latest_snapshot = $doc->latest_snapshot;
    my @chapter_fns = glob("$Bin/../books//www.dreamsongs.com/IHE/plain/ch*.html");
    for my $fn (@chapter_fns) {
        my $fh;
        open($fh, '<', $fn) or die $!;
        my $data = do { local $/; <$fh> };
        $latest_snapshot = $latest_snapshot->add_chapter( text => $data );
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
