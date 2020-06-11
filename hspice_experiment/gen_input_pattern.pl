#!/usr/bin/perl
# Proram: gen_input_pattern
# Author: Jian-Ting
# Last Update: 2019/09/3
# Objective: generate input pattern 
# $ARGV[0];  # benchmark_name 
# $ARGV[1];  # number_of_task
# $ARGV[2];  # input_vec_length
# output: rand_input_vector_$benchmark_name\_$input_vec_length.out


use strict;
use gen_hspice_header;


my $benchmark_name = $ARGV[0];
my $benchmark_verilog_dir = "./benchmark/isca85_v";
#my $benchmark_verilog_dir = "./benchmark/itc99_v";
my @input_port;

my $number_of_task = $ARGV[1];
my $input_vec_length = $ARGV[2]; # determine how many input vectors will be generated in the input vec. file

my $input_vec_file_name;
my $trans_input_vec_file_name;
my $input_dir = "input_pattern";

# if dir. hspice_result doesn't exist, make the dir.
if (-e "$input_dir/$benchmark_name"){
}
else {
	mkdir("$input_dir/$benchmark_name", 0755);
}

# 1) parser
@input_port = parse_verilog_file($benchmark_verilog_dir, $benchmark_name,3); # 3:return input_port

for (my $i = 0; $i < $number_of_task; $i++ ){
  #generate input vector for you
	gen_input_vec_file("$input_dir\/$benchmark_name/rand_input_vector_$benchmark_name\_$i.out", $input_vec_length, @input_port);
  #translate input vector for program 
	$trans_input_vec_file_name = transpose_input_vec_file($benchmark_name, "rand_input_vector_$benchmark_name\_$i.out");
}
#generate the idle input vectors for idle power
my $index = $number_of_task-1;
open my $file, '<', "$input_dir\/$benchmark_name/rand_input_vector_$benchmark_name\_$index.out";
open my $wfile, '>', "$input_dir\/$benchmark_name/rand_input_vector_$benchmark_name\_$number_of_task.out";
my $Line = <$file>;
#print $Line;
print $wfile $Line;
$Line = <$file>;
for (my $i = 0; $i < $input_vec_length; $i++ ){
  print $wfile $Line;
	#print $Line;
}
close $wfile;
close $file;
#translate the idle input vector for program
$trans_input_vec_file_name = transpose_input_vec_file($benchmark_name, "rand_input_vector_$benchmark_name\_$number_of_task.out");
