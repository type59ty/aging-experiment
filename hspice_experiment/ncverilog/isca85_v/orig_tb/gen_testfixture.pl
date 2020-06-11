#!/usr/bin/perl
use strict;
use warnings;

my $fname = 'c432.v';
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
    if ($row =~ m/Ninputs\s([0-9]+)/) {
        $Ninputs = $1;
    }
    if ($row =~ m/Noutputs\s([0-9]+)/) {
        $Noutputs = $1;
    }

    if ($row =~ m/module/) {
        $s1 = 1;
    }
    if ($row =~ m/;/) {
        $s2 = 1;
    }
    if ($s1 == 1) {
        chop($row);
        chop($row);
        @tmp = split(',', $row);
        push(@arr, @tmp);
    }
    if ($s2 == 1) {
        last;
    }
}
my @fir = split(' ', $arr[0]);
my $first;
if($fir[2] =~ m/\(([A-N][0-9]+)/) {
    $first = $1;
}

$arr[0] = $first;


print "$arr[10]";



