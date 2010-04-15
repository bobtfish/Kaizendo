package ReqMgmt::Container::SubSections;
use Moose::Role;

with 'ReqMgmt::Container';

has subsections => ( isa => 'ReqMgmt::LinkedList', is => 'ro', lazy => 1,   
    default => sub { ReqMgmt::LinkedList->new }
);

sub add_child_section {
    my ($self, %p) = @_;
    $self->add_child(ReqMgmt::Section->new(%p, parent => $self));
}

around 'children_bottom' => sub {
    my $next = shift;
    my $self = shift;
    return ($self->$next(@_), $self->subsections->children);
};

around 'add_child' => sub {
    my $next = shift;
    my ($self, $child) = @_;
    if ($child->isa('ReqMgmt::Section')) {
        $self->subsections->append($child);
    }
    else {
        $self->$next($child);
    }
};

1;

=head1 NAME

ReqMgmt::Container::Fragments - A role for classes which contain fragments

=cut

