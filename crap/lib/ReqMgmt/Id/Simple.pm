package ReqMgmt::Id::Simple;
use Moose::Role;
use namespace::clean -except => 'meta';

with 'ReqMgmt::Id';

requires '_id_attribute';

sub kiokudb_object_id {
    my ($self) = @_;
    my $reader = $self->_id_attribute;
    sprintf("%s::%s", blessed($self), $self->$reader()); 
}

1;

=head1 SYNOPSIS

    package ReqMgmt::SomeObject;
    use Moose;

    with 'ReqMgmt::Id::Simple';

    has id => ( isa => 'Int', is => 'ro', required => 1 );

    sub _id_attribute { 'id' } # FIXME - Ugly..

    package elsewhere;
    my $model = ReqMgmt::Storage->new;
    $model->get_by_simple_id('SomeObject', $id);

=head1 DESCRIPTION

Role consumed by  objects which have a single unique ID field, which is 
C<Class::Name::$id>

=head1 SEE ALSO

=over

=item L<ReqMgmt::Id>

=back

=head1 LICENSE

See L<ReqMgmt>.

=cut

