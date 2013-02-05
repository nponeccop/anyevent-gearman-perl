package AnyEvent::Gearman::Task;
use Moo;

use AnyEvent::Gearman::Constants;

extends 'Object::Event';

has function => (
    is       => 'rw',
#    isa      => 'Str',
    required => 1,
);

has workload => (
    is       => 'rw',
#    isa      => 'Str',
    required => 1,
);

has unique => (
    is      => 'rw',
#    isa     => 'Str',
    default => sub { '' },
);

has job_handle => (
    is      => 'rw',
#    isa     => 'Str',
    default => sub { '' },
);

has [qw/on_created on_data on_complete on_fail on_status on_warning/] => (
    is      => 'rw',
#    isa     => 'CodeRef',
    default => sub { sub {} },
);

no Moo;

sub BUILDARGS {
    my ($self, $function, $workload, %params) = @_;

    return {
        function => $function,
        workload => $workload,
        %params,
    }
}

sub BUILD {
    my $self = shift;

    $self->reg_cb(
        on_created   => $self->on_created,
        on_data      => $self->on_data,
        on_complete  => $self->on_complete,
        on_fail      => $self->on_fail,
        on_status    => $self->on_status,
        on_warning   => $self->on_warning,
    );
}

sub pack_req {
    my ($self, $type) = @_;
    $type = $type && $type eq 'bg'? SUBMIT_JOB_BG : SUBMIT_JOB;

    my $data = $self->function . "\0"
             . $self->unique . "\0"
             . $self->workload;

    "\0REQ" . pack('NN', $type, length($data)) . $data;
}

sub pack_option_req {
    my ($self, $option) = @_;

    "\0REQ" . pack('NN', OPTION_REQ, length($option)) . $option;
}

1;

__END__

=head1 NAME

AnyEvent::Gearman::Task - gearman task

=head1 METHODS

=head2 pack_req

=head2 pack_option_req

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

Pedro Melo <melo@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2009 by KAYAC Inc.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
