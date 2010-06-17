package App::Kaizendo::Web::ControllerBase::REST;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
    default   => 'text/html',
    stash_key => 'rest',
    map       => {
        'text/html'        => [ 'View', 'HTML', ],
        'application/json' => 'JSON',
        'text/x−json'    => 'JSON',
    },
);

=head1 NAME

App::Kaizendo::Web::ControllerBase::REST

=cut

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

__PACKAGE__->meta->make_immutable;
