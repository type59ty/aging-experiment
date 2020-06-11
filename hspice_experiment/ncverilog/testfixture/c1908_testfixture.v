`timescale 1ns/10ps

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c1908_testfixture;

`define in_file "c1908/rand_input_vector_c1908_0.out"
`define out_file "c1908/rand_output_vector_c1908_0.out"

parameter vec_width = 33;
parameter vec_length = 7;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire n2753, n2754, n2755, n2756, n2762, n2767, n2768, n2779, n2780, n2781, n2782, n2783, n2784, n2785, n2786, n2787, n2811, n2886, n2887, n2888, n2889, n2890, n2891, n2892, n2899;
initial begin
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c1908 cc (.N1(vec[32]), .N4(vec[31]), .N7(vec[30]), .N10(vec[29]), .N13(vec[28]), .N16(vec[27]), .N19(vec[26]), .N22(vec[25]), .N25(vec[24]), .N28(vec[23]), .N31(vec[22]), .N34(vec[21]), .N37(vec[20]), .N40(vec[19]), .N43(vec[18]), .N46(vec[17]), .N49(vec[16]), .N53(vec[15]), .N56(vec[14]), .N60(vec[13]), .N63(vec[12]), .N66(vec[11]), .N69(vec[10]), .N72(vec[9]), .N76(vec[8]), .N79(vec[7]), .N82(vec[6]), .N85(vec[5]), .N88(vec[4]), .N91(vec[3]), .N94(vec[2]), .N99(vec[1]), .N104(vec[0]), .N2753(n2753), .N2754(n2754), .N2755(n2755), .N2756(n2756), .N2762(n2762), .N2767(n2767), .N2768(n2768), .N2779(n2779), .N2780(n2780), .N2781(n2781), .N2782(n2782), .N2783(n2783), .N2784(n2784), .N2785(n2785), .N2786(n2786), .N2787(n2787), .N2811(n2811), .N2886(n2886), .N2887(n2887), .N2888(n2888), .N2889(n2889), .N2890(n2890), .N2891(n2891), .N2892(n2892), .N2899(n2899));

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, n2753, n2754, n2755, n2756, n2762, n2767, n2768, n2779, n2780, n2781, n2782, n2783, n2784, n2785, n2786, n2787, n2811, n2886, n2887, n2888, n2889, n2890, n2891, n2892, n2899);
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
