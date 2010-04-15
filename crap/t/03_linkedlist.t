#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 17;
use Scalar::Util qw/refaddr/;
use Carp ();

local $SIG{__DIE__} = \&Carp::confess;

use_ok('ReqMgmt::LinkedList');

my ($item1, $item2, $item3) = (bless( {}, 'Item1' ), bless( {}, 'Item2' ),
    bless( {}, 'Item3' )
);

my $l = ReqMgmt::LinkedList->new;
$l->append($item1);
$l->append($item2);
$l->append($item3);

my $l2 = $l->_list_next;
my $l3 = $l2->_list_next;

ok($l2);
ok($l3);
isnt($l, $l2);
isnt($l2, $l3);
is($l2->_list_prev, $l);
is($l3->_list_prev, $l2);
ok(! $l3->_has_list_next);
isa_ok($l->item, 'Item1');
isa_ok($l2->item, 'Item2');
isa_ok($l3->item, 'Item3');

my @children = $l->children;
is scalar(@children), 3;
isa_ok($children[0], 'Item1');
isa_ok($children[1], 'Item2');
isa_ok($children[2], 'Item3');

my @other_children = $l3->children;
is scalar(@other_children), 3, '3 children asking from tail';

my $head = $l3->_find_head;
is(refaddr($head), refaddr($l), 'found head');
