#!/usr/bin/perl
use strict;
use warnings;

my $Ifname = 'signal_list';
# my $Ofname = 'connection_list';
open(my $IFS, '<', $Ifname);
# open(my $OFS, '>', $Ofname);
my $BMname = $ARGV[0];
my $Npats = $ARGV[1]; # numbers of patterns of each task
my @t0;
my $t1;
my @sig;
while (my $row = <$IFS>) {
    if ($row =~ m/^$BMname/) {
        @t0 = split(' ', $row);
        $t1 = $t0[1];
        chomp($t1);
        @sig = split(',', $t1);
        last;
    }
}

my $Nin = shift(@sig);
my $Nout = shift(@sig);

my @result;
my @wires;
my $i = 0;
foreach my $value (@sig) {
    if ($i < $Nin) {
        my $idx = $Nin-1-$i;
        push(@result, ".$value(vec[$idx]),");
    }
    else {
        my $wire = lc($value);
        push(@wires, "$wire,");
        push(@result, ".$value($wire),");
        if ($i == ($Nin+$Nout-1)) {
            my $t = pop(@result);
            my $w = pop(@wires);
            chop($w);
            push(@wires, $w);
            chop($t);
            push(@result, $t);
        }
    }
    $i = $i+1;
}


## Output
## _0
#print $OFS "$BMname\_testfixture\n";
## _1
#print $OFS "$BMname/rand_input_vector_$BMname\_0.out\n";
## _2
#print $OFS "$BMname/rand_output_vector_$BMname\_0.out\n";
## _3
#print $OFS "$Nin\n";
## _4
#print $OFS "31\n";
## _5
#print $OFS "@wires\n";
## _6
#print $OFS "$BMname $BMname\_0 (@result)\n";
## _7
#print $OFS "@wires\n";

close($IFS);
#close($OFS);


my $out_file = "$BMname\_testfixture.v";
open(my $IFS1, '<', 'tb_templete.v');
open(my $OFS1, '>', $out_file);
while(my $row = <$IFS1>) {
    $row =~ s/_0/$BMname\_testfixture/;
    $row =~ s/_1/$BMname\/rand_input_vector_$BMname\_0.out/;
    $row =~ s/_2/$BMname\/rand_output_vector_$BMname\_0.out/;
    $row =~ s/_3/$Nin/;
    $row =~ s/_4/$Npats/;
    $row =~ s/_5/@wires/;
    $row =~ s/_6/$BMname cc (@result);/;
    $row =~ s/_7/@wires/;
    print $OFS1 "$row";
}





