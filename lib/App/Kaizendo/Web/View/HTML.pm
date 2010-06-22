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

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

1;
