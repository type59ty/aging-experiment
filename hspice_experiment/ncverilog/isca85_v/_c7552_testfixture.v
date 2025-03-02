`timescale 1ns/10ps

`define cycle 10.0
`define terminate_cycle 400000//200000 // Modify your terminate ycle here

module c7552_testfixture;

`define in_file "c7552/rand_input_vector_c7552_0.out"
`define out_file "c7552/rand_output_vector_c7552_0.out"

parameter vec_width = 207;
parameter vec_length = 7;

reg clk = 0;


reg [vec_width-1:0] input_vec_mem [0:vec_length-1];
reg [vec_width-1:0] vec;

wire n387, n388, n478, n482, n484, n486, n489, n492, n501, n505, n507, n509, n511, n513, n515, n517, n519, n535, n537, n539, n541, n543, n545, n547, n549, n551, n553, n556, n559, n561, n563, n565, n567, n569, n571, n573, n582, n643, n707, n813, n881, n882, n883, n884, n885, n889, n945, n1110, n1111, n1112, n1113, n1114, n1489, n1490, n1781, n10025, n10101, n10102, n10103, n10104, n10109, n10110, n10111, n10112, n10350, n10351, n10352, n10353, n10574, n10575, n10576, n10628, n10632, n10641, n10704, n10706, n10711, n10712, n10713, n10714, n10715, n10716, n10717, n10718, n10729, n10759, n10760, n10761, n10762, n10763, n10827, n10837, n10838, n10839, n10840, n10868, n10869, n10870, n10871, n10905, n10906, n10907, n10908, n11333, n11334, n11340, n11342, n241_o;
initial begin
	$readmemb(`in_file, input_vec_mem );
end

always #(`cycle/2) clk = ~clk;

