#!/usr/bin/perl
# Proram: gen_input_pattern
# Author: Jain-Ting
# Last Update: 2018/06/11
# Objective: generate input pattern 
# $ARGV[0];  # benchmark_name 
# $ARGV[1];  # number_of_task
# $ARGV[2];  # input_vec_length
# output: rand_input_vector_$benchmark_name\_$input_vec_length.out


use strict;
use gen_hspice_header;


my $benchmark_name = $ARGV[0];

my $number_of_task = $ARGV[1];


my $trans_input_vec_file_name;
my $input_dir = "../input_pattern";

# if dir. hspice_result doesn't exist, make the dir.
if (-e "$input_dir/$benchmark_name"){
}
else {
	mkdir("$input_dir/$benchmark_name", 0755);
}

# 1) parser
for (my $i = 0; $i < $number_of_task; $i++ ){
	$trans_input_vec_file_name = transpose_input_vec_file($benchmark_name, "rand_output_vector_$benchmark_name\_$i.out");
}