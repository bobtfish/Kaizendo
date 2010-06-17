package App::Kaizendo::Web::ControllerRole::Comment;
use MooseX::MethodAttributes::Role;
use namespace::autoclean;

=head1 NAME

App::Kaizendo::Web::ControllerRole::Comment

=head1 METHODS

=head2 comment_base

FIXME

=cut

sub comment_base : Chained('base') PathPart('_c') CaptureArgs(0) {
}

=head2 comment_list

Lists available comments

=cut

sub comment_list : Chained('comment_base') PathPart('') Args(0)
  ActionClass('REST') {
    my ( $self, $c ) = @_;
}

=head2 comment_list_GET

GET handler for the comment list method

=cut

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

=head1 AUTHORS

Salve J. Nilsen <sjn@kaizendo.org>
Thomas Doran <bobtfish@bobtfish.net>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

1;
