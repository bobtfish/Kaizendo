use Test::WWW::Mechanize::Catalyst;
use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/../lib";
use Test::More tests => 3;
use XML::Simple;
use Test::Exception;
use Data::Dumper;

my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Mau5');

$mech->get_ok('/login');
$mech->submit_form_ok({ with_fields => { email => 'test2@test.com', password => 'test'}});
$mech->content_contains('Logged in as');

exit;

$mech->get_ok('/');
$mech->links_ok;

$mech->get_ok('/project');
$mech->links_ok;

$mech->get_ok('/project/A document/section/Section 1');
$mech->content_contains('A%20document/add_subsection/Section 1');
$mech->links_ok;

$mech->get_ok('/project/A document/section/Section 1?edit=1');
$mech->links_ok;

$mech->get_ok('/project/A document/section/Section 1/Section 1.1');
$mech->content_contains('A%20document/add_subsection/Section 1/Section 1.1');
$mech->links_ok;

$mech->get_ok('/project/A document/section/Section 1/Section 1.1?edit=1');
$mech->links_ok;


$mech->get_ok('/project/A document.xml');
is $mech->response->header('Content-Type'), 'text/xml';
my $xmlstr = $mech->response->content;
my $xml;
lives_ok {
    $xml = XMLin($xmlstr);
} 'Can parse XML';
warn Dumper($xml);

$mech->get_ok('/admin/organisation');
# FIXME - test create org

$mech->get_ok('/admin/organisation/Mau5');
# FIXME - test create user

$mech->get_ok('/admin/user');
# FIXME - test create user.

