use inc::Module::Install;

name 'ReqMgmt';
all_from 'lib/ReqMgmt.pm';
license 'commercial';

requires 'namespace::autoclean';
requires 'Catalyst::Devel' => '1.17';
requires 'List::MoreUtils';
requires 'KiokuDB' => '0.26';
requires 'Catalyst::Model::KiokuDB';
requires 'KiokuDB::Backend::DBI';
requires 'KiokuX::User';
requires 'Catalyst::Runtime' => '5.80007';
requires 'Catalyst::Plugin::ConfigLoader' => '0.22';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::Unicode';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::View::TT';
requires 'Catalyst::View::ContentNegotiation::XHTML' => '1.101';
requires 'Catalyst::Controller::REST';
requires 'SQL::Translator' =>  '0.08';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session::Store::File';
#requires 'Catalyst::Plugin::Session::Store::Delegate';
requires 'Data::Visitor' => '0.24'; # Avoid warnings.
requires 'Moose' => '0.70';
requires 'Method::Signatures::Simple' => '0.03';
requires 'MooseX::AttributeHelpers';
requires 'Moose::Autobox';
requires 'MooseX::Types::Moose';
requires 'MooseX::Types::Common';
requires 'MooseX::Types::DateTime';
requires 'MooseX::Types::Email';
requires 'MooseX::MethodAttributes' => '0.13';
requires 'YAML';
requires 'File::HomeDir';
requires 'namespace::clean';
requires 'NEXT' => '0.63'; # Warning avoidance.
requires 'aliased';
requires 'Module::Build' => '0.30'; # Data::Serializer, HATE

recommends 'CatalystX::REPL';

test_requires 'Test::More';
test_requires 'Test::Exception';
test_requires 'Test::WWW::Mechanize::Catalyst' => '0.50';
test_requires 'XML::Simple';

auto_install;
WriteAll;
