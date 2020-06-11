#!/usr/bin/perl
# Porgram: run_hspice.pl
# Author: Kun-Wei Chiu
# Last Update: 2017/03/05
# example: ./run_hspice.pl benchmark_name mode |& tee run_hspice_new.log
# warning: Don't forget change current shell to tcsh firstly !

use strict;
use warnings;
use File::Basename;
my $Line = "";
my $log_file;
my $benchmark_name = $ARGV[0];
my $directory = "./test_header/$benchmark_name";
my $mode = $ARGV[1]; #Normal or Search
print "$directory\n";	 
system("date");
opendir (DIR, $directory) or die $!;
while (my $file = readdir(DIR)) {
  if($file eq '.' || $file eq '..'){
  }
  else{
    #print "$file\n";
    my($basename) = basename($file, '.sp');
    my @split_basename = split '\_', $basename;
    my $task_number = $split_basename[0];	
    #if dir. hspice_result doesn't exist, make the dir.
    if (-e "hspice_result/$benchmark_name/$task_number"){}
    else {
      mkdir("hspice_result/$benchmark_name/$task_number", 0755);
  	  system("sleep 0.1s");
    } 
  	if(-e "hspice_result/$benchmark_name/$task_number/$basename"){
    }
    else{
      mkdir("hspice_result/$benchmark_name/$task_number/$basename", 0755);
  	  system("sleep 0.1s");
    }
    if($mode eq "Normal" || $mode eq "N"){
      system("hspice -mt 15 -i $directory/$file -o ./hspice_result/$benchmark_name/$task_number/$basename");
      system("sleep 0.1s");
      # unmark below 
      system("rm -rf ./hspice_result/$benchmark_name/$task_number/$basename/$basename.tr0");
      system("sleep 0.1s");
    }
    elsif($mode eq "Search" || $mode eq "S"){
      my $search = "./hspice_result/$benchmark_name/$task_number/$basename";
      #print "$search\n";
      my $flag = "";
      open $log_file, '<', "run_hspice.log";
      while(my $Line = <$log_file>){
        if(grep(/$search/, $Line)){
          $flag = "true";
          last;
        }
      }
      if($flag eq "true"){
        #print "find\n";
      }
      else{
        #print "can't find\n";
        system("hspice -mt 15 -i $directory/$file -o ./hspice_result/$benchmark_name/$task_number/$basename");
        system("sleep 0.1s");
        system("rm -rf ./hspice_result/$benchmark_name/$task_number/$basename/$basename.tr0");
        system("sleep 0.1s");			
      	
      }
      close $log_file;     
    }
  }
}
closedir(DIR);
system("date");


