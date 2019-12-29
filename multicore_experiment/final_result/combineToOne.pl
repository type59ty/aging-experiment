#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;
#my @benchmark = ("c432", "c499", "c1908", "c5315", "c6288", "c7552", "b14_ras", "b15_ras", "b20_ras", "b21_ras");
# my @benchmark = ("c432", "c499", "c1908", "c5315", "c7552");
my @benchmark = ("c432");
my @num_critical = ("2","4","6");
#my @num_critical = ("random");
my @tag = ("lifetime", "energy");
my $directory = "";
my $target_dir = "";
my $target_file;
#print "$directory\n";	 
my $open_file = "";

my $wfile = "final_result.csv";
unless(open WFILE, '>'.$wfile) {
  # Die with error message 
  # if we can't open it.
  die "\nUnable to create $wfile\n";
}
foreach my $i (@num_critical){
  foreach my $j (@tag){
    my $counter = 0;
    foreach my $k (@benchmark){
      $open_file = "$k\_$j\_$i.csv";
      open my $fh, $open_file or die "Could not open $open_file: $!";
      if($counter eq 0){
        my $policy_line;
        $policy_line = <$fh>; 
        print WFILE "$j\_$i$policy_line";   
        $counter++;        
      }
      my $last_line;
      while(<$fh>){
        $last_line = $_;
      }
      print WFILE "$k$last_line\n";
      close $fh;
    }
    print WFILE "\n\n\n\n";
  }
}
close(WFILE);
