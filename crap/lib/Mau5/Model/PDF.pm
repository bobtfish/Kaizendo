package Mau5::Model::PDF;
use Mau5 ();
use Moose;
use MooseX::Types::Moose qw/Str/;
use Method::Signatures::Simple;
use File::Copy::Recursive qw/rcopy/;
use File::Temp qw/tempdir/;
use namespace::autoclean;

extends 'Catalyst::Model';

__PACKAGE__->config(
    template_path => Mau5->path_to('share/docbook').'',
    fop_path => Mau5->path_to('share/fop-0.95').'',
);

has template_path => ( isa => Str, is => 'ro', required => 1 );
has fop_path => ( isa => Str, is => 'ro', required => 1 );

method generate_from_xml ($xml) {
    my $tempdir = tempdir;
    warn("Tempdir is $tempdir");

    rcopy($self->template_path, $tempdir);
    my $fh;
    open($fh, '>', "$tempdir/req.mau5.xml") or die;
    print $fh $xml;
    close($fh);
    warn("Wrote $tempdir/req.mau5.xml");
    my $fop_path = $self->fop_path;
    my $fail = `cd $tempdir; PATH=$fop_path:\$PATH make 2>&1`;

    $? and die("Make failed $?: $fail");

    return ($tempdir, "req.pdf");
}

__PACKAGE__->meta->make_immutable;

