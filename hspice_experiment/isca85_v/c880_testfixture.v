`timescale 1ns/10ps
//`include "c17.v"

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c880_testfixture;

`define in_file "c880/rand_input_vector_c880_0.out"
`define out_file "c880/rand_output_vector_c880_0.out"

parameter vec_width = 60;
parameter vec_length = 64;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire n388,n389,n390,n391,n418,n419,n420,n421,n422,n423,
     n446,n447,n448,n449,n450,n767,n768,n850,n863,n864,		 
     n865,n866,n874,n878,n879,n880;	
	 
		 

initial begin
	//$timeformat(-9, 1, " ns", 9); //Display time in nanoseconds
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c880 c880_1 (.N1(vec[59]),.N8(vec[58]),.N13(vec[57]),.N17(vec[56]),.N26(vec[55]),.N29(vec[54]),.N36(vec[53]),.N42(vec[52]),.N51(vec[51]),.N55(vec[50]),						 
             .N59(vec[49]),.N68(vec[48]),.N72(vec[47]),.N73(vec[46]),.N74(vec[45]),.N75(vec[44]),.N80(vec[43]),.N85(vec[42]),.N86(vec[41]),.N87(vec[40]),						 
             .N88(vec[39]),.N89(vec[38]),.N90(vec[37]),.N91(vec[36]),.N96(vec[35]),.N101(vec[34]),.N106(vec[33]),.N111(vec[32]),.N116(vec[31]),.N121(vec[30]),						 
             .N126(vec[29]),.N130(vec[28]),.N135(vec[27]),.N138(vec[26]),.N143(vec[25]),.N146(vec[24]),.N149(vec[23]),.N152(vec[22]),.N153(vec[21]),.N156(vec[20]),						 
             .N159(vec[19]),.N165(vec[18]),.N171(vec[17]),.N177(vec[16]),.N183(vec[15]),.N189(vec[14]),.N195(vec[13]),.N201(vec[12]),.N207(vec[11]),.N210(vec[10]),						 
             .N219(vec[9]),.N228(vec[8]),.N237(vec[7]),.N246(vec[6]),.N255(vec[5]),.N259(vec[4]),.N260(vec[3]),.N261(vec[2]),.N267(vec[1]),.N268(vec[0]),						 
             .N388(n388),.N389(n389),.N390(n390),.N391(n391),.N418(n418),.N419(n419),.N420(n420),.N421(n421),.N422(n422),.N423(n423),						 
             .N446(n446),.N447(n447),.N448(n448),.N449(n449),.N450(n450),.N767(n767),.N768(n768),.N850(n850),.N863(n863),.N864(n864),						 
             .N865(n865),.N866(n866),.N874(n874),.N878(n878),.N879(n879),.N880(n880) );			
			 
						 
						 
						 
						 
						 
integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, n388,n389,n390,n391,n418,n419,n420,n421,n422,n423,
	                  n446,n447,n448,n449,n450,n767,n768,n850,n863,n864,
	                  n865,n866,n874,n878,n879,n880);	
	                  
	
	if(i == vec_length)begin
		$finish;
	end
end

integer fh_w;
initial begin
	fh_w = $fopen(`out_file, "w");
end
 
initial begin
	//$fsdbDumpfile("SET.fsdb");
	//$fsdbDumpvars;
	//$fsdbDumpMDA;
	$dumpfile("test_result.vcd");
    $dumpvars;

end
endmodule
