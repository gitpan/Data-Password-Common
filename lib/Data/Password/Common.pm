use v5.10;
use strict;
use warnings;

package Data::Password::Common;
# ABSTRACT: Check a password against a list of common passwords
our $VERSION = '0.001'; # VERSION

# Dependencies
use File::ShareDir;
use IO::File;
use Search::Dict;
use autodie 2.00;

use Sub::Exporter -setup => { exports => ['found'] };

my $list_path = File::ShareDir::dist_file( "Data-Password-Common", "common.txt" )
  or die "Can't locate common passwords file";

my $list_handle = IO::File->new($list_path);

sub found {
  return unless @_;
  my $password = shift;

  look $list_handle, $password;
  chomp( my $found = <$list_handle> );
  return $found eq $password;
}

1;


# vim: ts=2 sts=2 sw=2 et:

__END__

=pod

=head1 NAME

Data::Password::Common - Check a password against a list of common passwords

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  use Data::Password::Common 'found';

  if ( found( $password ) ) {
    die "'$password' is a common password"
  }

  # import with aliasing
  use Data::Password::Common found => { -as => "found_common" };

=head1 DESCRIPTION

This module installs a list of 62 thousand common passwords and provides
a function to check a string against the list.

The password list from InfoSecDaily
at L<http://www.isdpodcast.com/resources/62k-common-passwords/>

=for Pod::Coverage method_names_here

=head1 USAGE

Functions are provided via L<Sub::Exporter>.  Nothing is exported by default.

=head2 found

  found($password);

Returns true if the password is in the common passwords list.

=head1 SEE ALSO

=over 4

=item *

L<Data::Password>

=item *

L<Data::Password::Entropy>

=item *

L<Data::Password::BasicCheck>

=back

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com//data-password-common/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/dagolden/data-password-common>

  git clone git://github.com/dagolden/data-password-common.git

=head1 AUTHOR

David Golden <dagolden@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
