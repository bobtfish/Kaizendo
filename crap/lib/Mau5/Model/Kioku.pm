package Mau5::Model::Kioku;
use Moose;
use Moose::Util::TypeConstraints;
use ReqMgmt::Storage::API;
use namespace::clean -except => 'meta';

Class::MOP::load_class('ReqMgmt::Storage');

extends qw(Catalyst::Model::KiokuDB);

__PACKAGE__->config( 
    dsn => "dbi:SQLite:dbname=kiokudb.sqlite3",
    manage_scope => 1,
    clear_leaks => 1,
    model_class => 'ReqMgmt::Storage',
);

role_type 'ReqMgmt::Storage::API';
has '+model' => (
    handles => 'ReqMgmt::Storage::API',
);

__PACKAGE__->meta->make_immutable;

