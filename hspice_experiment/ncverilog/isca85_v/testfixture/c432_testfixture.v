`timescale 1ns/10ps

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c432_testfixture;

`define in_file "c432/rand_input_vector_c432_0.out"
`define out_file "c432/rand_output_vector_c432_0.out"

parameter vec_width = 36;
parameter vec_length = 31;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire n223, n329, n370, n421, n430, n431, n432;
initial begin
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c432 cc (.N1(vec[35]), .N4(vec[34]), .N8(vec[33]), .N11(vec[32]), .N14(vec[31]), .N17(vec[30]), .N21(vec[29]), .N24(vec[28]), .N27(vec[27]), .N30(vec[26]), .N34(vec[25]), .N37(vec[24]), .N40(vec[23]), .N43(vec[22]), .N47(vec[21]), .N50(vec[20]), .N53(vec[19]), .N56(vec[18]), .N60(vec[17]), .N63(vec[16]), .N66(vec[15]), .N69(vec[14]), .N73(vec[13]), .N76(vec[12]), .N79(vec[11]), .N82(vec[10]), .N86(vec[9]), .N89(vec[8]), .N92(vec[7]), .N95(vec[6]), .N99(vec[5]), .N102(vec[4]), .N105(vec[3]), .N108(vec[2]), .N112(vec[1]), .N115(vec[0]), .N223(n223), .N329(n329), .N370(n370), .N421(n421), .N430(n430), .N431(n431), .N432(n432));

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, n223, n329, n370, n421, n430, n431, n432);
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
