package Mau5;
use Moose;
use MooseX::AttributeHelpers;
use namespace::autoclean;
use Catalyst::Runtime '5.80';
use ReqMgmt;

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple
    Authentication
    Session
    Session::State::Cookie
    Session::Store::File
    Unicode
/;

extends 'Catalyst';

no Class::C3::Adopt::NEXT qw/
    Mau5::View::TT
    Mau5
/;

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in mau5.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Mau5',
    static => {
        mime_types => {
            xsl => 'text/xml',
        },
        ignore_extensions => [ qw/tmpl tt tt2/ ],
    },
    'Plugin::Authentication' => {
        realms => {
            default => {
                credential => {
                    # see L<KiokuX::User>
                    class         => 'Password',
                    password_type => 'self_check'
                },
                store => {
                    class      => 'Model::KiokuDB',
                    model_name => "Kioku", # whatever your model is actually named
                }
            }
        }
    },
    default_view => 'HTML',
    'Action::RenderView' => {
        ignore_classes => [qw/
            KiokuDB::Backend::DBI
            KiokuDB::LiveObjects::Guard
            KiokuDB::LiveObjects
            KiokuDB::TypeMap::Resolver
            DBIx::Class::ResultSource::Table
            DBIx::Class::ResultSourceHandle
            DateTime
        /],
    },
);

has javascripts => (
    metaclass => 'Collection::Array',
    isa => 'ArrayRef[Str]',
    is => 'ro',
    auto_deref => 1,
    clearer => '_clear_javascripts',
    lazy => 1,
    default => sub { [] },
    provides => {
        push => 'add_javascript',
    },
);
# Futz the add_javascript method so that it never returns anything.
around 'add_javascript' => sub { my $orig = shift; shift->$orig(@_); return };

# Start the application
__PACKAGE__->setup;

my $CAN_USE_REPL;
BEGIN {
    eval { require Carp::REPL };
    $CAN_USE_REPL = $@ ? 0 : 1;
}

sub setup_finalize {
    my $self = shift;
    $self->next::method(@_);
    $SIG{__DIE__} = \&Carp::REPL::repl
        if ($CAN_USE_REPL && $self->debug && $ENV{REPL});
}

=head1 NAME

Mau5 - Catalyst based application

=head1 SYNOPSIS

    script/mau5_server.pl

=head1 SEE ALSO

L<Mau5::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Tomas Doran

=head1 LICENSE

This library is commercial software, Copyright (c) 2009. All rights reserved.

=cut

__PACKAGE__->meta->make_immutable(replace_constructor => 1);
