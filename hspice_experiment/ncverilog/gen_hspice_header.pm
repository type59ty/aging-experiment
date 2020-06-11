#! /usr/bin/perl
# Package: gen_hspice_header
# Author: Kun-Wei Chiu
# Last Update: 2017/08/15
# Objective: generate completed hspice netlist from original benchmark .sp file

package gen_hspice_header;
use Exporter;
our @ISA = qw( Exporter );
@EXPORT = qw( parse_verilog_file
			  gen_input_vec_file
			  transpose_input_vec_file
			  attach_generation_time
			  attach_parameters 
			  attach_model_card 
			  attach_include_model
              attach_benchmark
			  attach_simulation_netlist
			  attach_analysis
);
		
use strict;
sub parse_verilog_file{
	my $benchmark_verilog_dir = shift;
	my $benchmark_name = shift;
	my $parse_what = shift; # 0: module name, 1: port_seq., 2:output_port, 3:input_port,; 

	my $module_name;
	my @port_seq;
	my @input_port;
	my @output_port;
	
	my @line;
	my @words;
	my $port_reading;
	my $row;
	my $first_word;
	
	unless ( open IN_FH,"<$benchmark_verilog_dir/$benchmark_name.v" ) {die "Error : Cannot open the $benchmark_name.v\n";}
	
	# PARSER
	# $port_reading = 0 : reading other lines which is not (1) module port header, (2) input port, (3) output port
	# $port_reading = 1 : reding (1)
	# $port_reading = 2 : reading (2)
	# $port_reading = 3 : reading (3)
	$port_reading  = 0; # default: 0
	while ($row = <IN_FH>){
		chomp $row;
		
		# take out space 
		@line = split /\s+/,$row;

	    $first_word = @line[0];
		if( $first_word eq "module" ){
			$port_reading = 1; # reading port header
			$module_name = @line[1];
			shift @line;
			shift @line;
		}
		elsif( $first_word eq "input" ){
			$port_reading = 2; # reading input port
			shift @line;
		}
		elsif( $first_word eq "output" ){
			$port_reading = 3; # reading output port
			shift @line;
		}
		else {
			#$port_reading = 0; # reading other line not port header
		}
		
		# (1) read module port header
		if ( $port_reading  == 1 ){
			foreach my $line_slice(@line){
				# take out ","
				@words = split /,/,$line_slice;
				foreach(@words){
					if(m/\(/){ 
						s/\(//; # take out"(" 
						
						if( $_ eq ""  ){
							next;
						}
						else {
							#print "$_ take out \(\n";
							push (@port_seq, $_);
						}
					}
					elsif(m/\)/){
						s/\)//; 
						s/\;//;	
						
						if( $_ eq ""  ){
							next;
						}
						else {
							#print "$_ take out \);\n";
							push (@port_seq, $_);
						}
						$port_reading = 0; # module port reading over
					}
					elsif(m/\;/){
						next;
					}
					else{
						#print "$_\n";
						push(@port_seq,$_);
					}
					
				} # end of foreach
			} # end of foreach
		} # end of if
		
		# (2) read module input port 
		if ( $port_reading  == 2 ){
			foreach my $line_slice(@line){
				# take out ","
				@words = split /,/,$line_slice;
				foreach(@words){
					if(m/\;/){
						s/\;//;	
						if( $_ eq ""  ){
							next;
						}
						else {
							#print "$_ \n";
							push (@input_port, $_);
						}
						$port_reading = 0; # input port reading over
					}
					else{
						#print "$_\n";
						push(@input_port,$_);
					}
				} # end of foreach
			} # end of foreach
		} # end of if
		
		# (3) read module input port 
		if ( $port_reading  == 3 ){
			foreach my $line_slice(@line){
				# take out ","
				@words = split /,/,$line_slice;
				foreach(@words){
					if(m/\;/){
						s/\;//;	
						if( $_ eq ""  ){
							next;
						}
						else {
							#print "$_ \n";
							push (@output_port, $_);
						}
						$port_reading = 0; # output port reading over
					}
					else{
						#print "$_\n";
						push(@output_port,$_);
					}
				} # end of foreach
			} # end of foreach
		} # end of if
		
	} # end of while (PARSER)
	
	#print "port_seq: @port_seq\n";
	#print "input_port: @input_port\n";
	#print "output_port: @output_port\n";
	
	if ( $parse_what == 0 ) { return $module_name; }
	elsif ( $parse_what == 1 ) { return @port_seq; }
	elsif ( $parse_what == 2 ) { return @output_port; }
	elsif ( $parse_what == 3 ) { return @input_port; }
	else {return -1;};

} # end of parse_verilog_file

