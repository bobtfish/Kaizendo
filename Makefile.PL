#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'Kaizendo';

resources Homepage => 'http://kaizendo.org/';
resources GitHub => 'http://github.com/sjn/Kaizendo';
resources MailingList => 'http://talk.kaizendo.org/mailman/listinfo';
resources IrcChannel => 'irc://irc.freenode.org/kaizendo';
resources Repository => 'git://github.com/sjn/Kaizendo.git';

all_from 'lib/Kaizendo.pm';

requires 'Catalyst::Runtime' => '5.8002';
requires 'CatalystX::Debug::RequestHeaders';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
