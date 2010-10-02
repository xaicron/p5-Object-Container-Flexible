use strict;
use warnings;
use Test::More;

use Object::Container::Flexible;

my $class = 't::SampleClass';
my $c = Object::Container::Flexible->new;

$c->register($class, { initializer => sub {
    $c->ensure_class_loaded($class);
    $class->new(text => 'preloadable');
}, preload => 1 });
isa_ok +$c->objects->{$class}, $class;
is $c->objects->{$class}->text, 'preloadable', 'args set ok';

done_testing;