sub gen_input_vec_file{
	my $input_vec_file_name = shift; #"rand_input_vector.out"
	my $input_vec_length = shift;
	my @input_port = @_;
	

	my @rand_vec;
	my $rand_vec;
	my $input_vec_width = @input_port;
    my $vec_count; 
	my $input_vec_repeated;
	my $scale_factor = 2**$input_vec_width;
	
	if( $input_vec_length >= $scale_factor ){
		print "Warning: input_vec_length is too long ! it must be less than $scale_factor\n";
	}
	print "new input_vec_file genenrated !!\n";
	print "input_vec_width: $input_vec_width\n";
	print "input_vec_length: $input_vec_length\n";	
	
	unless ( open IN_VEC_FH,">$input_vec_file_name" ) {die "Error : Cannot open the $input_vec_file_name\n";}
	print IN_VEC_FH "@input_port";
	close (IN_VEC_FH);
	
	$vec_count = 0;
	while( $vec_count < $input_vec_length && $vec_count < (2**$input_vec_width ) ){
		
		# generate a new input vec.
		for (my $j = 0; $j < $input_vec_width; $j++ ){
			push @rand_vec, gen_rand_value();
		}
		$rand_vec = join "",@rand_vec; 
		@rand_vec = ();
		
		# check the new input vec. whether exist in input vec. file
		$input_vec_repeated = 0;
		unless ( open IN_VEC_FH,"<$input_vec_file_name" ) {die "Error : Cannot open the $input_vec_file_name at gen. input vec.\n";}
		while ( <IN_VEC_FH> ){
			chomp $_;
			if( $rand_vec eq $_){
				#print "found $rand_vec in $input_vec_file_name\n";
				$input_vec_repeated = 1;
				last;
			}	
		} # end of while
		close(IN_VEC_FH);
		
		# if the new input vec. is not repeated, write it in input vec. file
		if( $input_vec_repeated == 0 ){
			unless ( open IN_VEC_FH,">>$input_vec_file_name" ) {die "Error : Cannot open the $input_vec_file_name\n";}
			print IN_VEC_FH "\n$rand_vec";
			close (IN_VEC_FH); 
			$vec_count++;
		}
	} # end of for
	
    return $input_vec_file_name;
} # end of gen_rand_input_vector

sub gen_rand_value{
	my $tmp;
	
	$tmp = rand();
	if( $tmp < 0.5 ){
		return 0; 
	}
	else {
		return 1;
	}
}

sub transpose_input_vec_file{
  my $benchmark_name = shift;
  my $ori_input_vec_file_name = shift;
	my $input_dir = "../input_pattern";
	my $input_vec_file_name = "$input_dir\/$benchmark_name/$ori_input_vec_file_name";
	my $row;
	my $skip_port_line;
	my $vec_line;
	my @port_line;
	my $trans_input_vec_file_name = "$input_dir\/$benchmark_name/trans_$ori_input_vec_file_name";

	my $vec_element;
	
	# 1) read the port line from input vec. file
	unless ( open IN_VEC_FH,"<$input_vec_file_name" ) {die "Error : Cannot open the $input_vec_file_name\n";}
	$row = <IN_VEC_FH>;
	chomp $row;
	@port_line = split /\s+/,$row;
	#print "@port_line\n";
	close (IN_VEC_FH);

	# 2) transpose the context of input vec. file, then wrte it into a new transpose input vec. file
	unless ( open TRANS_IN_VEC_FH,">$trans_input_vec_file_name" ) {die "Error1 : Cannot open the $trans_input_vec_file_name\n";}
	for ( my $i=0; $i < @port_line; $i++ ){
		print TRANS_IN_VEC_FH "$port_line[$i] ";
		unless ( open IN_VEC_FH,"<$input_vec_file_name" ) {die "Error : Cannot open the $input_vec_file_name\n";}
		$skip_port_line = 0;
		while ( $row = <IN_VEC_FH> ){
			if ( $skip_port_line == 0 ){ 
				$skip_port_line = 1;
				next; 
			} # end of if
			else { 
				chomp $row;
				$vec_line = $row;
				$vec_line =~ s/\_//; # take out _
				#print "$vec_line\n";
				$vec_element = substr $vec_line,$i,1;
				print TRANS_IN_VEC_FH "$vec_element ";
			} # end of else
		} # end of while
		close (IN_VEC_FH);
		print TRANS_IN_VEC_FH "\n";
	} # end of for
	close (TRANS_IN_VEC_FH);

	return $trans_input_vec_file_name;
} # end of attach_input_vector

