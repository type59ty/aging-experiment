`timescale 1ns/10ps

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c6288_testfixture;

`define in_file "c6288/rand_input_vector_c6288_0.out"
`define out_file "c6288/rand_output_vector_c6288_0.out"

parameter vec_width = 32;
parameter vec_length = 7;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire n545, n1581, n1901, n2223, n2548, n2877, n3211, n3552, n3895, n4241, n4591, n4946, n5308, n5672, n5971, n6123, n6150, n6160, n6170, n6180, n6190, n6200, n6210, n6220, n6230, n6240, n6250, n6260, n6270, n6280, n6287, n6288;
initial begin
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c6288 cc (.N1(vec[31]), .N18(vec[30]), .N35(vec[29]), .N52(vec[28]), .N69(vec[27]), .N86(vec[26]), .N103(vec[25]), .N120(vec[24]), .N137(vec[23]), .N154(vec[22]), .N171(vec[21]), .N188(vec[20]), .N205(vec[19]), .N222(vec[18]), .N239(vec[17]), .N256(vec[16]), .N273(vec[15]), .N290(vec[14]), .N307(vec[13]), .N324(vec[12]), .N341(vec[11]), .N358(vec[10]), .N375(vec[9]), .N392(vec[8]), .N409(vec[7]), .N426(vec[6]), .N443(vec[5]), .N460(vec[4]), .N477(vec[3]), .N494(vec[2]), .N511(vec[1]), .N528(vec[0]), .N545(n545), .N1581(n1581), .N1901(n1901), .N2223(n2223), .N2548(n2548), .N2877(n2877), .N3211(n3211), .N3552(n3552), .N3895(n3895), .N4241(n4241), .N4591(n4591), .N4946(n4946), .N5308(n5308), .N5672(n5672), .N5971(n5971), .N6123(n6123), .N6150(n6150), .N6160(n6160), .N6170(n6170), .N6180(n6180), .N6190(n6190), .N6200(n6200), .N6210(n6210), .N6220(n6220), .N6230(n6230), .N6240(n6240), .N6250(n6250), .N6260(n6260), .N6270(n6270), .N6280(n6280), .N6287(n6287), .N6288(n6288));

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, n545, n1581, n1901, n2223, n2548, n2877, n3211, n3552, n3895, n4241, n4591, n4946, n5308, n5672, n5971, n6123, n6150, n6160, n6170, n6180, n6190, n6200, n6210, n6220, n6230, n6240, n6250, n6260, n6270, n6280, n6287, n6288);
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
