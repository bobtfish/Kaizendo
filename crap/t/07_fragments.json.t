#!/usr/bin/env perl
use strict;
use lib 't/lib';
use ReqMgmt::Document;
use ReqMgmt::Person;
use Test::More tests => 11;
use Test::Exception;
use TestModel qw/TestModel/;
use ReqMgmt::Fragment::HTML;
use ReqMgmt::Section;
use Data::Dumper;
use Scalar::Util qw/refaddr/;
local $SIG{__DIE__} = \&Carp::confess;
my $model = TestModel;

my $uid = 'test@test.com';
lives_ok {
    my $scope = $model->new_scope;
    my $person = $model->get_user_by_uid($uid);
    ok($person, 'Found a person') or BAIL_OUT("Cannot find user $uid");

    my $doc = ($person->organisation->documents->members)[0];    
    ok $doc;

    my $section = $doc->get_section_by_name('Section 1');
    ok $section;

    my @fragments = get_fragment_ids($section);
    is scalar(@fragments), 2;
    
    # Add a fragment at the end
    my $ret = $section->set_from_json($model, {
        id => '__NEW__3',
        '__CLASS__' => "Fragment",
        html => "html of fragment text",
        after_fragment => $fragments[1], 
    });
    my $new_id = delete $ret->{id};
    is_deeply $ret, {
        '__CLASS__' => 'SaveResponse',
        old_id => "__NEW__3",
        after_fragment => $fragments[1],
        status => "OK",
    };
    push(@fragments, $new_id);
    is_deeply \@fragments, [ get_fragment_ids($section) ];
    
    # Add a fragment in the middle
    $ret = $section->set_from_json($model, {
        id => '__NEW__4',
        '__CLASS__' => "Fragment",
        html => "html of fragment text, ends up before last fragment",
        after_fragment => $fragments[1], 
    }); 
    $new_id = delete $ret->{id}; 
    is_deeply $ret, {
        '__CLASS__' => 'SaveResponse',
        old_id => "__NEW__4",
        after_fragment => $fragments[1],
        status => "OK",
    };
    @fragments = ( @fragments[0..1], $new_id, $fragments[2] );
    is_deeply \@fragments, [ get_fragment_ids($section) ];

    # Delete a fragment in the middle
    $ret = $section->set_from_json($model, {
        id => $fragments[1],
        '__CLASS__' => "Fragment",
        html => undef,
        after_fragment => $fragments[0],
    });
    is_deeply $ret, {
        '__CLASS__' => 'SaveResponse',
        id => $fragments[1],
        status => "DELETED",
    };
    @fragments = @fragments[0, 2..3];
    is_deeply \@fragments, [ get_fragment_ids($section) ]
        or warn Dumper(\@fragments);
};

sub get_fragment_ids {
    my $section = shift;
    map { $model->object_to_id($_) } $section->fragments->children;
}

