package ReqMgmt::Contained;
use Moose::Role;
use Method::Signatures::Simple;
use namespace::clean -except => 'meta';

has parent => ( does => 'ReqMgmt::Container', is => 'ro',
    # FIXME
    # weak_ref => 1,
    required => 1 );

1;

