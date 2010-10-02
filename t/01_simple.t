use strict;
use warnings;
use Test::More;

use Object::Container::Flexible;

my $c = Object::Container::Flexible->new;

ok +$c->register('Test::Builder'), 'register class ok';
isa_ok +$c->get('Test::Builder'), 'Test::Builder';

my $obj;
eval { $obj = $c->get('unknown_object') };
ok !$obj, 'return nothing when getting unknown object';
like $@, qr/"unknown_object" is not registered in Object::Container/, 'unknown object error ok';

done_testing;
