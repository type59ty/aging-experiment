#!/usr/bin/perl
use strict;
use warnings;

my $str = "  N137;";
my @tmp = split(',', $str);
$tmp[0] =~ s/^\s+//;

foreach my $s (@tmp) {
    print "$s\n";
}

#print "$str\n";

