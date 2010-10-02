use strict;
use warnings;
use Test::More;

use Object::Container::Flexible;

my $class = 't::SampleClass';
my $c = Object::Container::Flexible->new;

$c->register($class, { initializer => sub {
    $c->ensure_class_loaded($class);
    $class->new(text => 'custom initializer');
} });
isa_ok +$c->get($class), $class;
is +$c->get($class)->text, 'custom initializer', 'args set ok';

done_testing;
