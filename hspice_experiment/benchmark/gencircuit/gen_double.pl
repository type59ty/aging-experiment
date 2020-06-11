#!/usr/bin/perl

use strict;
use warnings;

sub ltrim { my $s = shift; $s =~ s/^\s+//; return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//; return $s };
sub trim  { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };


my $fname = "../isca85_v/c499";
my $output_file = "${fname}d";

open(my $IFS, "$fname.v") or die $!;
open(my $OFS, ">$output_file.v") or die $!;

my @module = ();
my @input = ();
my @output = ();
my @wire = ();
my @gate = ();

while (my $row = <$IFS>) {
    chomp($row);
    if ($row =~ "^//"){
        next;
    }
    if ($row =~ "^module") {
        # print "$row\n";
        my @tmp = split(' ', $row);
        @tmp = split(',', $tmp[2]);
        $tmp[0] =~ s/\(//g; # remove the '('
        foreach my $w (@tmp) {
            if ($w =~ /^\s+/) {
                next;
            } else {
                push(@module, $w);
            }
        }
        while ($row = <$IFS>) {
            chomp($row);
            @tmp = split(',', $row);
            $tmp[0] = &ltrim($tmp[0]);
            foreach my $w (@tmp) {
                if ($w =~ /^\s+/) {
                    next;
                } else {
                    push(@module, $w);
                }
            }
            if ($row =~ /.*;/) {
                $module[-1] =~ s/\);//;
                $row = <$IFS>;
                last;
            }
        }
    }

    if ($row =~ "^input") {
        my @tmp = split(' ', $row);
        @tmp = split(',', $tmp[1]);
        foreach my $w (@tmp) {
            if ($w =~ /^\s+/) {
                next;
            } else {
                push(@input, $w);
            }
        }
        while ($row = <$IFS>) {
            chomp($row);
            @tmp = split(',', $row);
            $tmp[0]  = &ltrim($tmp[0]);
            foreach my $w (@tmp) {
                if ($w =~ /^\s+/) {
                    next;
                } else {
                    push(@input, $w);
                }
            }
            if ($row =~ /.*;/) {
                $input[-1] =~ s/\;//;
                $row = <$IFS>;
                last;
            }
        }
    }

    if ($row =~ "^output") {
        my @tmp = split(' ', $row);
        @tmp = split(',', $tmp[1]);
        foreach my $w (@tmp) {
            if ($w =~ /^\s+/) {
                next;
            } else {
                push(@output, $w);
            }
        }
        while ($row = <$IFS>) {
            chomp($row);
            @tmp = split(',', $row);
            $tmp[0]  = &ltrim($tmp[0]);
            foreach my $w (@tmp) {
                if ($w =~ /^\s+/) {
                    next;
                } else {
                    push(@output, $w);
                }
            }
            if ($row =~ /.*;/) {
                $output[-1] =~ s/\;//;
                $row = <$IFS>;
                last;
            }
        }
    }

    if ($row =~ "^wire") {
        my @tmp = split(' ', $row);
        @tmp = split(',', $tmp[1]);
        foreach my $w (@tmp) {
            if ($w =~ /^\s+/) {
                next;
            } else {
                push(@wire, $w);
            }
        }
        while ($row = <$IFS>) {
            chomp($row);
            @tmp = split(',', $row);
            $tmp[0]  = &ltrim($tmp[0]);
            foreach my $w (@tmp) {
                if ($w =~ /^\s+/) {
                    next;
                } else {
                    push(@wire, $w);
                }
            }
            if ($row =~ /.*;/) {
                $wire[-1] =~ s/\;//;
                $row = <$IFS>;
                last;
            }
        }
    }

    # gate
    if ($row =~ /^\s/) {
        next;
    } else {
        my @tmp = split(' ', $row);
        $gate[0] = $tmp[0];
        $gate[1] = $tmp[1];
        @tmp = split(',', $tmp[2]);

        $tmp[0] =~ /^\s+\(/;
        if (($#tmp+1) > 2) {
            foreach my $g (@tmp) {
                &trim();
            }
        }
        
        print "$row\n";
    }


}
#foreach my $w (@module) {
#    print "$w\n";
#}
#print "\n";
#foreach my $w (@input) {
#    print "$w\n";
#}
#print "\n";
#foreach my $w (@output) {
#    print "$w\n";
#}
#print "\n";
#foreach my $w (@wire) {
#    print "$w\n";
#}



