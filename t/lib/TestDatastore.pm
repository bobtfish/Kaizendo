package TestDataStore;
use Exporter ();
use Test::More;
use aliased 'App::Kaizendo::DataStore';

our @EXPORT = qw/getTestDataStore/;

my $to_unlink;
my $fn;

sub import {
    my ($class, %args) = @_;
    $fn = 'kiokudb.sqlite3.' . $$;
    unless ($args{no_unlink}) {
        $to_unlink = $fn;
    }
    goto &Exporter::import;
}

sub getTestDataStore {
    my $storage = DataStore->new(
        dsn => "dbi:SQLite:dbname=$fn",
        extra_args => { create => 1, },
    );
    system("chmod 666 $fn");
    return $storage;
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
