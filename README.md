# NAME

AnyEvent::Gearman - Asynchronous Gearman client/worker module for AnyEvent applications

# SYNOPSIS

    use AnyEvent::Gearman;

Client:

    my $client = gearman_client '127.0.0.1', '192.168.0.1:123';
    
    $client->add_task(
        $function => $workload,
        on_complete => sub {
            my $result = $_[1];
            # ...
        },
        on_fail => sub {
            # job failed
        },
    );

Worker:

    my $worker = gearman_worker '127.0.0.1', '192.168.0.1:123';
    
    $worker->register_function(
        reverse => sub {
            my $job = shift;
            my $res = reverse $job->workload;
            $job->complete($res);
        },
    );

# DESCRIPTION

AnyEvent::Gearman is a module set of client/worker modules for Gearman for AnyEvent applications.

This module provides some shortcuts for [AnyEvent::Gearman::Client](https://metacpan.org/pod/AnyEvent::Gearman::Client) and [AnyEvent::Gearman::Worker](https://metacpan.org/pod/AnyEvent::Gearman::Worker).
Please read these modules documentation for more details.

# EXPORTED FUNCTIONS

## gearman\_client( @job\_servers );

Create a gearman client.

    my $client = gearman_client '127.0.0.1', '192.168.0.1:123';

This is shortcut for:

    my $client = AnyEvent::Gearman::Client->new(
        job_servers => ['127.0.0.1', '192.168.0.1:123'],
    );

See [AnyEvent::Gearman::Client](https://metacpan.org/pod/AnyEvent::Gearman::Client) for more detail.

## gearman\_worker( @job\_servers );

Create a gearman worker.

    my $worker = gearman_worker '127.0.0.1', '192.168.0.1:123';

This is shortcut for:

    my $worker = AnyEvent::Gearman::Worker->new(
        job_servers => ['127.0.0.1', '192.168.0.1:123'],
    );

See [AnyEvent::Gearman::Worker](https://metacpan.org/pod/AnyEvent::Gearman::Worker) for more detail.

# AUTHOR

Daisuke Murase <typester@cpan.org>

Pedro Melo <melo@cpan.org>

# COPYRIGHT AND LICENSE

Copyright (c) 2009 by KAYAC Inc.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.
