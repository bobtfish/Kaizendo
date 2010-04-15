#!/usr/bin/env perl
use strict;
use lib 't/lib';
use ReqMgmt::Document;
use ReqMgmt::Person;
use Test::More tests => 30;
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

    is_deeply([$person->documents->members], [], 'Person has no documents');

    my $document = $person->new_document( name => 'A document',);
    $document->add_child_fragment(type => 'HTML', html => 'foo' );
    my $subsection = $document->add_child_section(name => 'Section 1' );
    isa_ok($subsection, 'ReqMgmt::Section');
    $document->add_child_fragment( type => 'HTML', html => 'bar' );
    $document->add_child_section(name => 'Section 2' );
    $subsection->add_child_fragment( type => 'HTML', html => 'quux' );
    $subsection->add_child_fragment( type => 'HTML', html => 'fnoo' );
    
    $model->store($document);

    is_deeply([$person->documents->members], [$document], 
        'Person has 1 documents');

    diag 'Store person in model';
    $model->store($person);

    is_deeply([$person->documents->members], [$document],
        'Person has 1 documents');
};
foreach my $uid (qw/test@test.com test2@test.com/) {
    my $scope = $model->new_scope;
    my $person = $model->get_user_by_uid($uid);
    my @docs = $person->organisation->documents->members;
    is scalar(@docs), 1, "User $uid found 1 document through org "
        . $person->organisation->name;
}

{
    my $scope = $model->new_scope;
    my $person = $model->get_user_by_uid($uid);
    is scalar(@{[$person->documents->members]}), 1,
        "User $uid has one document of their own";
}
{
    my $scope = $model->new_scope;
    my $document = $model->get_by_simple_id('Document', 'A document');
    ok($document);
    isa_ok($document, 'ReqMgmt::Document');

    my $author = $document->owner;
    ok($author, 'Doc has an author');

    ok($author->firstname, 'Author has firstname');
    ok($author->surname, 'Author has surname');
    ok($author->organisation, 'Author belongs to an organisation');
    ok($author->organisation->name, 'Author belongs to an organisation with a name');

    my @children = $document->children;
    is scalar(@children), 4;
    isa_ok $children[0], 'ReqMgmt::Fragment::HTML';
    isa_ok $children[1], 'ReqMgmt::Fragment::HTML';
    isa_ok $children[2], 'ReqMgmt::Section';
    isa_ok $children[3], 'ReqMgmt::Section';
    is $children[2]->name, 'Section 1', 'section 1 found';
    is $children[3]->name, 'Section 2', 'section 2 found';
    my $child1 = $document->get_section_by_name('Section 1');
    is refaddr($child1), refaddr($children[2]), 'get_section_by_name returns correct section';
    my @fragments = $children[2]->children;
    is scalar(@fragments), 2, 'Section 1 has 2 children';
    isa_ok $fragments[0], 'ReqMgmt::Fragment::HTML';
    isa_ok $fragments[1], 'ReqMgmt::Fragment::HTML';
    #is $fragments[0]->html, 'foo';
    #is $fragments[1]->html, 'bar';
    #is $child1->render, 'foobar';
    #$child1->fragments(ReqMgmt::LinkedList->new);
    #$child1->add_child_fragment(type => 'HTML', html => 'quux' );
    #$model->store($child0);

    #my $summary = $child1->get_tab_by_name('Summary');
    #ok($summary, 'Section 1 has summary tab');
}
{
    my $scope = $model->new_scope;
    my $document = $model->get_by_simple_id('Document', 'A document');
    my $section = $document->get_section_by_name('Section 1');
    ok($section);

    $section->add_child_section( name => 'Section 1.1' );
    $model->store($document);
}
{
    my $scope = $model->new_scope;
    my $document = $model->get_by_simple_id('Document', 'A document');
    my $section = $document->get_section_by_name('Section 1');
    ok($section);
    my $subsection = $section->get_section_by_name('Section 1.1');
    ok($subsection);
}