c7552 cc (.N1(vec[206]), .N5(vec[205]), .N9(vec[204]), .N12(vec[203]), .N15(vec[202]), .N18(vec[201]), .N23(vec[200]), .N26(vec[199]), .N29(vec[198]), .N32(vec[197]), .N35(vec[196]), .N38(vec[195]), .N41(vec[194]), .N44(vec[193]), .N47(vec[192]), .N50(vec[191]), .N53(vec[190]), .N54(vec[189]), .N55(vec[188]), .N56(vec[187]), .N57(vec[186]), .N58(vec[185]), .N59(vec[184]), .N60(vec[183]), .N61(vec[182]), .N62(vec[181]), .N63(vec[180]), .N64(vec[179]), .N65(vec[178]), .N66(vec[177]), .N69(vec[176]), .N70(vec[175]), .N73(vec[174]), .N74(vec[173]), .N75(vec[172]), .N76(vec[171]), .N77(vec[170]), .N78(vec[169]), .N79(vec[168]), .N80(vec[167]), .N81(vec[166]), .N82(vec[165]), .N83(vec[164]), .N84(vec[163]), .N85(vec[162]), .N86(vec[161]), .N87(vec[160]), .N88(vec[159]), .N89(vec[158]), .N94(vec[157]), .N97(vec[156]), .N100(vec[155]), .N103(vec[154]), .N106(vec[153]), .N109(vec[152]), .N110(vec[151]), .N111(vec[150]), .N112(vec[149]), .N113(vec[148]), .N114(vec[147]), .N115(vec[146]), .N118(vec[145]), .N121(vec[144]), .N124(vec[143]), .N127(vec[142]), .N130(vec[141]), .N133(vec[140]), .N134(vec[139]), .N135(vec[138]), .N138(vec[137]), .N141(vec[136]), .N144(vec[135]), .N147(vec[134]), .N150(vec[133]), .N151(vec[132]), .N152(vec[131]), .N153(vec[130]), .N154(vec[129]), .N155(vec[128]), .N156(vec[127]), .N157(vec[126]), .N158(vec[125]), .N159(vec[124]), .N160(vec[123]), .N161(vec[122]), .N162(vec[121]), .N163(vec[120]), .N164(vec[119]), .N165(vec[118]), .N166(vec[117]), .N167(vec[116]), .N168(vec[115]), .N169(vec[114]), .N170(vec[113]), .N171(vec[112]), .N172(vec[111]), .N173(vec[110]), .N174(vec[109]), .N175(vec[108]), .N176(vec[107]), .N177(vec[106]), .N178(vec[105]), .N179(vec[104]), .N180(vec[103]), .N181(vec[102]), .N182(vec[101]), .N183(vec[100]), .N184(vec[99]), .N185(vec[98]), .N186(vec[97]), .N187(vec[96]), .N188(vec[95]), .N189(vec[94]), .N190(vec[93]), .N191(vec[92]), .N192(vec[91]), .N193(vec[90]), .N194(vec[89]), .N195(vec[88]), .N196(vec[87]), .N197(vec[86]), .N198(vec[85]), .N199(vec[84]), .N200(vec[83]), .N201(vec[82]), .N202(vec[81]), .N203(vec[80]), .N204(vec[79]), .N205(vec[78]), .N206(vec[77]), .N207(vec[76]), .N208(vec[75]), .N209(vec[74]), .N210(vec[73]), .N211(vec[72]), .N212(vec[71]), .N213(vec[70]), .N214(vec[69]), .N215(vec[68]), .N216(vec[67]), .N217(vec[66]), .N218(vec[65]), .N219(vec[64]), .N220(vec[63]), .N221(vec[62]), .N222(vec[61]), .N223(vec[60]), .N224(vec[59]), .N225(vec[58]), .N226(vec[57]), .N227(vec[56]), .N228(vec[55]), .N229(vec[54]), .N230(vec[53]), .N231(vec[52]), .N232(vec[51]), .N233(vec[50]), .N234(vec[49]), .N235(vec[48]), .N236(vec[47]), .N237(vec[46]), .N238(vec[45]), .N239(vec[44]), .N240(vec[43]), .N242(vec[42]), .N245(vec[41]), .N248(vec[40]), .N251(vec[39]), .N254(vec[38]), .N257(vec[37]), .N260(vec[36]), .N263(vec[35]), .N267(vec[34]), .N271(vec[33]), .N274(vec[32]), .N277(vec[31]), .N280(vec[30]), .N283(vec[29]), .N286(vec[28]), .N289(vec[27]), .N293(vec[26]), .N296(vec[25]), .N299(vec[24]), .N303(vec[23]), .N307(vec[22]), .N310(vec[21]), .N313(vec[20]), .N316(vec[19]), .N319(vec[18]), .N322(vec[17]), .N325(vec[16]), .N328(vec[15]), .N331(vec[14]), .N334(vec[13]), .N337(vec[12]), .N340(vec[11]), .N343(vec[10]), .N346(vec[9]), .N349(vec[8]), .N352(vec[7]), .N355(vec[6]), .N358(vec[5]), .N361(vec[4]), .N364(vec[3]), .N367(vec[2]), .N382(vec[1]), .N241_I(vec[0]), .N387(n387), .N388(n388), .N478(n478), .N482(n482), .N484(n484), .N486(n486), .N489(n489), .N492(n492), .N501(n501), .N505(n505), .N507(n507), .N509(n509), .N511(n511), .N513(n513), .N515(n515), .N517(n517), .N519(n519), .N535(n535), .N537(n537), .N539(n539), .N541(n541), .N543(n543), .N545(n545), .N547(n547), .N549(n549), .N551(n551), .N553(n553), .N556(n556), .N559(n559), .N561(n561), .N563(n563), .N565(n565), .N567(n567), .N569(n569), .N571(n571), .N573(n573), .N582(n582), .N643(n643), .N707(n707), .N813(n813), .N881(n881), .N882(n882), .N883(n883), .N884(n884), .N885(n885), .N889(n889), .N945(n945), .N1110(n1110), .N1111(n1111), .N1112(n1112), .N1113(n1113), .N1114(n1114), .N1489(n1489), .N1490(n1490), .N1781(n1781), .N10025(n10025), .N10101(n10101), .N10102(n10102), .N10103(n10103), .N10104(n10104), .N10109(n10109), .N10110(n10110), .N10111(n10111), .N10112(n10112), .N10350(n10350), .N10351(n10351), .N10352(n10352), .N10353(n10353), .N10574(n10574), .N10575(n10575), .N10576(n10576), .N10628(n10628), .N10632(n10632), .N10641(n10641), .N10704(n10704), .N10706(n10706), .N10711(n10711), .N10712(n10712), .N10713(n10713), .N10714(n10714), .N10715(n10715), .N10716(n10716), .N10717(n10717), .N10718(n10718), .N10729(n10729), .N10759(n10759), .N10760(n10760), .N10761(n10761), .N10762(n10762), .N10763(n10763), .N10827(n10827), .N10837(n10837), .N10838(n10838), .N10839(n10839), .N10840(n10840), .N10868(n10868), .N10869(n10869), .N10870(n10870), .N10871(n10871), .N10905(n10905), .N10906(n10906), .N10907(n10907), .N10908(n10908), .N11333(n11333), .N11334(n11334), .N11340(n11340), .N11342(n11342), .N241_O(n241_o));

integer i=0;
always @ (posedge clk) begin
	vec = input_vec_mem[i];
	$monitor(vec);
	i = i + 1;

end

always @ (negedge clk)begin
	$fdisplay ( fh_w, n387, n388, n478, n482, n484, n486, n489, n492, n501, n505, n507, n509, n511, n513, n515, n517, n519, n535, n537, n539, n541, n543, n545, n547, n549, n551, n553, n556, n559, n561, n563, n565, n567, n569, n571, n573, n582, n643, n707, n813, n881, n882, n883, n884, n885, n889, n945, n1110, n1111, n1112, n1113, n1114, n1489, n1490, n1781, n10025, n10101, n10102, n10103, n10104, n10109, n10110, n10111, n10112, n10350, n10351, n10352, n10353, n10574, n10575, n10576, n10628, n10632, n10641, n10704, n10706, n10711, n10712, n10713, n10714, n10715, n10716, n10717, n10718, n10729, n10759, n10760, n10761, n10762, n10763, n10827, n10837, n10838, n10839, n10840, n10868, n10869, n10870, n10871, n10905, n10906, n10907, n10908, n11333, n11334, n11340, n11342, n241_o);
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
