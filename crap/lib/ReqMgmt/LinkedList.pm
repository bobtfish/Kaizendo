package ReqMgmt::LinkedList;
use Moose;
use Method::Signatures::Simple;
use namespace::clean -except => 'meta';

has item => ( isa => 'Object', is => 'rw', predicate => '_has_item' );

has _list_prev => ( isa => __PACKAGE__ . '|Undef', is => 'rw', weak => 1, predicate =>
    '_has_list_prev', clearer => '_clear_list_prev' );
has _list_next => ( isa => __PACKAGE__ . '|Undef', is => 'rw', weak => 1, predicate =>
    '_has_list_next', clearer => '_clear_list_next' );

method children {
    map { $_->item } $self->_all_items;
}

method _all_items {
    my @items;
    my $tail = $self->_find_head;
    while ($tail and $tail->_has_item and defined($tail->item)) {
        push(@items, $tail);
        $tail = $tail->_list_next;
    }
    return @items;
}

sub append {
    my ($self, $item) = @_;
    my $tail = $self->_find_tail;
    if ($tail->_has_item) {
        my $new_tail = __PACKAGE__->new(_list_prev => $tail);
        $tail->_list_next($new_tail);
        $tail = $new_tail;
    }
    $tail->item($item);
}

sub _is_head { not $_[0]->_has_list_prev or not defined $_[0]->_list_prev }
sub _is_tail { not $_[0]->_has_list_next or not defined $_[0]->_list_next }

sub _find_tail {
    my $self = shift;
    my $maybe_tail = $self;
    while (not $maybe_tail->_is_tail) {
        $maybe_tail = $maybe_tail->_list_next;
    }
    return $maybe_tail;
}

sub _find_head {
    my $self = shift;
    my $maybe_head = $self;
    while (not $maybe_head->_is_head) {
        $maybe_head = $maybe_head->_list_prev;
    }
    return $maybe_head;
}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

ReqMgmt::LinkedList - List abstraction.

=head1 SYNOPSIS

    my $list = get_list;
    my @children = $list->children;
    $list->append($item);

=head1 METHODS

=head2 children

Returns a list of all the children contained within this list

=head2 append ($item)

Appends a new child item to the tail of this list.

=cut

