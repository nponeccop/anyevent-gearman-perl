use Test::More;
eval "require 5.020";
plan skip_all => "perl 5.18 and earlier return false lack of coverage"
    if $@;
eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;
all_pod_coverage_ok({ also_private => ['BUILD', 'BUILDARGS', qr/^process_/] });
