package App::Kaizendo::Web::Controller::Aspect;
use Moose;
use namespace::autoclean;

BEGIN { extends 'App::Kaizendo::Web::ControllerBase::REST' }

with 'App::Kaizendo::Web::ControllerRole::Prototype';

=head1 NAME

App::Kaizendo::Web::Controller::Aspect

=head1 METHODS

=head2 base

FIXME

=cut

sub base : Chained('/base') PathPart(';') CaptureArgs(0) {
}

=head2 list

FIXME

=cut

sub list : Chained('base') PathPart('') Args(0) {
}

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

__PACKAGE__->meta->make_immutable;
