#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 0.91;
use strict;
use Module::Install::AuthorTests;
use Module::Install::AuthorRequires;

name 'App-Kaizendo';

resources Homepage => 'http://kaizendo.org/';
resources GitHub => 'http://github.com/sjn/Kaizendo';
resources MailingList => 'http://talk.kaizendo.org/mailman/listinfo';
resources IrcChannel => 'irc://irc.freenode.org/kaizendo';
resources Repository => 'git://github.com/sjn/Kaizendo.git';

all_from 'lib/App/Kaizendo.pm';

requires 'Catalyst::Runtime' => '5.80022';
requires 'CatalystX::Debug::RequestHeaders';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen

test_requires 'Test::More' => '0.88';

author_requires 'Test::Pod::Coverage' => '1.04';
author_requires 'Test::Pod' => '1.14';
author_requires 'Test::EOL' => '0.7';
author_requires 'Test::NoTabs';

tests 't/*.t';
author_tests 't/author';

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
