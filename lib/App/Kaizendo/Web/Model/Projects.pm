package App::Kaizendo::Web::Model::Projects;
use Moose;
use MooseX::Types::LoadableClass qw/ClassName/;
use namespace::autoclean;

extends 'Catalyst::Model::KiokuDB';

__PACKAGE__->config(
    dsn => "dbi:SQLite:dbname=kiokudb.sqlite3",
    manage_scope => 1,
    clear_leaks => 1,
    model_class => 'App::Kaizendo::DataStore',
);

has '+model_class' => ( isa => ClassName, coerce => 1 );

__PACKAGE__->meta->make_immutable;

=head1 NAME

App::Kaizendo::Web::Model::Projects

=cut
