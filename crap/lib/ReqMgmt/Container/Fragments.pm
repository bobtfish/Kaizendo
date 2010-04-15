package ReqMgmt::Container::Fragments;
use Moose::Role;

with 'ReqMgmt::Container';

has fragments => ( isa => 'ReqMgmt::LinkedList', is => 'rw', lazy => 1,
    default => sub { ReqMgmt::LinkedList->new }
);

sub add_child_fragment {
    my ($self, %p) = @_;
    my $type = delete $p{type};
    $type = 'ReqMgmt::Fragment::' . $type;
    $self->add_child($type->new(%p, parent => $self));
}

around 'children_top' => sub {
    my $next = shift;
    my $self = shift;
    return ($self->$next(@_), $self->fragments->children);
};

around 'add_child' => sub {
    my $next = shift;
    my ($self, $child) = @_;
    if ($child->does('ReqMgmt::Fragment')) {
        $self->fragments->append($child);
    }
    else {
        $self->$next($child);
    }
};

1;

=head1 NAME

ReqMgmt::Container::Fragments - A role for classes which contain fragments

=cut

