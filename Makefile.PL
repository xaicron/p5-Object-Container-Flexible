use inc::Module::Install;
name 'Object-Container-Flexible';
all_from 'lib/Object/Container/Flexible.pm';

requires 'Object::Container', '0.0802';

#build_requires '';
test_requires 'Test::More', 0.96;

tests_recursive 't';
author_tests 'xt';

auto_include();
auto_set_repository();

WriteAll;
