package TestDatastore;
use Exporter ();
use Moose::Autobox;
use Test::More;
use FindBin qw/$Bin/;
use aliased 'App::Kaizendo::Datastore';
use aliased 'App::Kaizendo::Datastore::Project';
use aliased 'App::Kaizendo::Datastore::Comment';
use aliased 'App::Kaizendo::Datastore::Person';

our @EXPORT = qw/getTestDatastore buildTestData/;

my $to_unlink;
my $fn;

sub import {
    my ($class, $args) = @_;
    pop if $args;
    $fn = $Bin . '/../kiokudb.sqlite3';
    unless ($args->{no_unlink}) {
        $to_unlink = $fn;
    }
    my @needed = qw/
        DBIx::Class::Optional::Dependencies
    /;
    plan skip_all => "One of the required classes for this test $@ (" . join(',', @needed) . ") not found."
        unless eval {
            Class::MOP::load_class($_) for @needed; 1;
        };
    plan skip_all => 'Test needs ' . DBIx::Class::Optional::Dependencies->req_missing_for('deploy')
        unless DBIx::Class::Optional::Dependencies->req_ok_for('deploy');
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

    my $author1 = Person->new( name => "Ron Goldman", access => 1 );
    ok $author1, 'Register first author';

    my $author2 = Person->new( name => "Richard P. Gabriel", access => 1 );
    ok $author2, 'Register second author';

    my $doc = Project->new(name => 'IHE');
    ok $doc;
    
    is scalar($doc->snapshots->flatten), 1, 'Has 1 snapshot';

    # Add snapshots with new sections
    my $latest_snapshot = $doc->latest_snapshot;
    my (@chapter_fns) = glob($Bin.'/data/IHE/ch*.html');
    ok scalar(@chapter_fns), 'There are some chapters in '."$Bin/data/IHE";
    for my $fn (@chapter_fns) {
        my ($fh, $version);
        open($fh, '<', $fn) or die $!;
        my $data = do { local $/; <$fh> };
        $latest_snapshot = $latest_snapshot->append_section(
            content        => $data,
            author         => $author1,
            commit_message => "Add chapter from " . $fn,
            tag            => "v0.0." . ++$version, #
        );
    }
    $store->store($doc);

    # Set up comments
    my $comment = Comment->new(
        project => $doc,
        content => 'This is a good book, believe me!',
        author  => $author2,
        );
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
