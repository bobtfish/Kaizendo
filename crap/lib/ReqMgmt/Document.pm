package ReqMgmt::Document;
use Moose;
use MooseX::Types::Moose qw/Str Bool/;
use MooseX::Types::DateTime qw/DateTime/;
use Method::Signatures::Simple;
use ReqMgmt::Person;
use ReqMgmt::LinkedList;
use aliased DateTime => 'DateTimeObj';
use namespace::clean -except => 'meta';

extends 'ReqMgmt::Section';

with qw/
    ReqMgmt::Id::Simple 
/;

sub _id_attribute { 'name' }

method _child_section_class { 'ReqMgmt::Section' }

has '+parent' => ( isa => 'Undef', default => sub { undef } );

has owner => ( isa => 'ReqMgmt::Person', is => 'ro', required => 1 );
has shared => ( isa => Bool, is => 'ro', required => 1, default => 0 );

has createdate => (
    isa => DateTime, is => 'ro',
    default => sub { DateTimeObj->now },
);

method find_subsection_from_list (@subsections) {
    return $self
        unless scalar @subsections;
    my $subsection = $self;
    while ( scalar @subsections ) {
        my $next_subsection_name = shift @subsections;
        $subsection = $subsection->get_section_by_name($next_subsection_name)
            or return { code => 404 };
    }
    return $subsection;
}

method get_tab_by_section_and_tab_names ($section_name, $tab_name) {
    my $section = $self->get_sub_requirement_by_section_name($section_name);
    return unless $section;
    return $section->get_tab_by_name($tab_name);
}

__PACKAGE__->meta->make_immutable;

