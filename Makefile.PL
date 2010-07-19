#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 0.96;  # xt/ and agpl_3 support
use Module::Install::Catalyst;
use strict;
use Module::Install::AuthorRequires;

name 'App-Kaizendo';

resources Homepage    => 'http://kaizendo.org/';
resources GitHub      => 'http://github.com/sjn/Kaizendo';
resources MailingList => 'http://talk.kaizendo.org/mailman/listinfo';
resources IrcChannel  => 'irc://irc.freenode.org/kaizendo';
resources Repository  => 'git://github.com/sjn/Kaizendo.git';
resources Bugtracker  => 'http://rt.cpan.org/Public/Dist/Display.html?Name=App-Kaizendo';

all_from 'lib/App/Kaizendo.pm';

configure_requires 'File::Copy::Recursive';  # needed by Module::Install::Catalyst
requires 'JSON';
requires 'Moose';
requires 'Catalyst::Runtime' => '5.80022';
requires 'CatalystX::Debug::RequestHeaders';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Action::REST';
requires 'Catalyst::View::TT';
requires 'Catalyst::Model::KiokuDB';
requires 'Moose';
requires 'MooseX::Types';
requires 'MooseX::Types::LoadableClass';
requires 'Moose::Autobox' => '0.11';
requires 'Method::Signatures::Simple';
requires 'namespace::autoclean';
requires 'Config::General';
requires 'KiokuX::Model';
requires 'KiokuDB::Backend::DBI';
requires 'aliased';

recommends 'JSON::XS';

test_requires 'Test::More' => '0.88';

author_requires 'DBIx::Class' => '0.08123';

if ($Module::Install::AUTHOR) {
    include 'File::Copy::Recursive';
    require DBIx::Class::Optional::Dependencies;

    my $deploy_deps = DBIx::Class::Optional::Dependencies->req_list_for ('deploy');

    for (keys %$deploy_deps) {
        author_requires $_ => $deploy_deps->{$_};
        recommends $_ => $deploy_deps->{$_};
    }
}

author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Test::Pod'           => '1.14';
author_requires 'Test::EOL'           => '0.7';
author_requires 'Test::NoTabs';

tests_recursive;

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
