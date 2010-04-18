use strict;
use warnings;
use Test::More;

use inc::Module::Install ();

ok $Module::Install::VERSION, 'Have $Module::Install::VERSION';
is $Module::Install::VERSION, 0.91, 'Need Module::Install version 0.91';

done_testing;
