#!perl

use strict;
use warnings;
use Test::Base;
use Test::TCP;

use AnyEvent::Gearman::Worker;

eval q{
        use Gearman::Worker;
        use Gearman::Server;
    };
if ($@) {
    plan skip_all
        => "Gearman::Worker and Gearman::Server are required to run this test";
}

plan 'no_plan';

my $port = empty_port;

sub run_tests {
    my $server_hostspec = '127.0.0.1:' . $port;

    my $worker = AnyEvent::Gearman::Worker->new(
        job_servers => [$server_hostspec],
    );
    $worker->register_function( reverse => sub {
        my $job = shift;
        my $res = reverse $job->workload;
        $job->status(99, 100);
        $job->complete($res);
    });

    eval {
        $worker->register_function( reverse => sub {} );
    };
    like $@, qr/"reverse" already registered/, 'already registered';

    $worker->unregister_function( 'reverse' );
    eval {
        $worker->register_function( reverse => sub {} );
    };
    is $@, '', 'register after unregister successful';
}

my $child = fork;
if (!defined $child) {
    die "fork failed: $!";
}
elsif ($child == 0) {
    my $server = Gearman::Server->new( port => $port );
    Danga::Socket->EventLoop;
    exit;
}
else {
    END { kill 9, $child if $child }
}

sleep 1;

run_tests;

