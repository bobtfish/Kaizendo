package ReqMgmt;
use strict;
use warnings;

our $VERSION = 0.00000001;

use ReqMgmt::Id; # Role for objects which determine their own ID.
use ReqMgmt::Id::Simple; # Objects whos id is Class::Name::$id
use ReqMgmt::LinkedList; # Abstraction used on list, for forming trees.
use ReqMgmt::Fragment; # Displayable fragment
use ReqMgmt::Fragment::HTML; # HTML fragment
use ReqMgmt::Section; # Sections contain fragments, and other sections
use ReqMgmt::Document; # Documents contain fragments, and sections
use ReqMgmt::Organisation; 
use ReqMgmt::Person; # People belong to orgs, and own documents
use ReqMgmt::Storage; # Storage model with convienience storage / retrieval 
                      # functions

1;

__END__

=head1 NAME

Reqmgmt - OO framework for describing and persisting requirements management
documents.

=head1 SYNOPSIS

Requirements management software.

=head1 DESCRIPTION

Foo

=head1 COPYRIGHT

Copyright 2009 Xilr8d group, all rights reserved.

=cut

