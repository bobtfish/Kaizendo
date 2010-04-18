package App::Kaizendo::Web::Controller::Comment;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::REST'; }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '_c');

=head1 NAME

Kaizendo::Controller::Comment - Comment-handler for Kaizendo

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index : Path : ActionClass('REST') {
    my ( $self, $c ) = @_;
}

sub index_GET {
    my ( $self, $c ) = @_;
    my $accepts = $c->req->headers->{accept};

    my $id = $c->req->args->[0];

    $self->status_ok(
        $c,
        entity => {
            accepts => $accepts,
            comment => {
                from => q(sjn@pvv.org),
                re => q(id00105),
                id => $id,
                content => q(Well done!),
            },
        },
    );
}


=head1 AUTHOR

Salve J. Nilsen <sjn@kaizendo.org>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the terms of the GNU Affero General Public License v3, AGPLv3.

See L<http://opensource.org/licenses/agpl-v3.html> for details.

=cut

__PACKAGE__->meta->make_immutable;

1;
