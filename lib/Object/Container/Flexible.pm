package Object::Container::Flexible;

use strict;
use warnings;
use 5.008_001;
our $VERSION = '0.01';

use base 'Object::Container';
use Data::Util qw/is_hash_ref is_code_ref is_array_ref/; 
use Carp qw/croak/;

sub register {
    my ($self, $class, $opts) = @_;
    $opts ||= {};
    croak "Usage: $self->register(\$class, \$hash_ref)" unless is_hash_ref $opts;

    my @rest;
    if (is_code_ref $opts->{initializer}) {
        push @rest, $opts->{initializer};
    }
    elsif (is_array_ref $opts->{args}) {
        @rest = @{$opts->{args}};    
    }

    $self->SUPER::register($class, @rest);
    
    if ($opts->{preload}) {
        $self->get($class);
    }

    return $self->registered_classes->{$class}; # initializer
}

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

Object::Container::Flexible - Flexible Object::Container

=head1 SYNOPSIS

  use Object::Container::Flexible;

  my $container = Object::Container::Flexible->new;
  $container->register('WWW::Mechanize', { initializer => sub {
      my $mech = WWW::Mechanize->new;
      $mech->agent_alias('Windows IE 6');
  }, preload => 1 });

=head1 DESCRIPTION

Object::Container::Flexible is extended L<Object::Container>.
It is difficult to change the existing interface on Object::Container (because there is no backward compatibility).
If this interface, adding new features is simple.

Currently I<preload> option support.

=head1 METHOD

=over

=item register( $class, $opts );

Register classes to container.

Most simple usage:

  Object::Container::Flexible->register('LWP::UserAgent');
  
equals to C<< Object::Container->register('LWP::UserAgent') >>.

Additional args for initializer:

  Object::Container::Flexible->register('LWP::UserAgent', { args => \@args });

It's also execute C<< LWP::UserAgent->new(@args) >>.

equals to C << Object::Container->register('LWP::UserAgent', @args);

Custom initializer:

  Object::Container::Flexible->register('LWP::UserAgent', { initializer => sub {
      my $ua = LWP::UserAgent->new;
      $ua->agent('Yet Another LWP::UserAgent');
      return $ua;
  } });

This coderef (initialize) should return object to contain.

equals to C<< Object::Container->register('LWP::UserAgent', $coderef) >>.

Preload:

  Object::Container::Flexible->register('LWP::UserAgent', { preload => 1 });
  Object::Container::Flexible->register('WWW::Mechanize', { initializer => sub {
      my $mech = WWW::Mechanize->new;
      $mech->agent_alias('Windows IE 6');
      return $mech;
  }, preload => 1 });

Creates an object upon registering.

=back

=head1 AUTHOR

xaicron E<lt>xaicron {at} cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2010 - xaicron

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Object::Container>

=cut
