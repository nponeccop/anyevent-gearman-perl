requires 'Any::Moose', '0.13';
requires 'AnyEvent', '5.12';
requires 'Filter::Util::Call';
requires 'Mouse', '0.80';
requires 'MouseX::Foreign';
requires 'Object::Container', '0.03002';
requires 'Object::Event', '1.0';

on build => sub {
    requires 'ExtUtils::MakeMaker', '6.36';
    requires 'Test::Deep';
    requires 'Test::Exception';
    requires 'Test::TCP', '0.08';
};

on test => sub {
    requires 'Test::Base';
    requires 'Test::Deep';
    requires 'Test::Exception';
    requires 'Test::More', '0.92';
    requires 'Test::TCP', '0.08';
};

on develop => sub {
    requires 'Module::Install';
    requires 'Module::Install::AuthorTests';
    requires 'Module::Install::ExtraTests';
    requires 'Module::Install::Repository';
    requires 'Module::Install::TestBase';
};
