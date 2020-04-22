`timescale 1ns/10ps

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c499_testfixture;

`define in_file "c499/rand_input_vector_c499_0.out"
`define out_file "c499/rand_output_vector_c499_0.out"

parameter vec_width = 41;
parameter vec_length = 8;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire n724, n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755;
initial begin
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c499 cc (.N1(vec[40]), .N5(vec[39]), .N9(vec[38]), .N13(vec[37]), .N17(vec[36]), .N21(vec[35]), .N25(vec[34]), .N29(vec[33]), .N33(vec[32]), .N37(vec[31]), .N41(vec[30]), .N45(vec[29]), .N49(vec[28]), .N53(vec[27]), .N57(vec[26]), .N61(vec[25]), .N65(vec[24]), .N69(vec[23]), .N73(vec[22]), .N77(vec[21]), .N81(vec[20]), .N85(vec[19]), .N89(vec[18]), .N93(vec[17]), .N97(vec[16]), .N101(vec[15]), .N105(vec[14]), .N109(vec[13]), .N113(vec[12]), .N117(vec[11]), .N121(vec[10]), .N125(vec[9]), .N129(vec[8]), .N130(vec[7]), .N131(vec[6]), .N132(vec[5]), .N133(vec[4]), .N134(vec[3]), .N135(vec[2]), .N136(vec[1]), .N137(vec[0]), .N724(n724), .N725(n725), .N726(n726), .N727(n727), .N728(n728), .N729(n729), .N730(n730), .N731(n731), .N732(n732), .N733(n733), .N734(n734), .N735(n735), .N736(n736), .N737(n737), .N738(n738), .N739(n739), .N740(n740), .N741(n741), .N742(n742), .N743(n743), .N744(n744), .N745(n745), .N746(n746), .N747(n747), .N748(n748), .N749(n749), .N750(n750), .N751(n751), .N752(n752), .N753(n753), .N754(n754), .N755(n755));

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, n724, n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737, n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748, n749, n750, n751, n752, n753, n754, n755);
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
