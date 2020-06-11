#! /usr/bin/perl
# Proram: run_genIsca85_header
# Author: Kun-Wei Chiu
# Last Update: 2017/04/18
# Objective: generate a SPICE netlist with pmos sleep transistors inserted
# example:
#(1) general sim.: 1) remove the # of line26  2)$./run_genIsca85_header
#(2) aging sim.: $./run_genIsca85_header 32nm_bulk_0m.pm
# output: test_header.sp

use strict;
use gen_hspice_header;

# setup hspice parameters;
my $benchmark_name = $ARGV[7];
my $task = $ARGV[6];
my $benchmark_sp_dir = "benchmark/isca85_sp";
my $benchmark_verilog_dir = "benchmark/isca85_v";

my $len = "32"; # (nm) minimum channel length of transistor (trs.)

my $size_scale = "4"; # the width scales relative to min. lengeh of sleep trs.

my $interval = "10"; # (time_unit), turn-on interval
my $time_unit = "ns";
my $ptm_model_card = "customized_32nm_model_card/32nm_bulk.pm"; # the model card for power gated block
#$ARGV[0] = "32nm_bulk_10y.pm"; # the customized model card for ST, if u want to run ./run_aging.pl , mark this line 
my $supply = $ARGV[1]; # (v), supply voltage of simulation netlist
my @split_supply = split '\.', $supply;
my $transistor_model_card = "model_card/$split_supply[0]$split_supply[1]/32nm_PMOS_$ARGV[0]\.pm";
my $iteration = $ARGV[2]; # (time_unit), a sim. phase time for a input vec.
my $input_vec_length = $ARGV[3]; # determine how many input vecotrs will be generated in the input vec. file
						  # or u can set it by test_coverage in 2)
my $cell_lib = "benchmark/isca85_lib_sp/isca85_lib.sp"; # the subcell library (.sp file) of bencmark case
my $st_num = 10; # the number of inserted sleep transistors

my $wakeup_schedule_file = "wakeup_schedule.out"; # turn-on sequence input file
### sub function parameters ###
my $filehandle;				  
my $module_name;
my @port_seq;
my @input_port;
my @output_port;

my $port_seq; # reference
my $output_port; # reference

my $input_vec_file_name;
my $trans_input_vec_file_name = $ARGV[4];
my $trans_output_vec_file_name = $ARGV[5];
if (-e "test_header/$benchmark_name"){
}
else {
	mkdir("test_header/$benchmark_name", 0755);
}
my $outputFile = "test_header/$benchmark_name/$task\_$split_supply[0]$split_supply[1]\_$iteration\_$ARGV[0].sp";
unless ( open OUT_FH,">$outputFile" ) {die "Error : Cannot open $outputFile\n";}
$filehandle = *OUT_FH;

# 1) parser
$module_name = parse_verilog_file($benchmark_verilog_dir, $benchmark_name,0); # 0:return module name,
@port_seq = parse_verilog_file($benchmark_verilog_dir, $benchmark_name,1); # 1:return port_seq.
@output_port = parse_verilog_file($benchmark_verilog_dir, $benchmark_name,2); # 2:return output_port
@input_port = parse_verilog_file($benchmark_verilog_dir, $benchmark_name,3); # 3:return input_port 

# deference
$port_seq = \@port_seq;
$output_port = \@output_port;
 
#print "port_seq: @port_seq\n";
#print "input_port: @input_port\n";
#print "output_port: @output_port\n";

# 2) generate input vector file
#( method 1 ) directly assign by a pre-generated input vec. file of yourself. e.g."rand_input_vector_cxxx_veclenth.out"  
    #$input_vec_file_name = "rand_input_vector_$benchmark_name\_$input_vec_length.out";
#( method 2 ) gen. by function gen_input_vec_file(), don't forget to remote the mark of the code in 2-2)
#	2-1) set the $inpput_vector_length. i.e., determine how many input vecotrs will be generated in the input vec. file
#	( method 1 ) assign directly at declaration (at line:25)
#	( method 2 ) assgin by test coverage ( if u want to use method 2, remove the mark of below three rows )
#	 	my $test_coverage = 0.5; # e.g. $test_coverage = 0.5, i.e. half sets of total input vectors will be generated in the input vector file
#	 	my $input_vec_width = @input_port;
#	 	$input_vec_length = int($test_coverage*(2**$input_vec_width)) ;  # how many sets does random vectors generate in the input vector file
#	2-2) call the submodule gen_input_vec_file() to generate input vec. file ( if u want generate new input vec. file remove the mark of below row )
#		 gen_input_vec_file($input_vec_file_name, $input_vec_length, @input_port);

# 3) transpose the context of the input vector file, and generate a new transpose input vec. file for attach_input_vec()
#$trans_input_vec_file_name = transpose_input_vec_file($input_vec_file_name);

# 4) attach below statements
attach_generation_time($filehandle);
attach_parameters($filehandle, $len, $supply, $size_scale, $iteration, $interval, $time_unit);
attach_model_card($filehandle, $ptm_model_card, $transistor_model_card);
attach_include_model($filehandle, $cell_lib);
attach_benchmark($filehandle, $benchmark_sp_dir, $benchmark_name);

my $margin = $ARGV[8];

# 5) attach simulation netlist
attach_simulation_netlist( 
						$filehandle, 
						$benchmark_verilog_dir, 
						$benchmark_name, 
						$module_name,
						$port_seq,
						$output_port,
						$st_num, 
						$size_scale,
						$len,
						$input_vec_length, 
						$trans_input_vec_file_name,
						$iteration,
						$time_unit,
						$supply,
                        $margin
);


# 7) attach analysis
attach_analysis($filehandle, $st_num, $iteration, $interval, $time_unit, $input_vec_length, $supply, $trans_input_vec_file_name, $trans_output_vec_file_name, $margin, $benchmark_name);
print OUT_FH ".end\n";
close OUT_FH;

# 8) 
#printf "ST model card: %s\n", $transistor_model_card; 







