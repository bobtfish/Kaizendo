package ReqMgmt::Container;
use Moose::Role;
use Method::Signatures::Simple;
use namespace::clean -except => 'meta';

with qw/
    ReqMgmt::Contained
/; # All containers can be contained

method add_child ($child) { confess("Cannot add $child to $self"); }

method children_top { () }

method children_bottom { () }

method children_middle { () }

method children {
    ( $self->children_top, $self->children_middle, $self->children_bottom )
}

1;

=head1 NAME

ReqMgmt::Container - A role for classes which contain things

=cut