sub attach_generation_time{
	my $file = shift;
	my $date_string;
	
    $date_string = localtime();
	print $file "*Spice netlist generated at $date_string\n";
}

sub attach_parameters{	 
    my $file = shift;
	my $len = shift;
	my $supply = shift;
	my $size_scale = shift;
	my $iteration = shift;
	my $interval = shift;
	my $time_unit = shift;
		
	print $file "\n";
    print $file "*************\n";
	print $file "* Parameters \n";
	print $file "*************\n";
	printf $file "* len \= %snm\n",$len;
	print $file "* size_scale \= $size_scale\n";
	printf $file "* supply \= %sv\n",$supply;
	printf $file "* iteration \= %s%s\n",$iteration,$time_unit;
	printf $file "* interval \= %s%s\n\n",$interval,$time_unit;
}

sub attach_model_card{
	my $file = shift;
	my $ptm_model_card = shift;
	my $sleep_transistor_model_card = shift;
	
	print $file "*************\n";
	print $file "* Model Card\n";
	print $file "*************\n";
	print $file ".include '$ptm_model_card'\n";
	print $file ".include '$sleep_transistor_model_card'\n\n";
} 

sub attach_include_model{
    my $file = shift;
	my $cell_lib = shift; 
	print $file "********\n";
	print $file "* Model\n";
	print $file "********\n";
	print $file ".include '$cell_lib'\n\n";	
}

