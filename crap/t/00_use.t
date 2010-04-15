#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 16;

use_ok "ReqMgmt";
use_ok "ReqMgmt::Fragment";
use_ok "ReqMgmt::Container";
use_ok "ReqMgmt::Contained";
use_ok "ReqMgmt::Document";
use_ok "ReqMgmt::LinkedList";
use_ok "ReqMgmt::Id::Simple";
use_ok "ReqMgmt::Fragment::HTML";
use_ok "ReqMgmt::Id";
use_ok "ReqMgmt::Renderable";
use_ok "ReqMgmt::Section";
use_ok "ReqMgmt::Organisation";
use_ok "ReqMgmt::Storage";
use_ok "ReqMgmt::Person";
use_ok "ReqMgmt::Container::SubSections";
use_ok "ReqMgmt::Container::Fragments";

