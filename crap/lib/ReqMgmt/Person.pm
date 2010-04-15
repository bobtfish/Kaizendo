package ReqMgmt::Person;
use Moose;
use Method::Signatures::Simple;
use MooseX::Types::Moose qw/Str Bool/;
use MooseX::Types::Common::String qw/NonEmptySimpleStr/;
use MooseX::Types::Email qw/EmailAddress/;
use ReqMgmt::Organisation;
use KiokuDB::Util qw(set);
use Moose::Util::TypeConstraints;
use namespace::autoclean;

with qw/KiokuX::User/;
has '+id' => ( isa => EmailAddress );
has organisation => ( isa => 'ReqMgmt::Organisation', is => 'ro', required => 1 );
has documents => (
    does => 'KiokuDB::Set', default => sub { set() }, required => 1, is => 'ro',
);
my $checkbox = subtype Bool;
coerce $checkbox, from Str, via { ($_ =~ /^\s*(on|1)\s*$/) ? 1 : 0 };
has admin => ( isa => $checkbox, is => 'ro', default => 0, coerce => 1 );

has firstname => ( isa => NonEmptySimpleStr, is => 'ro', required => 1 );
has surname => ( isa => NonEmptySimpleStr, is => 'ro', required => 1 );

sub new_document {
    my $self = shift;
    my $args = $self->BUILDARGS(@_);
    $args->{owner} = $self;
    my $class = delete $args->{document_class} || 'ReqMgmt::Document';
    my $document = $class->new($args);
    $self->documents->insert($document);
    $self->organisation->documents->insert($document);
    return $document;
}

__PACKAGE__->meta->make_immutable;

