#!/usr/bin/perl
# Proram: run_input_profile
# Author: Jain-Ting
# Last Update: 2018/06/11
# Objective: profile each input pattern with different environment 

##### aging simulation input variable #####
# if u want run ./run_wtm.pl, mark below four rows
# $ARGV[0];  # aging_time ex. 1m or 2m or 1y ...etc 
# $ARGV[1];  # supply_voltage (V)
# $ARGV[2];  # operate_frequecny (ns)
# $ARGV[3];  # number_of_task

# example:
#(1) general sim.: 1) remove the # of line26  2)$./run_genIsca85_header
#(2) aging sim.: $./run_genIsca85_header 32nm_bulk_0m.pm

use strict;


my $aging_time;
my @month_year = ("m", "y");
# my %operation_list1 = ('0.8' => 50, '0.9' => 50, '1.0' => 50, '1.1' => 50, '1.2' => 50);
my %operation_list1 = ('1.2' => 100);
# my %operation_list1 = ('0.8' => 50, '1.2' => 50);
# my %operation_list2 = ('0.8' => 100, '1.2' => 100);
my @operation_voltage1 = keys %operation_list1;
# my @operation_voltage2 = keys %operation_list2;
my $benchmark_name    = $ARGV[0];
my $input_vec_length  = $ARGV[1];
my $number_of_task    = $ARGV[2] + 1;

my $trans_input_vec_file_name;
my $trans_output_vec_file_name;


print "benchmark_name: $benchmark_name\n";
print "input_vec_length: $input_vec_length\n";
print "number_of_task: $number_of_task\n";

if (-e "test_header/$benchmark_name"){
    system("rm -rf test_header/$benchmark_name");
}


for (my $i = 0; $i < $number_of_task; $i++ ){
  my $time;
  foreach my $aging_month_year (@month_year){
	  my $j;
		if($aging_month_year eq "m"){
		  $time = 12;
			$j = 0;
		}
		else{
		  $time = 21;
			$j = 1;
		}
		for ($j ; $j < $time ; $j++){
		  $aging_time = "$j$aging_month_year";
		  $trans_input_vec_file_name = "input_pattern/$benchmark_name/trans_rand_input_vector_$benchmark_name\_$i.out";
		  $trans_output_vec_file_name = "input_pattern/$benchmark_name/trans_rand_output_vector_$benchmark_name\_$i.out";

		  foreach my $voltage (@operation_voltage1){
		  	my $frequency = $operation_list1{$voltage};
            print "generate task $i, voltage $voltage, frequency $frequency, aging $aging_time to hspice file\n";
            if ($benchmark_name =~ m/c[0-9]+/) {
		  	  system("./run_genIsca85_header.pl $aging_time $voltage $frequency $input_vec_length $trans_input_vec_file_name $trans_output_vec_file_name $i $benchmark_name");
            }
            else {
		  	  system("./run_genItc99_header.pl $aging_time $voltage $frequency $input_vec_length $trans_input_vec_file_name $trans_output_vec_file_name $i $benchmark_name");
            }
		  }					
		  # foreach my $voltage (@operation_voltage2){
		  # 	my $frequency = $operation_list2{$voltage};
          #   print "generate task $i, voltage $voltage, frequency $frequency, aging $aging_time to hspice file\n";
          #   if ($benchmark_name =~ m/c[0-9]+/) {
		  # 	  system("./run_genIsca85_header.pl $aging_time $voltage $frequency $input_vec_length $trans_input_vec_file_name $trans_output_vec_file_name $i $benchmark_name");
          #   }
          #   else {
		  # 	  system("./run_genItc99_header.pl $aging_time $voltage $frequency $input_vec_length $trans_input_vec_file_name $trans_output_vec_file_name $i $benchmark_name");
          #   }
		  # }					
		}
	}
}
