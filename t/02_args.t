use strict;
use warnings;
use Test::More;

use Object::Container::Flexible;

my $class = 't::SampleClass';
my $c = Object::Container::Flexible->new;

$c->register($class, { args => [ text => 'custom args' ] });
isa_ok +$c->get($class), $class;
is +$c->get($class)->text, 'custom args', 'args set ok';

done_testing;
