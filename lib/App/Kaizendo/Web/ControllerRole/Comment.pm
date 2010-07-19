package App::Kaizendo::Web::ControllerRole::Comment;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

sub comment_base : Chained('base') PathPart('_c') CaptureArgs(0) {
}

sub comment_list : Chained('comment_base') PathPart('') Args(0)
  ActionClass('REST') {
    my ( $self, $c ) = @_;
}

sub comment_list_GET {
    my ( $self, $c ) = @_;
    my $accepts = $c->req->headers->{accept};

    my $id = $c->req->args->[0];

    $self->status_ok(
        $c,
        entity => {
            accepts => $accepts,
            comment => {
                from    => q(sjn@pvv.org),
                re      => q(id00105),
                id      => $id,
                content => q(Well done!),
            },
        },
    );
    $c->stash( template => 'comment/list.html' );
}


=head2 comment_show

Show a specific comment

=cut


sub comment_show : Chained('comment_base') PathPart('') Args(1)
  ActionClass('REST') {
    my ( $self, $c ) = @_;
}



sub comment_show_GET {
    my ( $self, $c ) = @_;
    my $accepts = $c->req->headers->{accept};

    my $id = $c->req->args->[0];

    $self->status_ok(
        $c,
        entity => {
            accepts => $accepts,
            comment => {
                from    => q(sjn@pvv.org),
                re      => q(id00105),
                id      => $id,
                content => q(Well done!),
            },
        },
    );
    $c->stash( template => 'comment/show.html' );
}


=head1 NAME

App::Kaizendo::Web::ControllerRole::Comment

=head1 METHODS

=head2 comment_base

FIXME

=head2 comment_list

Lists available comments

=head2 comment_list_GET

GET handler for the comment list method

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut

1;
