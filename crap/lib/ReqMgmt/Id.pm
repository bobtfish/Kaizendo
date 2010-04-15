package ReqMgmt::Id;
use Moose::Role;
use namespace::clean -except => 'meta';

with 'KiokuDB::Role::ID';

1;

=head1 SYNOPSIS

    package ReqMgmt::Id::SomeType;
    use Moose::Role;
    use namespace::clean -except => 'meta';

    with 'ReqMgmt::Id';

    sub kiokudb_object_id { ... }

=head1 DESCRIPTION

Role for objects which determine their own ID. This is the set of objects
addressable by a 'human' ID, rather than a GUID.

=head1 SEE ALSO

=over

=item L<ReqMgmt::Id::Simple>

=back

=head1 LICENSE

See L<ReqMgmt>.

=cut

