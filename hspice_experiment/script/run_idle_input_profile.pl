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
# my %operation_list = ('0.8' => 100, '0.9' => 100, '1.0' => 100, '1.1' => 100, '1.2' => 100);
my %operation_list = ('0.8' => 50);
my @operation_voltage = keys %operation_list;
my $benchmark_name    = $ARGV[0];
my $input_vec_length  = $ARGV[1];
my $number_of_task    = $ARGV[2];

my $trans_input_vec_file_name;
my $trans_output_vec_file_name;


print "benchmark_name: $benchmark_name\n";
print "input_vec_length: $input_vec_length\n";
print "number_of_task: $number_of_task\n";

for (my $i = 0; $i < $number_of_task; $i++ ){
  my $time;
  foreach my $aging_month_year (@month_year){
	  my $j;
		if($aging_month_year eq "m"){
		  $time = 13;
			$j = 0;
		}
		else{
		  $time = 11;
			$j = 1;
		}
		for ($j ; $j < $time ; $j++){
		  $aging_time = "$j$aging_month_year";
			print "$aging_time\n";
		  $trans_input_vec_file_name = "input_pattern/trans_rand_input_vector_$benchmark_name\_idle.out";
			$trans_output_vec_file_name = "input_pattern/trans_rand_output_vector_$benchmark_name\_idle.out";
		  foreach my $voltage (@operation_voltage){
		  	my $frequency = $operation_list{$voltage};
		  	system("./run_genIsca85_header.pl $aging_time $voltage $frequency $input_vec_length $trans_input_vec_file_name $trans_output_vec_file_name $i");
		  }					
		}
	}
}
#system("./run_genIsca85_header.pl 0m 0.6 50 10 input_pattern/trans_rand_input_vector_c17_0.out input_pattern/trans_rand_output_vector_c17_0.out 0");
#system("./run_genIsca85_header.pl 0m 0.5 25 10 input_pattern/trans_rand_input_vector_c17_0.out input_pattern/trans_rand_output_vector_c17_0.out 0");
