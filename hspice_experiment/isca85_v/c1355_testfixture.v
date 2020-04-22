`timescale 1ns/10ps
//`include "c17.v"

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c1355_testfixture;

`define in_file "c1355/rand_input_vector_c1355_0.out"
`define out_file "c1355/rand_output_vector_c1355_0.out"

parameter vec_width = 41;
parameter vec_length = 64;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

	
wire g1324,g1325,g1326,g1327,g1328,g1329,g1330,g1331,g1332,g1333,g1334,g1335,
     g1336,g1337,g1338,g1339,g1340,g1341,g1342,g1343,g1344,g1345,g1346,g1347,
     g1348,g1349,g1350,g1351,g1352,g1353,g1354,g1355;	 
		 

initial begin
	//$timeformat(-9, 1, " ns", 9); //Display time in nanoseconds
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

			 
c1355 c1355_1 (.G1(vec[40]),.G2(vec[39]),.G3(vec[38]),.G4(vec[37]),.G5(vec[36]),.G6(vec[35]),.G7(vec[34]),.G8(vec[33]),.G9(vec[32]),.G10(vec[31]),
               .G11(vec[30]),.G12(vec[29]),.G13(vec[28]),.G14(vec[27]),.G15(vec[26]),.G16(vec[25]),.G17(vec[24]),.G18(vec[23]),.G19(vec[22]),.G20(vec[21]),
               .G21(vec[20]),.G22(vec[19]),.G23(vec[18]),.G24(vec[17]),.G25(vec[16]),.G26(vec[15]),.G27(vec[14]),.G28(vec[13]),.G29(vec[12]),.G30(vec[11]),
							 .G31(vec[10]),.G32(vec[9]),.G33(vec[8]),.G34(vec[7]),.G35(vec[6]),.G36(vec[5]),.G37(vec[4]),.G38(vec[3]),.G39(vec[2]),.G40(vec[1]),.G41(vec[0]),
	             .G1324(g1324),.G1325(g1325),.G1326(g1326),.G1327(g1327),.G1328(g1328),.G1329(g1329),.G1330(g1330),.G1331(g1331),.G1332(g1332),.G1333(g1333),.G1334(g1334),.G1335(g1335),.G1336(g1336),.G1337(g1337),.G1338(g1338),
							 .G1339(g1339),.G1340(g1340),.G1341(g1341),.G1342(g1342),.G1343(g1343),.G1344(g1344),.G1345(g1345),.G1346(g1346),.G1347(g1347),.G1348(g1348),.G1349(g1349),.G1350(g1350),.G1351(g1351),.G1352(g1352),.G1353(g1353),
							 .G1354(g1354),.G1355(g1355));						 
						 
						 
						 
						 
integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, g1324,g1325,g1326,g1327,g1328,g1329,g1330,g1331,g1332,g1333,g1334,g1335,
                    g1336,g1337,g1338,g1339,g1340,g1341,g1342,g1343,g1344,g1345,g1346,g1347,
                    g1348,g1349,g1350,g1351,g1352,g1353,g1354,g1355);	 
	                  
	
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
