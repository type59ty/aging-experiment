#!/usr/bin/perl
use strict;
use warnings;

my $fname = 'c432.v';
open(my $IFS, '<', $fname);

my $s1 = 0;
my $s2 = 0;

while(my $row = <$IFS>) {
    if ($row =~ m/module/) {
        $s1 = 1;
    }
    if ($row =~ m/;/) {
        $s2 = 1;
    }
    if ($s1 == 1) {
        print($row);
        # if ($row =~ m/[0-9A-Z]/)  {
        #     # push(@arr, $row);
        # }
    }
    if ($s2 == 1) {
        last;
    }
}
