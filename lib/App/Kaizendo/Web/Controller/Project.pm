package App::Kaizendo::Web::Controller::Project;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';
with qw/
  App::Kaizendo::Web::ControllerRole::Aspect
  App::Kaizendo::Web::ControllerRole::User
  App::Kaizendo::Web::ControllerRole::Comment
  /;

=head1 NAME

Kaizendo::Controller::Project - Project Controller for Kaizendo

=head1 DESCRIPTION

Handles information about the individual text project.

=head1 METHODS

=head2 base

FIXME

=cut

sub base : Chained('/base') PathPart('') CaptureArgs(0) {
}

=head2 item

FIXME

=cut

sub item : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $project_name ) = @_;
}

=head2 view

FIXME

=cut

sub view : Chained('item') PathPart('') Args(0) {
}

__PACKAGE__->config(
    action => {
        aspect_base  => { Chained => 'item' },
        user_base    => { Chained => 'item' },
        comment_base => { Chained => 'item' },
    },
);

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

__PACKAGE__->meta->make_immutable;