sub attach_benchmark{
	my $file = shift;
	my $benchmark_sp_dir = shift;
	my $benchmark_name = shift;
	my $row;
	my $port_reading;
	
	$benchmark_name =~ s/(\.sp || \.v)//;
	print $file "***********************\n";
	print $file "* Cell Name: $benchmark_name\n";
	print $file "***********************\n";
	
	# read benchmark .sp file 
	unless ( open IN_FH,"<$benchmark_sp_dir/$benchmark_name.sp" ) {die "Error : Cannot open the $benchmark_name.sp\n";}
	while ($row = <IN_FH>){
		if ( $row =~ /.SUBCKT/s ){ # /s: match the string that include "\n"
			chomp $row;
			print $file "$row";
			$port_reading = 1; # module port reading start
			next;
		}
		elsif( $row =~ /\+/s ){
			chomp $row;
			$row =~ s/\+//;
			print $file "$row";
		}
		elsif ( $row =~ /XAND2/s){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/and/vdd gnd AND2/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XAND3/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/and/vdd gnd AND3/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XAND4/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/and/vdd gnd AND4/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XAND5/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/and/vdd gnd AND5/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XAND8/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/and/vdd gnd AND8/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XAND9/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/and/vdd gnd AND9/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XOR2/s && $row !~ /XXOR2/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/or/vdd gnd OR2/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XOR3/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/or/vdd gnd OR3/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XOR4/s ){
			if( $port_reading == 1){
				print $file  "VVDD VGND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/or/vdd gnd OR4/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XOR5/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/or/vdd gnd OR5/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNAND2/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nand/vdd gnd NAND2/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNAND3/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nand/vdd gnd NAND3/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNAND4/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nand/vdd gnd NAND4/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNAND5/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nand/vdd gnd NAND5/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNAND8/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nand/vdd gnd NAND8/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNOR2/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nor/vdd gnd NOR2/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNOR3/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nor/vdd gnd NOR3/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNOR4/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nor/vdd gnd NOR4/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNOR8/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/nor/vdd gnd NOR8/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XNOT1/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/not/vdd gnd NOT1/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XBUFF1/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/buf/vdd gnd BUFF1/;
			print $file "$row\n";
		}
		elsif ( $row =~ /XXOR2/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			$row =~ s/xor/vdd gnd XOR2/;
			print $file "$row\n";
		}
		elsif ($row =~ /ENDS/s ){
			if( $port_reading == 1){
				print $file  "VDD GND\n";
				$port_reading = 0; # module port reading over
			}
			chomp $row;
			print $file "$row $benchmark_name\n\n";
		}
		else {next;}
	} # end of while
	close IN_FH;
}

sub attach_simulation_netlist{
	my $file = shift;
	my $benchmark_verilog_dir = shift;	
	my $benchmark_name = shift;
	my $module_name = shift;
	my $port_seq = shift;
	my $output_port = shift;
	my $st_num = shift;
	my $size_scale = shift;
	my $len = shift;
	my $input_vec_length = shift;
	my $trans_input_vec_file_name = shift;
	my $iteration = shift;
	my $time_unit = shift;
	my $supply = shift;
	print $file "*********************\n";
	print $file "* Simulation netlist\n";
	print $file "*********************\n";
	print $file ".global vdd gnd\n";
	print $file "V1 vdd 0 $supply";
	print $file "v\n\n";
		
	# 1) attach DSTN
    #attach_dstn($file, $st_num, $size_scale, $len);
		
	# 2) attach instance and output loading
	attach_benchmark_subckt_instance($file, $module_name, @$port_seq);
	attach_output_loading($file, @$output_port);
	
	# 3) attach input vector  
	### berfore this step, u must do (1)generate a input vector file , then do (2)transpose the input vector file as a new trans. input vector file" ###
	attach_input_vector($file, $trans_input_vec_file_name, $iteration, $time_unit, $supply);
		
} # end of attach_simulation_netlist

sub attach_dstn{
	my $file = shift;
	my $st_num = shift;
	my $size_scale = shift;
	my $len = shift;
	my $w = $size_scale*$len;
	
	my $basic_res = 0.02; # (ohm) 90nm:0.2
	my $basic_cap = 0.005; # (pf) 90nm:0.05pf
	
	my $eq_res;
	my $eq_cap;
	
	print $file "*******\n";
	print $file "* DSTN\n";
	print $file "*******\n";
	
	# ST 	
	for( my $i = 1; $i <= $st_num; $i++ ){
		printf $file "Mst$i vvdd_in sleep$i vdd vdd pmos_st l=%snm  w=%snm\n",$len,$w;
	}
	print $file "\n";
	
	# RC
	$eq_res = $basic_res * $st_num;
	$eq_cap = $basic_cap * $st_num;
	
	print $file "Rvvdd vvdd_in vvdd $eq_res\n";
	printf $file "Cvvdd vvdd_in 0 %spf\n\n",$eq_cap;
}

sub attach_benchmark_subckt_instance{
	my $file = shift;
	my $module_name = shift;
	my @port_seq = @_; 
	print $file "******************\n";
	print $file "* bench. instance\n";
	print $file "******************\n";
	print $file "xx1 ";
	foreach ( @port_seq ){
		print $file "$_ ";
	}
	print $file "vdd gnd $module_name\n\n";
	
} # end of attach_benchmark_subckt_instance

sub attach_output_loading{
	my $file = shift;
	my @output_port = @_;
	
	print $file "*****************\n";
	print $file "* Output loading\n";
	print $file "*****************\n";

	foreach ( @output_port ){
		print $file "c$_ $_ 0 0.001pf\n";
	}
	print $file "\n";
}

sub attach_input_vector{
	my $file = shift;
	my $trans_input_vec_file_name = shift;
	my $iteration = shift;
	my $time_unit = shift;
	my $supply = shift;
	my $input_ready_time;
	my $input_change_time;
	
	my $row;
	my @vec_line;
	my $port_name;
	my $i;
	my $previous_value;
	my $current_value;
	
	print $file "*****************************************\n";
	print $file "* Input vector: $trans_input_vec_file_name\n";
	print $file "*****************************************\n";
	
	# open the transpose input vec. file
	unless ( open TRANS_IN_VEC_FH,"<$trans_input_vec_file_name" ) {die "Error : Cannot open the $trans_input_vec_file_name\n";}
	while( $row = <TRANS_IN_VEC_FH> ){
		chomp $row;
		# take out space 
		@vec_line = split /\s+/,$row;
		$port_name = shift @vec_line;
		
		print $file "V$port_name $port_name gnd pwl 1$time_unit 0v";
		
		$previous_value = 0;
		$i = 1;
		foreach $current_value (@vec_line){
			
			$input_ready_time = $i*$iteration;
			$input_change_time = $i*$iteration+1;
			
			print $file ", $input_ready_time";
			print $file "$time_unit ";
			if ( $previous_value == 0 ){
				print $file "  0";
				print $file "v";
			}
			else {
				print $file "$supply";
				print $file "v";
			}
			
			print $file ", $input_change_time";
			print $file "$time_unit ";
			
			if ( $current_value == 0 ){
				print $file "  0";
				print $file "v";
			}
			else {
				print $file "$supply";
				print $file "v";
			}
			$previous_value = $current_value;
			$i++;
		} # end of foreach
	  $input_ready_time = $i*$iteration;	
	  print $file ", $input_ready_time";
	  print $file "$time_unit ";
	  if ( $previous_value == 0 ){
	  	print $file "  0";
	  	print $file "v";
	  }
	  else {
	  	print $file "$supply";
	  	print $file "v";
	  }	
		print $file "\n";
	} # end of while
	print $file "\n";
	close(TRANS_IN_VEC_FH);
	
} # end of attach_input_vector

sub attach_analysis{
	my $file = shift;
	my $st_num = shift;
	my $iteration = shift;
	my $interval = shift;
	my $time_unit = shift;
	my $input_vec_length = shift;
	my $supply = shift;
	my $trans_input_vec_file_name = shift;
	my $trans_output_vec_file_name = shift;
	my $total_sim_time;
	my $stable_vvdd = 0.9*$supply;
	my $stable_surge = 0.1*194.2; # (uA)
	my $turn_on_time;
	my $termination_time;
	my $turn_on_offset = 0.5*$iteration;
	$total_sim_time = ($input_vec_length+2)*$iteration;
	my $group_num = 0;
	
	print $file "***********\n";
	print $file "* Analysis\n";
	print $file "***********\n";
	print $file ".OP\n";
	print $file ".TEMP 100\n";
	print $file ".OPTION POST=2\n";
	print $file ".OPTION MEASDGT=10\n";
	print $file ".TRAN 1$time_unit $total_sim_time";
	print $file "$time_unit\n\n";
	
	
	#print $file ".print v(xx1.n10) v(N1) v(N3) \n";
	#print $file ".print v(xx1.n11) v(N3) v(N6) \n";
	#print $file ".print v(xx1.n16) v(N2) v(xx1.n11)\n";
	#print $file ".print v(xx1.n19) v(xx1.n11) v(N7)\n";
	#print $file ".print v(xx1.n22) v(xx1.n10) v(xx1.n16)\n";
	#print $file ".print v(xx1.n23) v(xx1.n16) v(xx1.n19)\n";
	#print $file ".print v(xx1.n22) v(xx1.n23)\n";

	
	my $input_ready_time;
	
	my $row;
	my @vec_line;
	my $port_name;
	my $i;
	my $current_value;
	
	# open the transpose input vec. file
	unless ( open TRANS_IN_VEC_FH,"<$trans_input_vec_file_name" ) {die "Error : Cannot open the $trans_input_vec_file_name\n";}
	while( $row = <TRANS_IN_VEC_FH> ){
		chomp $row;
		# take out space 
		@vec_line = split /\s+/,$row;
		$port_name = shift @vec_line;
		
		#print $file "V$port_name $port_name gnd pwl 1$time_unit 0v";

		$i = 1;
		foreach $current_value (@vec_line){
			$input_ready_time = $i*$iteration;		
      $termination_time = ($i+1)*$iteration;			
			if ( $current_value == 0 ){#fall
			  printf $file ".meas tran %s_stable_%s when v(%s)=\'%sv\' from = %s%s to = %s%s\n", $port_name, $i, $port_name, 0.1*$supply, $input_ready_time, $time_unit, $termination_time, $time_unit;
				#printf $file ".meas tran %s_time_%s param = '(%s_stable_%s-%s%s)'\n", $port_name, $i, $port_name, $i, $input_ready_time, $time_unit;
			}
			else {#rise
				printf $file ".meas tran %s_stable_%s when v(%s)=\'%sv\' from = %s%s to = %s%s\n", $port_name, $i, $port_name, 0.9*$supply, $input_ready_time, $time_unit, $termination_time, $time_unit;
				#printf $file ".meas tran %s_time_%s param = '(%s_stable_%s-%s%s)'\n", $port_name, $i, $port_name, $i, $input_ready_time, $time_unit;
			}
			$i++;
		} # end of foreach
		print $file "\n";
	} # end of while
	print $file "\n";
	close(TRANS_IN_VEC_FH);

	# open the transpose input vec. file
	unless ( open TRANS_OUT_VEC_FH,"<$trans_output_vec_file_name" ) {die "Error : Cannot open the $trans_output_vec_file_name\n";}
	while( $row = <TRANS_OUT_VEC_FH> ){
		chomp $row;
		# take out space 
		@vec_line = split /\s+/,$row;
		$port_name = shift @vec_line;
		
		$i = 1;
		foreach $current_value (@vec_line){
			$input_ready_time = $i*$iteration;		
      $termination_time = ($i+1)*$iteration;			
			if ( $current_value == 0 ){#fall
			  printf $file ".meas tran %s_stable_%s when v(%s)=\'%sv\' from = %s%s to = %s%s\n", $port_name, $i, $port_name, 0.1*$supply, $input_ready_time, $time_unit, $termination_time, $time_unit;
				#printf $file ".meas tran %s_time_%s param = '(%s_stable_%s-%s%s)'\n", $port_name, $i, $port_name, $i, $input_ready_time, $time_unit;
			}
			else {#rise
				printf $file ".meas tran %s_stable_%s when v(%s)=\'%sv\' from = %s%s to = %s%s\n", $port_name, $i, $port_name, 0.9*$supply, $input_ready_time, $time_unit, $termination_time, $time_unit;
				#printf $file ".meas tran %s_time_%s param = '(%s_stable_%s-%s%s)'\n", $port_name, $i, $port_name, $i, $input_ready_time, $time_unit;
			}
			$i++;
		} # end of foreach
		print $file "\n";
	} # end of while
	
	printf $file ".meas tran idle_power avg power from = %s%s to = %s%s\n", $iteration*2, $time_unit, $iteration*3, $time_unit;
	print $file "\n";
	close(TRANS_OUT_VEC_FH);
	
	# measure wakeup time
	#for( my $i=1; $i <= $input_vec_length; $i++ ){
	#	$input_ready_time = $i*$iteration;
	#	$termination_time = ($i+1)*$iteration;
	#	foreach my $el (@output_port){
	#	  printf $file ".meas tran %s_vdd_stable_t%s when v(%s)=\'%sv\' from = %s%s to = %s%s\n", $el, $i, $el, 0.9*$supply, $input_ready_time, $time_unit, $termination_time, $time_unit;			
	#	}
	#}
	
	#if ( ($st_num%200) == 0 ){
	#	$group_num = (int($st_num/200));
	#}
	#else {
	#	$group_num = (int($st_num/200))+1;	
	#}
	#
	## measure maximum surge current of total ST 
	#print $file ".meas tran total_st_i_max max \'";
	#for( my $i=1; $i <= $group_num; $i++ ){
	##	print $file "-I(Mst$i)";
	#	if ( $i > 1){
	#		print $file "\+";
	#	}
	#	printf $file "group%d_i",$i;
	#	
	#}
	#print $file "\'\n";
	#
	## measure maximum surge current of every ST 
	##for( my $i=1; $i <= $st_num; $i++ ){
	#	#printf $file ".meas tran st%s_i_max max \'-I(Mst$i)\'\n", $i;
	##}
	#
	## measure current of every ST
	##for( my $i=1; $i <= $st_num; $i++ ){
	##	printf $file ".probe st%d_i = par (\'",$i;
	##	print $file "-I(Mst$i)\')\n";
	##}
	#
	#
	print $file ".meas tran avg_power avg power\n";
  #
	#
	## measure current of ST group by group
	#my $st_count = 1;
	#for( my $i=1; $i <= $group_num; $i++ ){
	#	printf $file ".probe group%d_i = par (\'",$i;
	#	
	#	while( ($st_count <= $i*200)&&($st_count <= $st_num) ){
	#		print $file "-I(Mst$st_count)";
	#		$st_count++;
	#	}
	#	
	#	print $file "\')\n";
	#} 
	
} # end of attach_analysis
































