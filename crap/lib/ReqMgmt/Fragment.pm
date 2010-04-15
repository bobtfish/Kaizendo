package ReqMgmt::Fragment;
use Moose::Role;
use Method::Signatures::Simple;
use namespace::clean -except => 'meta';

with qw/
    ReqMgmt::Contained
/; # Fragments all have a parent

method has_children { 0 }

requires 'render';

1;

