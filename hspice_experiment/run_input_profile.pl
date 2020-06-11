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
#my %operation_list1 = ('1.0' => 50);
my %operation_list1 = ('0.8' => 50);
#my %operation_list1 = ('1.0' => 50);
my @operation_voltage1 = keys %operation_list1;
# my @operation_voltage2 = keys %operation_list2;
my $benchmark_name    = $ARGV[0];
my $input_vec_length  = $ARGV[1];
# my $number_of_task    = $ARGV[2] + 1; # idle task
my $number_of_task    = $ARGV[2];

my $trans_input_vec_file_name;
my $trans_output_vec_file_name;


print "benchmark_name: $benchmark_name\n";
print "input_vec_length: $input_vec_length\n";
print "number_of_task: $number_of_task\n";

if (-e "test_header/$benchmark_name"){
    system("rm -rf test_header/$benchmark_name");
}

my $margin;
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
		    # $time = 2;
			$j = 1;
		}
		for ($j ; $j < $time ; $j++){
		  $aging_time = "$j$aging_month_year";
		  $trans_input_vec_file_name = "input_pattern/$benchmark_name/trans_rand_input_vector_$benchmark_name\_$i.out";
		  $trans_output_vec_file_name = "input_pattern/$benchmark_name/trans_rand_output_vector_$benchmark_name\_$i.out";
        
          $margin = &append_margin($aging_time);

		  foreach my $voltage (@operation_voltage1){
		  	my $frequency = $operation_list1{$voltage};
            print "generate task $i, voltage $voltage, frequency $frequency, aging $aging_time to hspice file\n";
            if ($benchmark_name =~ m/c[0-9]+/) {
		  	  system("./run_genIsca85_header.pl $aging_time $voltage $frequency $input_vec_length $trans_input_vec_file_name $trans_output_vec_file_name $i $benchmark_name $margin");
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

sub append_margin {
    my $age = shift;
    my $margin;

    # if ($age =~ /[0-9]+m/) {
    #     $margin = 3;   
    # } else {
    #     $margin = 4;
    # }

    # if ($age == "0m") {
    #     $margin = 3;
    # } 
    # elsif ($age == "1m") {
    #     $margin = 3.8;
    # }
    # elsif ($age == "2m") {
    #     $margin = 3.9;
    # }
    # elsif ($age == "3m") {
    #     $margin = 4;
    # }
    # elsif ($age == "4m") {
    #     $margin = 4.1;
    # }
    # elsif ($age == "5m") {
    #     $margin = 4.1;
    # }
    # elsif ($age == "6m") {
    #     $margin = 4.1;
    # }
    # elsif ($age == "7m") {
    #     $margin = 4.2;
    # }
    # elsif ($age == "8m") {
    #     $margin = 4.2;
    # }
    # elsif ($age == "9m") {
    #     $margin = 4.3;
    # }
    # elsif ($age == "10m") {
    #     $margin = 4.3;
    # }
    # elsif ($age == "11m") {
    #     $margin = 4.3;
    # }
    # elsif ($age == "1y") {
    #     $margin = 4.4;
    # }
    # elsif ($age == "2y") {
    #     $margin = 4.6;
    # }
    # elsif ($age == "3y") {
    #     $margin = 4.8;
    # }
    # elsif ($age == "4y") {
    #     $margin = 4.9;
    # }
    # elsif ($age == "5y") {
    #     $margin = 5;
    # }
    # elsif ($age == "6y") {
    #     $margin = 5.1;
    # }
    # elsif ($age == "7y") {
    #     $margin = 5.2;
    # }
    # elsif ($age == "8y") {
    #     $margin = 5.3;
    # }
    # elsif ($age == "9y") {
    #     $margin = 5.3;
    # }
    # elsif ($age == "10y") {
    #     $margin = 5.4;
    # }
    # elsif ($age == "11y") {
    #     $margin = 5.5;
    # }
    # elsif ($age == "12y") {
    #     $margin = 5.5;
    # }
    # elsif ($age == "13y") {
    #     $margin = 5.6;
    # }
    # elsif ($age == "14y") {
    #     $margin = 5.6;
    # }
    # elsif ($age == "15y") {
    #     $margin = 5.7;
    # }
    # elsif ($age == "16y") {
    #     $margin = 5.7;
    # }
    # elsif ($age == "17y") {
    #     $margin = 5.7;
    # }
    # elsif ($age == "18y") {
    #     $margin = 5.8;
    # }
    # elsif ($age == "19y") {
    #     $margin = 5.8;
    # }
    # elsif ($age == "20y") {
    #     $margin = 5.9;
    # }



    # if ($age == "0m") {
    #     $margin = 3;
    # } 
    # elsif ($age == "1m") {
    #     $margin = 3;
    # }
    # elsif ($age == "2m") {
    #     $margin = 3;
    # }
    # elsif ($age == "3m") {
    #     $margin = 3;
    # }
    # elsif ($age == "4m") {
    #     $margin = 3;
    # }
    # elsif ($age == "5m") {
    #     $margin = 3;
    # }
    # elsif ($age == "6m") {
    #     $margin = 3;
    # }
    # elsif ($age == "7m") {
    #     $margin = 3;
    # }
    # elsif ($age == "8m") {
    #     $margin = 3;
    # }
    # elsif ($age == "9m") {
    #     $margin = 3;
    # }
    # elsif ($age == "10m") {
    #     $margin = 3;
    # }
    # elsif ($age == "11m") {
    #     $margin = 3;
    # }
    # elsif ($age == "1y") {
    #     $margin = 3;
    # }
    # elsif ($age == "2y") {
    #     $margin = 3;
    # }
    # elsif ($age == "3y") {
    #     $margin = 3;
    # }
    # elsif ($age == "4y") {
    #     $margin = 3;
    # }
    # elsif ($age == "5y") {
    #     $margin = 3;
    # }
    # elsif ($age == "6y") {
    #     $margin = 3;
    # }
    # elsif ($age == "7y") {
    #     $margin = 3;
    # }
    # elsif ($age == "8y") {
    #     $margin = 3;
    # }
    # elsif ($age == "9y") {
    #     $margin = 3;
    # }
    # elsif ($age == "10y") {
    #     $margin = 3;
    # }
    # elsif ($age == "11y") {
    #     $margin = 3;
    # }
    # elsif ($age == "12y") {
    #     $margin = 3;
    # }
    # elsif ($age == "13y") {
    #     $margin = 3;
    # }
    # elsif ($age == "14y") {
    #     $margin = 3;
    # }
    # elsif ($age == "15y") {
    #     $margin = 3;
    # }
    # elsif ($age == "16y") {
    #     $margin = 3;
    # }
    # elsif ($age == "17y") {
    #     $margin = 3;
    # }
    # elsif ($age == "18y") {
    #     $margin = 3;
    # }
    # elsif ($age == "19y") {
    #     $margin = 3;
    # }
    # elsif ($age == "20y") {
    #     $margin = 3;
    # }


    return $margin;

}
