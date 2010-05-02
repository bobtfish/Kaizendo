package App::Kaizendo::DataStore::Project;
use Moose;
use Method::Signatures::Simple;
use Moose::Autobox;
use MooseX::Types::Moose qw/ ArrayRef /;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

use aliased 'App::Kaizendo::DataStore::ProjectSnapshot';

has name => ( is => 'rw', required => 1 );

class_type 'App::Kaizendo::DataStore::ProjectSnapshot';
has snapshots => (
    is => 'ro',
    isa => ArrayRef,
    default => sub {
        my $self = shift;
        return [
            ProjectSnapshot->new(project => $self),
        ];
    },
    traits     => ['Array'],
);

method latest_snapshot { $self->snapshots->first }

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

App::Kaizendo::DataStore::Project - A project

=head1 AUTHORS, COPYRIGHT AND LICENSE

See L<App::Kaizendo> for Authors, Copyright and License information.

=cut
