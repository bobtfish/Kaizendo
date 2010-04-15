package Mau5::Controller::Project;
use Moose;
use URI::Escape;
use KiokuDB::Util qw/set/;
use namespace::autoclean;

BEGIN { extends 'Mau5::Controller' }

sub root : Chained('/root') PathPart('project') CaptureArgs(0) {
    my ($self, $c) = @_;
    $c->res->redirect($c->uri_for('/login')) unless $c->user;
}

sub project_list_dropdown : Private {
    my ($self, $c) = @_;
    $c->stash->{list} = [];
    if ($c->user) {
        # FIXME - Abstraction fail!
        if ($c->user->get_object->admin) {
             $c->stash->{list} = $c->model('Kioku')->get_all_projects;
        }
        else {
            $c->stash->{list} = [ $c->user->get_object->organisation->documents->members ];
        }
    };
}

sub project_name : Chained('root') PathPart('') CaptureArgs(1) {
    my ($self, $c, $project_name) = @_;
    return unless $c->user;
    if ($project_name =~ m/\.(xml|pdf)$/i) {
        my $type = $1;
        $c->stash->{current_view} = 'Docbook';
        if ($type =~/pdf/i) {
            $c->stash->{build_pdf_from_body} = 1;
        }
    }
    $project_name = $c->stash->{project_name} = (split /\./, $project_name)[0];
    # FIXME - Abstraction fail.
    my $document = $c->stash->{document}
        = $c->model('Kioku')->get_project_by_name($project_name);
    if (!$c->user->get_object->admin) {
        $c->res->redirect($c->uri_for('/'))
            unless ($c->user->get_object->organisation->documents->contains($document));
    }

    $c->stash->{summary} = $c->view('HTML')->render($c, 'project/summary.tt', { %{$c->stash}, nowrap => 1 });
}

sub add : Chained('root') PathPart('add') Args(0) {
    my ($self, $c) = @_;
    return unless $c->req->method eq 'POST';
    my $doc = $c->user->get_object->new_document(
        name => $c->req->body_parameters->{'name'},
    );
    $c->model('Kioku')->store($doc);
    $c->res->redirect(
        $c->uri_for($self->action_for('project_overview'), [ $doc->name ])
    );
}


sub project_overview : Chained('project_name') PathPart('') Args(0) {

}

sub list : Chained('root') PathPart('') Args(0) {
    my ($self, $c) = @_;
    if ($c->request->param('project')) {
        $c->response->redirect($c->uri_for(
            $c->controller->action_for('project_overview'),
            [$c->request->param('project')]
        ));
    }
}

sub find_subsection : Private {
    my ($self, $c, @subsection) = @_;
    my $document = $c->stash->{document} or return;
    my $subsection = $document->find_subsection_from_list(map { uri_unescape($_) } @subsection);
    $c->stash->{subsection} = $subsection;
}

sub project : Chained('project_name') PathPart('section') Args() {
    my ($self, $c, @subsection) = @_;
    $c->forward('find_subsection', @subsection);
    $c->stash->{template} = 'project/section_edit.tt' if $c->request->param('edit');
    $c->detach('section_do_edit') if $c->request->method eq 'POST';
}

sub section_do_edit : Private {
    my ($self, $c) = @_;
    my $subsection = $c->stash->{subsection} or return;
    # FIXME
    $c->stash->{rest} = $subsection->set_from_json( $c->model('Kioku'), $c->request->data );
}

use URI::Escape qw/uri_unescape/; # HATE
sub add_subsection : Chained('project_name') PathPart('add_subsection') Args() {
    my ($self, $c, @subsection) = @_;
   #$c->stash->{document}->add_section; 
    $c->forward('find_subsection', @subsection);
    return unless $c->req->method eq 'POST';
    my $subsection_name = $c->req->param('subsection_name');
    $c->stash->{subsection}->add_child_section( name => $subsection_name );
    $c->model('Kioku')->store($c->stash->{subsection});
    my @args = map { uri_unescape($_) } @{  $c->req->arguments };
    push(@args, $subsection_name);
    $c->res->redirect(
        $c->uri_for($self->action_for('project'), $c->req->captures, @args)
    );
}

after 'end' => sub { my ($self, $c) = @_; $c->forward('/end'); };

__PACKAGE__->meta->make_immutable;

