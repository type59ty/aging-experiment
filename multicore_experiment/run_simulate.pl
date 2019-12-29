#!/usr/bin/perl
use strict;
# my @benchmark = ("c17", "c432", "c499", "c1908", "c5315", "c7552");
my @benchmark = ("c864");
#policy (Symmetric -> 0), (Variation_Aware -> 1), (Spare_core -> 2), (Asymmetric -> 3), (ROAD -> 4) 
foreach my $i (@benchmark){
  # print "./simulate_parameter.pl $i 0 \n";
  # system("./simulate_parameter.pl $i 0 &");
  # system("sleep 1s");
  # print "./simulate_parameter.pl $i 1 \n";
  # system("./simulate_parameter.pl $i 1 &");
  # system("sleep 1s");
  # print "./simulate_parameter.pl $i 2 \n";
  # system("./simulate_parameter.pl $i 2 &");
  # system("sleep 1s");
  print "./simulate_parameter.pl $i 3 \n";
  system("./simulate_parameter.pl $i 3 &");
  system("sleep 1s");
  # print "./simulate_parameter.pl $i 4 \n";
  # system("./simulate_parameter.pl $i 4 &");
  # system("sleep 1s");
}
exit(0);

