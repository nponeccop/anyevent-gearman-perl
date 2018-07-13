use v5.10;
use strict;
use warnings;
use CPAN::Meta;
use Module::Load;
 
my $meta = CPAN::Meta->load_file('META.json');
 
printf "testing requirements for %s version %s\n",
$meta->name,
$meta->version;
 
my $prereqs = $meta->effective_prereqs;
 
for my $phase ( qw/develop configure runtime build test/ ) {
    say "Requirements for $phase:";
    my $reqs = $prereqs->requirements_for($phase, "requires");
    for my $module ( sort $reqs->required_modules ) {
        my $status;
        if ( eval { load $module unless $module eq 'perl'; 1 } ) {
            my $version = $module eq 'perl' ? $] : $module->VERSION;
            $status = $reqs->accepts_module($module, $version)
                    ? "$version ok" : "$version not ok";
        } else {
            $status = "missing"
        };
        say "  $module ($status)";
    }
}
