package t::SampleClass;
use base 'Class::Accessor::Fast';

__PACKAGE__->mk_accessors(qw/text/);

sub new {
    my $class = shift;
    my $args  = @_ > 1 ? {@_} : $_;

    $class->SUPER::new($args);
}
1;
