#!/usr/bin/perl
use strict;
use warnings;

my $fname = 'test';
my $Ninputs;
my $Noutputs;


open(my $IFS, '<', $fname) or die "Could not open file $fname";


my $s1 = 0;
my $s2 = 0;

my @tmp;
my @arr;
my $r1;
my $r2;

while(my $row = <$IFS>) {
    if ($row =~ m/module\s$fname\s([A-Z0-9\(\,]+)/) {
        print ($1);
    }


}
# while(my $row = <$IFS>) {
#     if ($row =~ m/Ninputs\s([0-9]+)/) {
#         $Ninputs = $1;
#     }
#     if ($row =~ m/Noutputs\s([0-9]+)/) {
#         $Noutputs = $1;
#     }
# 
#     if ($row =~ m/module/) {
#         $s1 = 1;
#     }
#     if ($row =~ m/;/) {
#         $s2 = 1;
#     }
#     if ($s1 == 1) {
#         chop($row);
#         chop($row);
#         @tmp = split(',', $row);
#         push(@arr, @tmp);
#     }
#     if ($s2 == 1) {
#         last;
#     }
# }
# print "$arr[0]";



