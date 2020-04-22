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
        @t0 = split(',', $row);
        shift(@t0);
        @sig = @t0;
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

        # if ($i == ($Nin+$Nout-1)) {
        #     my $t = pop(@result);
        #     my $w = pop(@wires);
        #     chop($w);
        #     push(@wires, $w);
        #     chop($t);
        #     push(@result, $t);
        # }
    }
    $i = $i+1;
}


foreach my $tmp (@result) {
    print "$tmp\n";
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
# print $OFS "@wires\n";
close($IFS);
#close($OFS);


my $out_file = "$BMname\_testfixture.v";
open(my $IFS1, '<', 'tb_templete.v');
open(my $OFS1, '>', $out_file);
while(my $row = <$IFS1>) {
    $row =~ s/slot_0/$BMname\_testfixture/;
    $row =~ s/slot_1/$BMname\/rand_input_vector_$BMname\_0.out/;
    $row =~ s/slot_2/$BMname\/rand_output_vector_$BMname\_0.out/;
    $row =~ s/slot_3/$Nin/;
    $row =~ s/slot_4/$Npats/;
    $row =~ s/slot_5/@wires/;
    $row =~ s/slot_6/$BMname cc (@result);/;
    $row =~ s/slot_7/@wires/;
    print $OFS1 "$row";
}


close($OFS1);
close($IFS1);

