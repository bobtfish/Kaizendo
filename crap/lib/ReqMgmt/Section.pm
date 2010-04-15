package ReqMgmt::Section;
use Moose;
use Method::Signatures::Simple;
use List::MoreUtils qw/any/;
use JSON ();
use Moose::Util qw/does_role/;
use Data::Dumper;
use namespace::clean -except => 'meta';

has name => ( isa => 'Str', required => 1, is => 'ro' );

with qw/
    ReqMgmt::Container::SubSections
    ReqMgmt::Container::Fragments
/;

method _child_section_class { blessed($self) }

method add_child_section (@params) {
    my $parent = $self->parent || $self;
    my $child = $self->_child_section_class->new(@params, parent => $parent);
    my $name = $child->name;
    die("Cannot have a child section with a duplicate name")
        if any { $name eq $_->name } $parent->subsections->children;
    $self->add_child($child);
}

# FIXME - NASTY!
method add_child ($child) {
    return($self->subsections->append($child))
        if $child->isa('ReqMgmt::Section');
    return($self->fragments->append($child))
        if does_role($child, 'ReqMgmt::Fragment');
    die("EEEK $child");
}

method get_section_by_name ($name) {
    return $self if $name eq '';
    my @sections = $self->subsections->children;
    return (grep { $_->name eq $name } @sections)[0];
}

method set_from_json ($dir, $data) {
    if (0) { # Handle arrays
    }
    my $ret = $self->_set_from_json_object($dir, $data);
    $dir->store($self) if $ret;
    return $ret;
}

method _set_from_json_object($dir, $data) {
    die("Do not understand: " . Dumper($data))
        unless ($data->{__CLASS__} eq 'Fragment'
            && ($data->{after_fragment} || $data->{id} eq '__NEW__0'));
    $self->_set_fragment_from_json_object($dir, $data);
}

# FIXME - This code is epicly fucking ugly.
#         It fiddles in the guts of linked lists for no reason
#         And it has no type checking, and manages to mangle edge cases
#         Also, good luck working out how the hell it works tomorrow!
method _set_fragment_from_json_object ($dir, $fragment) {
    my $old_id;
    if ($fragment->{id} =~ /^__NEW__/) {
        my $child = $self->add_child_fragment( type => 'HTML', html => $fragment->{html} );
        $dir->store($self);
        $old_id = $fragment->{id};
        $fragment->{id} = $dir->object_to_id($child);
    }
    my ($item, $before_item);
    foreach my $list_item ( $self->fragments->_all_items ) {
        my $stored_fragment = $list_item->item;
        my $id = $dir->object_to_id($stored_fragment);
        if ($fragment->{after_fragment} eq $id) {
            $before_item = $list_item;
        }
        if ($fragment->{id} eq $id) {
            $item = $list_item;
        }
    }
    die("Cannot find after_fragment id " . $fragment->{after_fragment})
        if (!$before_item && $fragment->{id} ne '__NEW__0');
    if (!$item->_is_tail) {
        $item->_list_next->_list_prev($item->_list_prev);
    }
    if (!$item->_is_head) {
        $item->_list_prev->_list_next($item->_list_next);
    }
    if (! defined($fragment->{html}) || !length($fragment->{html})) {
        # FIXME - LEAK FRAGMENT HERE
        return {
            '__CLASS__' => 'SaveResponse',
            status => 'DELETED',
            id => $fragment->{id},
        };
    }
    $item->item->html($fragment->{html});
    if (!$before_item->_is_tail) {
        my $after_item = $before_item->_list_next;
        $after_item->_list_prev($item);
        $item->_list_next($after_item);
    }
    $before_item->_list_next($item);
    return { 
                ($old_id ? ( old_id => $old_id) : () ),
                '__CLASS__' => 'SaveResponse',
                id => $fragment->{id},
                status => 'OK',
                after_fragment => $fragment->{after_fragment},
            };
}

method set_content ($content) {
    if (!blessed($content)) {
        if (!ref($content)) {
            # Just a raw chunk of tab content, assume HTML.
            $self->fragments(ReqMgmt::LinkedList->new);
            my $frag = ReqMgmt::Fragment::HTML->new(
                parent => $self, 
                html => $content,
            );
            $self->fragments->item($frag);
        }
        else {
            confess("EeeeK");
        }
    }
    else {
        confess "eeekt";
    }
}

method render {
    my $data = '';
    foreach my $fragment ($self->fragments->children) {
        $data .= $fragment->render;
    }
    return $data;
}

method render_json {
    my $json = JSON->new->allow_nonref;
    return $json->encode($self->render);
}


1;

__END__

=head1 NAME

ReqMgmt::Section - A Moose role for sections which appear in the table of
contents, and may contain sub sections

=head1 SYNOPSIS

    package 

=cut

