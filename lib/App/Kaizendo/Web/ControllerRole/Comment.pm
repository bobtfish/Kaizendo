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
    $c->stash( template => \'Hello world _comment_list' );
}

1;
