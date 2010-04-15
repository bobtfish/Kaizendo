package Mau5::Controller::Root;
use Moose;
BEGIN { extends 'Mau5::Controller'; }
use namespace::clean -except => 'meta';
#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

sub root : Chained('/') PathPart('') CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->_clear_javascripts;
    $c->stash->{SOFTWARE_VERSION} = $Mau5::VERSION_KEYWORD ? $Mau5::VERSION_KEYWORD . ' (' . $Mau5::VERSION . ')' : $Mau5::VERSION;
    $c->forward('/project/project_list_dropdown');
}

sub index_page : Chained('root') PathPart('') Args(0) {
    my ($self, $c) = @_;
    if ($c->user) {
        $c->stash->{template} = 'dashboard.tt';
        if ($c->user->get_object->admin) {
            $c->forward('/admin/dashboard');
        }
    }
}

sub error404 : Private {
    my ($self, $c) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub render : ActionClass('RenderView') {}

sub end : Private {
    my ($self, $c) = @_;
    if ($c->stash->{build_pdf_from_body}) {
	    my $xml = $c->view('Docbook')->render($c, 'project/project_overview.xml.tt');
        my ($dir, $pdf) = $c->model('PDF')->generate_from_xml($xml);
        $c->res->header('Content-Type', 'application/pdf');
        $c->serve_static_file("$dir/$pdf");
        system("rm -rf $dir");
    }
    else {
	    $c->forward('render');
    }

}

=head1 AUTHOR

Tomas Doran

=head1 LICENSE

This library is commercial software, copyright (c) 2009. All rights reserved.

=cut

__PACKAGE__->meta->make_immutable;
