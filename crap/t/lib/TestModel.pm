package # Confuse PAUSE
    TestModel;
use Exporter qw/import/;
use ReqMgmt::Storage;

our @EXPORT = qw/TestModel/;
our @EXPORT_OK = qw/TestModelFileName TestModelUnlink/;

sub TestModelUnlink {
    unlink TestModelFileName();
}

sub TestModelFileName {
    'kiokudb.sqlite3';
}

sub TestModel {
    my $fn = TestModelFileName;
    my $storage = ReqMgmt::Storage->new(
        dsn => "dbi:SQLite:dbname=$fn", 
        extra_args => { create => 1, },
    );
    system("chmod 666 $fn");
    return $storage;
}
