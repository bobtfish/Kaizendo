package App::Kaizendo::DataStore;
use Moose;
use Method::Signatures::Simple;
use namespace::autoclean;

extends qw/ KiokuX::Model /;
with qw/ KiokuDB::Role::API /;

around BUILDARGS => sub {
    my ($orig, $self) = (shift, shift);
    my $args = $self->$orig(@_);
    delete $args->{$_} for qw/ clear_leaks manage_scope model_class /; # Ewww
    return $args;
};

__PACKAGE__->meta->make_immutable;
