`timescale 1ns/10ps

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c174_testfixture;

`define in_file "c174/rand_input_vector_c174_0.out"
`define out_file "c174/rand_output_vector_c174_0.out"

parameter vec_width = 20;
parameter vec_length = 4;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire p1_n22, p1_n23, p2_n22, p2_n23, p3_n22, p3_n23, p4_n22, p4_n23;
initial begin
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c174 cc (.P1_N1(vec[19]), .P1_N2(vec[18]), .P1_N3(vec[17]), .P1_N6(vec[16]), .P1_N7(vec[15]), .P2_N1(vec[14]), .P2_N2(vec[13]), .P2_N3(vec[12]), .P2_N6(vec[11]), .P2_N7(vec[10]), .P3_N1(vec[9]), .P3_N2(vec[8]), .P3_N3(vec[7]), .P3_N6(vec[6]), .P3_N7(vec[5]), .P4_N1(vec[4]), .P4_N2(vec[3]), .P4_N3(vec[2]), .P4_N6(vec[1]), .P4_N7(vec[0]), .P1_N22(p1_n22), .P1_N23(p1_n23), .P2_N22(p2_n22), .P2_N23(p2_n23), .P3_N22(p3_n22), .P3_N23(p3_n23), .P4_N22(p4_n22), .P4_N23(p4_n23));

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, p1_n22, p1_n23, p2_n22, p2_n23, p3_n22, p3_n23, p4_n22, p4_n23);
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
