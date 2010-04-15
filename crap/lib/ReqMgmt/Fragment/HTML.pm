package ReqMgmt::Fragment::HTML;
use Moose;
use MooseX::Types::Moose qw/Str/;
use namespace::clean -except => 'meta';

with 'ReqMgmt::Fragment';

has html => ( isa => Str, is => 'rw', required => 1, default => '' );

sub render { 
    my $html = $_[0]->html;
    $html =~ s/<br>/<br \/>/g; #FIXME, evil - we should do this on the way in.
    $html = '&nbsp;' if $html =~ /^\s*$/;
    return $html;
}

with 'ReqMgmt::Renderable';

__PACKAGE__->meta->make_immutable;

