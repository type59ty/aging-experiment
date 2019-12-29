#!/usr/bin/perl
use strict;
#my $benchmark = $ARGV[0];
#my @benchmark = ("c432", "c499", "c1908", "c5315", "c6288", "c7552", "b14_ras", "b15_ras", "b20_ras", "b21_ras");
# my @benchmark = ("c432", "c499", "c1908", "c5315", "c7552");
my @benchmark = ("c432");
my $env = "../env";
my $num_policy = 3;
my $policy_list = "Symmetric Variation_Aware Asymmetric";
# my $policy_list = "Symmetric Reschduling_Asymmetric";


foreach my $i (@benchmark){
  print "./main --benchmark $i --env $env --num_policy $num_policy --policy_list $policy_list \n";
  system("date");
  system("./main --benchmark $i --env $env --num_policy $num_policy --policy_list $policy_list");
  system("date");  
}
system("./combineToOne.pl");
system("sleep 1s");
# system("rm *_lifetime_*.csv");
# system("rm *_energy*.csv");
