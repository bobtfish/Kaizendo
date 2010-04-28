#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 0.95;  # xt/ support
use strict;

name 'App-Kaizendo';

resources Homepage    => 'http://kaizendo.org/';
resources GitHub      => 'http://github.com/sjn/Kaizendo';
resources MailingList => 'http://talk.kaizendo.org/mailman/listinfo';
resources IrcChannel  => 'irc://irc.freenode.org/kaizendo';
resources Repository  => 'git://github.com/sjn/Kaizendo.git';

all_from 'lib/App/Kaizendo.pm';

requires 'Catalyst::Runtime' => '5.80022';
requires 'CatalystX::Debug::RequestHeaders';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Action::REST';
requires 'Catalyst::View::TT';
requires 'Moose';
requires 'JSON';
requires 'namespace::autoclean';
requires 'Config::General';

recommends 'JSON::XS';

test_requires 'Test::More' => '0.88';

author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Test::Pod'           => '1.14';
author_requires 'Test::EOL'           => '0.7';
author_requires 'Test::NoTabs';

tests_recursive;

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
