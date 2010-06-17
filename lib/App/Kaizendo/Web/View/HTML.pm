package App::Kaizendo::Web::View::HTML;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::View::TT' }

__PACKAGE__->config( TEMPLATE_EXTENSION => '.html', );

=head1 NAME

App::Kaizendo::Web::View::HTML - TT View for App::Kaizendo::Web

=head1 DESCRIPTION

TT View for App::Kaizendo::Web. 

=head1 SEE ALSO

L<App::Kaizendo::Web>

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Tomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

1;
