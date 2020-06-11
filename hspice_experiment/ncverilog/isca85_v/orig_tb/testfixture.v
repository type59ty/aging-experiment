`timescale 1ns/10ps
//`include "c17.v"

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module _0;

`define in_file "_1"
`define out_file "_2"

parameter vec_width = _3;
parameter vec_length = _4;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire _5;
initial begin
	//$timeformat(-9, 1, " ns", 9); //Display time in nanoseconds
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

// c17 cc ( .N1(vec[4]), .N2(vec[3]) , .N3(vec[2]), .N6(vec[1]), .N7(vec[0]), .N22(n22), .N23(n23) );
_6

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	//$fdisplay ( fh_w, n22, n23 );
	$fdisplay ( fh_w, _7);
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
