#!/usr/bin/perl
use strict;

my $benchmark_name = $ARGV[0];
my $policy = $ARGV[1]; #symmetric = 0, Variation_Aware = 1, spare_core = 2, asymmetric = 3, reschduling_symmetric = 4
my $env = "env";
my $task_graph = "task_graph";
my $NUM_CORE = "4";
my $Frequency;
my $NUM_IV;
my $num_input;
my $num_output;
my @input_port, 
my @output_port;

if($benchmark_name eq "c17"){
  $num_input = 5;
  $num_output = 2;
  $Frequency  = "50";
  $NUM_IV     = "7";	
  $benchmark_name = "c17";
  @input_port = ("n1", "n2", "n3", "n6", "n7");
  @output_port = ("n22", "n23");
}
elsif($benchmark_name eq "c7"){
  $num_input = 8;
  $num_output = 4;
  $Frequency  = "100";
  $NUM_IV     = "8";	
  $benchmark_name = "c7";
  @input_port = ("n1", "n2", "n3", "n4", "n5", "n6", "n7", "n8");
  @output_port = ("n20", "n21", "n22", "n23");
}
elsif($benchmark_name eq "c432"){
  $num_input = 36;
  $num_output = 7;
  $Frequency  = "50";
  $NUM_IV     = "8";	
  $benchmark_name = "c432";
  @input_port = ("n1","n4","n8","n11","n14","n17","n21","n24","n27","n30","n34",
                 "n37","n40","n43","n47","n50","n53","n56","n60","n63",
                 "n66","n69","n73","n76","n79","n82","n86","n89","n92","n95",
                 "n99","n102","n105","n108","n112","n115");
  @output_port = ("n223","n329","n370","n421","n430","n431","n432");
}
elsif($benchmark_name eq "c864"){
  $num_input = 72;
  $num_output = 14;
  $Frequency  = "100";
  $NUM_IV     = "8";	
  $benchmark_name = "c864";
  @input_port = qw(n11 n14 n18 n111 n114 n117 n121 n124 n127 n130 n134 n137 n140 n143 n147 n150 n153 n156 n160 n163 n166 n169 n173 n176 n179 n182 n186 n189 n192 n195 n199 n1102 n1105 n1108 n1112 n1115 n21 n24 n28 n211 n214 n217 n221 n224 n227 n230 n234 n237 n240 n243 n247 n250 n253 n256 n260 n263 n266 n269 n273 n276 n279 n282 n286 n289 n292 n295 n299 n2102 n2105 n2108 n2112 n2115);
  @output_port = qw(n1223 n1329 n1370 n1421 n1430 n1431 n1432 n2223 n2329 n2370 n2421 n2430 n2431 n2432);
}
elsif($benchmark_name eq "c499"){
  $num_input = 41;
  $num_output = 32;
  $Frequency  = "100";
  $NUM_IV     = "64";	
  $benchmark_name = "c499";
  @input_port = ("n1","n5","n9","n13","n17","n21","n25","n29","n33","n37","n41",
                 "n45","n49","n53","n57","n61","n65","n69","n73","n77",
  					     "n81","n85","n89","n93","n97","n101","n105","n109","n113","n117",
  					     "n121","n125","n129","n130","n131","n132","n133","n134","n135","n136",
  					     "n137");
  @output_port = ("n724","n725","n726","n727","n728","n729","n730","n731","n732","n733",
                  "n734","n735","n736","n737","n738","n739","n740","n741","n742","n743",
                  "n744","n745","n746","n747","n748","n749","n750","n751","n752","n753",
                  "n754","n755");
}
elsif($benchmark_name eq "c880"){
  $num_input = 60;
  $num_output = 26;
  $Frequency  = "100";
  $NUM_IV     = "64";	
  $benchmark_name = "c880";
  @input_port = ("n1","n8","n13","n17","n26","n29","n36","n42","n51","n55",
                 "n59","n68","n72","n73","n74","n75","n80","n85","n86","n87",
                 "n88","n89","n90","n91","n96","n101","n106","n111","n116","n121",
                 "n126","n130","n135","n138","n143","n146","n149","n152","n153","n156",
                 "n159","n165","n171","n177","n183","n189","n195","n201","n207","n210",
                 "n219","n228","n237","n246","n255","n259","n260","n261","n267","n268");
  
  @output_port = ("n388","n389","n390","n391","n418","n419","n420","n421","n422","n423",
                  "n446","n447","n448","n449","n450","n767","n768","n850","n863","n864",
                  "n865","n866","n874","n878","n879","n880");
}
elsif($benchmark_name eq "c1908"){
  $num_input = 33;
  $num_output = 25;
  $Frequency  = "100";
  $NUM_IV     = "64";	
  $benchmark_name = "c1908";
  @input_port = ("n1","n4","n7","n10","n13","n16","n19","n22","n25","n28",
                 "n31","n34","n37","n40","n43","n46","n49","n53","n56","n60",
                 "n63","n66","n69","n72","n76","n79","n82","n85","n88","n91",
                 "n94","n99","n104");
  @output_port = ("n2753","n2754","n2755","n2756","n2762","n2767","n2768","n2779","n2780","n2781",
                  "n2782","n2783","n2784","n2785","n2786","n2787","n2811","n2886","n2887","n2888",
                  "n2889","n2890","n2891","n2892","n2899");
}
elsif($benchmark_name eq "c1355"){
  $num_input = 41;
  $num_output = 32;
  $Frequency  = "50";
  $NUM_IV     = "64";	
  $benchmark_name = "c1355";
  @input_port =("g1","g2","g3","g4","g5","g6","g7","g8","g9","g10","g11","g12","g13","g14","g15","g16","g17","g18","g19","g20",
                "g21","g22","g23","g24","g25","g26","g27","g28","g29","g30","g31","g32","g33","g34","g35","g36","g37","g38","g39",
                "g40","g41");
  @output_port=("g1324","g1325","g1326","g1327","g1328","g1329","g1330","g1331","g1332","g1333","g1334","g1335",
                "g1336","g1337","g1338","g1339","g1340","g1341","g1342","g1343","g1344","g1345","g1346","g1347",
                "g1348","g1349","g1350","g1351","g1352","g1353","g1354","g1355");

}
elsif($benchmark_name eq "c5315"){
  $num_input = 178;
  $num_output = 123;
	$Frequency  = "50";
  $NUM_IV     = "8";	
  $benchmark_name = "c5315";
  @input_port = ("n1","n4","n11","n14","n17","n20","n23","n24","n25","n26",
                 "n27","n31","n34","n37","n40","n43","n46","n49","n52","n53",
                 "n54","n61","n64","n67","n70","n73","n76","n79","n80","n81",
                 "n82","n83","n86","n87","n88","n91","n94","n97","n100","n103",
                 "n106","n109","n112","n113","n114","n115","n116","n117","n118","n119",
                 "n120","n121","n122","n123","n126","n127","n128","n129","n130","n131",
                 "n132","n135","n136","n137","n140","n141","n145","n146","n149","n152",
                 "n155","n158","n161","n164","n167","n170","n173","n176","n179","n182",
                 "n185","n188","n191","n194","n197","n200","n203","n206","n209","n210",
                 "n217","n218","n225","n226","n233","n234","n241","n242","n245","n248",
                 "n251","n254","n257","n264","n265","n272","n273","n280","n281","n288",
                 "n289","n292","n293","n299","n302","n307","n308","n315","n316","n323",
                 "n324","n331","n332","n335","n338","n341","n348","n351","n358","n361",
                 "n366","n369","n372","n373","n374","n386","n389","n400","n411","n422",
                 "n435","n446","n457","n468","n479","n490","n503","n514","n523","n534",
                 "n545","n549","n552","n556","n559","n562","n566","n571","n574","n577",
                 "n580","n583","n588","n591","n592","n595","n596","n597","n598","n599",
                 "n603","n607","n610","n613","n616","n619","n625","n631");
  @output_port = ("n709","n816","n1066","n1137","n1138","n1139","n1140","n1141","n1142","n1143",
                  "n1144","n1145","n1147","n1152","n1153","n1154","n1155","n1972","n2054","n2060",
                  "n2061","n2139","n2142","n2309","n2387","n2527","n2584","n2590","n2623","n3357",
                  "n3358","n3359","n3360","n3604","n3613","n4272","n4275","n4278","n4279","n4737",
                  "n4738","n4739","n4740","n5240","n5388","n6641","n6643","n6646","n6648","n6716",
                  "n6877","n6924","n6925","n6926","n6927","n7015","n7363","n7365","n7432","n7449",
                  "n7465","n7466","n7467","n7469","n7470","n7471","n7472","n7473","n7474","n7476",
                  "n7503","n7504","n7506","n7511","n7515","n7516","n7517","n7518","n7519","n7520",
                  "n7521","n7522","n7600","n7601","n7602","n7603","n7604","n7605","n7606","n7607",
                  "n7626","n7698","n7699","n7700","n7701","n7702","n7703","n7704","n7705","n7706",
                  "n7707","n7735","n7736","n7737","n7738","n7739","n7740","n7741","n7742","n7754",
                  "n7755","n7756","n7757","n7758","n7759","n7760","n7761","n8075","n8076","n8123",
                  "n8124","n8127","n8128");
}
elsif($benchmark_name eq "c6288"){
  $num_input = 32;
  $num_output = 32;
  $benchmark_name = "c6288";
  $Frequency  = "50";
  $NUM_IV     = "8";	
  @input_port = ("n1","n18","n35","n52","n69","n86","n103","n120","n137","n154",
                 "n171","n188","n205","n222","n239","n256","n273","n290","n307","n324",
                 "n341","n358","n375","n392","n409","n426","n443","n460","n477","n494",
                 "n511","n528");
  @output_port = ("n545","n1581","n1901","n2223","n2548","n2877","n3211","n3552","n3895","n4241",
                  "n4591","n4946","n5308","n5672","n5971","n6123","n6150","n6160","n6170","n6180",
                  "n6190","n6200","n6210","n6220","n6230","n6240","n6250","n6260","n6270","n6280",
                  "n6287","n6288");
}
elsif($benchmark_name eq "c7552"){
  $num_input = 207;
  $num_output = 108;
  $benchmark_name = "c7552";
  $Frequency  = "50";
  $NUM_IV     = "8";	
  @input_port = ("n1","n5","n9","n12","n15","n18","n23","n26","n29","n32",
     "n35","n38","n41","n44","n47","n50","n53","n54","n55","n56",
     "n57","n58","n59","n60","n61","n62","n63","n64","n65","n66",
     "n69","n70","n73","n74","n75","n76","n77","n78","n79","n80",
     "n81","n82","n83","n84","n85","n86","n87","n88","n89","n94",
     "n97","n100","n103","n106","n109","n110","n111","n112","n113","n114",
     "n115","n118","n121","n124","n127","n130","n133","n134","n135","n138",
     "n141","n144","n147","n150","n151","n152","n153","n154","n155","n156",
     "n157","n158","n159","n160","n161","n162","n163","n164","n165","n166",
     "n167","n168","n169","n170","n171","n172","n173","n174","n175","n176",
     "n177","n178","n179","n180","n181","n182","n183","n184","n185","n186",
     "n187","n188","n189","n190","n191","n192","n193","n194","n195","n196",
     "n197","n198","n199","n200","n201","n202","n203","n204","n205","n206",
     "n207","n208","n209","n210","n211","n212","n213","n214","n215","n216",
     "n217","n218","n219","n220","n221","n222","n223","n224","n225","n226",
     "n227","n228","n229","n230","n231","n232","n233","n234","n235","n236",
     "n237","n238","n239","n240","n242","n245","n248","n251","n254","n257",
     "n260","n263","n267","n271","n274","n277","n280","n283","n286","n289",
     "n293","n296","n299","n303","n307","n310","n313","n316","n319","n322",
     "n325","n328","n331","n334","n337","n340","n343","n346","n349","n352",
     "n355","n358","n361","n364","n367","n382","n241_i");
  @output_port = ("n387","n388","n478","n482","n484","n486","n489","n492","n501","n505",
      "n507","n509","n511","n513","n515","n517","n519","n535","n537","n539",
      "n541","n543","n545","n547","n549","n551","n553","n556","n559","n561",
      "n563","n565","n567","n569","n571","n573","n582","n643","n707","n813",
      "n881","n882","n883","n884","n885","n889","n945","n1110","n1111","n1112",
      "n1113","n1114","n1489","n1490","n1781","n10025","n10101","n10102","n10103","n10104",
      "n10109","n10110","n10111","n10112","n10350","n10351","n10352","n10353","n10574","n10575",
      "n10576","n10628","n10632","n10641","n10704","n10706","n10711","n10712","n10713","n10714",
      "n10715","n10716","n10717","n10718","n10729","n10759","n10760","n10761","n10762","n10763",
      "n10827","n10837","n10838","n10839","n10840","n10868","n10869","n10870","n10871","n10905",
      "n10906","n10907","n10908","n11333","n11334","n11340","n11342","n241_o");
}
elsif($benchmark_name eq "b14_ras"){
  $num_input = 277;
  $num_output = 299;
  $benchmark_name = "b14_ras";
  $Frequency  = "50";
  $NUM_IV     = "2";	
  @input_port = ("ir_reg_0_", "ir_reg_1_", "ir_reg_2_", "ir_reg_3_", "ir_reg_4_", "ir_reg_5_",
               "ir_reg_6_", "ir_reg_7_", "ir_reg_8_", "ir_reg_9_", "ir_reg_10_", "ir_reg_11_",
               "ir_reg_12_", "ir_reg_13_", "ir_reg_14_", "ir_reg_15_", "ir_reg_16_", "ir_reg_17_",
               "ir_reg_18_", "ir_reg_19_", "ir_reg_20_", "ir_reg_21_", "ir_reg_22_", "ir_reg_23_",
               "ir_reg_24_", "ir_reg_25_", "ir_reg_26_", "ir_reg_27_", "ir_reg_28_", "ir_reg_29_",
               "ir_reg_30_", "ir_reg_31_", "d_reg_0_", "d_reg_1_", "d_reg_2_", "d_reg_3_",
               "d_reg_4_", "d_reg_5_", "d_reg_6_", "d_reg_7_", "d_reg_8_", "d_reg_9_",
               "d_reg_10_", "d_reg_11_", "d_reg_12_", "d_reg_13_", "d_reg_14_", "d_reg_15_",
               "d_reg_16_", "d_reg_17_", "d_reg_18_", "d_reg_19_", "d_reg_20_", "d_reg_21_",
               "d_reg_22_", "d_reg_23_", "d_reg_24_", "d_reg_25_", "d_reg_26_", "d_reg_27_",
               "d_reg_28_", "d_reg_29_", "d_reg_30_", "d_reg_31_", "reg0_reg_0_", "reg0_reg_1_",
               "reg0_reg_2_", "reg0_reg_3_", "reg0_reg_4_", "reg0_reg_5_", "reg0_reg_6_", "reg0_reg_7_",
               "reg0_reg_8_", "reg0_reg_9_", "reg0_reg_10_", "reg0_reg_11_", "reg0_reg_12_", "reg0_reg_13_",
               "reg0_reg_14_", "reg0_reg_15_", "reg0_reg_16_", "reg0_reg_17_", "reg0_reg_18_", "reg0_reg_19_",
               "reg0_reg_20_", "reg0_reg_21_", "reg0_reg_22_", "reg0_reg_23_", "reg0_reg_24_", "reg0_reg_25_",
               "reg0_reg_26_", "reg0_reg_27_", "reg0_reg_28_", "reg0_reg_29_", "reg0_reg_30_", "reg0_reg_31_",
               "reg1_reg_0_", "reg1_reg_1_", "reg1_reg_2_", "reg1_reg_3_", "reg1_reg_4_", "reg1_reg_5_",
               "reg1_reg_6_", "reg1_reg_7_", "reg1_reg_8_", "reg1_reg_9_", "reg1_reg_10_", "reg1_reg_11_",
               "reg1_reg_12_", "reg1_reg_13_", "reg1_reg_14_", "reg1_reg_15_", "reg1_reg_16_", "reg1_reg_17_",
               "reg1_reg_18_", "reg1_reg_19_", "reg1_reg_20_", "reg1_reg_21_", "reg1_reg_22_", "reg1_reg_23_",
               "reg1_reg_24_", "reg1_reg_25_", "reg1_reg_26_", "reg1_reg_27_", "reg1_reg_28_", "reg1_reg_29_",
               "reg1_reg_30_", "reg1_reg_31_", "reg2_reg_0_", "reg2_reg_1_", "reg2_reg_2_", "reg2_reg_3_",
               "reg2_reg_4_", "reg2_reg_5_", "reg2_reg_6_", "reg2_reg_7_", "reg2_reg_8_", "reg2_reg_9_",
               "reg2_reg_10_", "reg2_reg_11_", "reg2_reg_12_", "reg2_reg_13_", "reg2_reg_14_", "reg2_reg_15_",
               "reg2_reg_16_", "reg2_reg_17_", "reg2_reg_18_", "reg2_reg_19_", "reg2_reg_20_", "reg2_reg_21_",
               "reg2_reg_22_", "reg2_reg_23_", "reg2_reg_24_", "reg2_reg_25_", "reg2_reg_26_", "reg2_reg_27_",
               "reg2_reg_28_", "reg2_reg_29_", "reg2_reg_30_", "reg2_reg_31_", "addr_reg_19__extra", "addr_reg_18__extra",
               "addr_reg_17__extra", "addr_reg_16__extra", "addr_reg_15__extra", "addr_reg_14__extra", "addr_reg_13__extra", "addr_reg_12__extra",
               "addr_reg_11__extra", "addr_reg_10__extra", "addr_reg_9__extra", "addr_reg_8__extra", "addr_reg_7__extra", "addr_reg_6__extra",
               "addr_reg_5__extra", "addr_reg_4__extra", "addr_reg_3__extra", "addr_reg_2__extra", "addr_reg_1__extra", "addr_reg_0__extra",
               "datao_reg_0__extra", "datao_reg_1__extra", "datao_reg_2__extra", "datao_reg_3__extra", "datao_reg_4__extra", "datao_reg_5__extra",
               "datao_reg_6__extra", "datao_reg_7__extra", "datao_reg_8__extra", "datao_reg_9__extra", "datao_reg_10__extra", "datao_reg_11__extra",
               "datao_reg_12__extra", "datao_reg_13__extra", "datao_reg_14__extra", "datao_reg_15__extra", "datao_reg_16__extra", "datao_reg_17__extra",
               "datao_reg_18__extra", "datao_reg_19__extra", "datao_reg_20__extra", "datao_reg_21__extra", "datao_reg_22__extra", "datao_reg_23__extra",
               "datao_reg_24__extra", "datao_reg_25__extra", "datao_reg_26__extra", "datao_reg_27__extra", "datao_reg_28__extra", "datao_reg_29__extra",
               "datao_reg_30__extra", "datao_reg_31__extra", "b_reg", "reg3_reg_15_", "reg3_reg_26_", "reg3_reg_6_",
               "reg3_reg_18_", "reg3_reg_2_", "reg3_reg_11_", "reg3_reg_22_", "reg3_reg_13_", "reg3_reg_20_",
               "reg3_reg_0_", "reg3_reg_9_", "reg3_reg_4_", "reg3_reg_24_", "reg3_reg_17_", "reg3_reg_5_",
               "reg3_reg_16_", "reg3_reg_25_", "reg3_reg_12_", "reg3_reg_21_", "reg3_reg_1_", "reg3_reg_8_",
               "reg3_reg_28_", "reg3_reg_19_", "reg3_reg_3_", "reg3_reg_10_", "reg3_reg_23_", "reg3_reg_14_",
               "reg3_reg_27_", "reg3_reg_7_", "state_reg", "rd_reg_extra", "wr_reg_extra", "datai_31_",
               "datai_30_", "datai_29_", "datai_28_", "datai_27_", "datai_26_", "datai_25_",
               "datai_24_", "datai_23_", "datai_22_", "datai_21_", "datai_20_", "datai_19_",
               "datai_18_", "datai_17_", "datai_16_", "datai_15_", "datai_14_", "datai_13_",
               "datai_12_", "datai_11_", "datai_10_", "datai_9_", "datai_8_", "datai_7_",
               "datai_6_", "datai_5_", "datai_4_", "datai_3_", "datai_2_", "datai_1_", "datai_0_" );
  @output_port = ( "u3352", "u3351", "u3350", "u3349", "u3348", "u3347",
               "u3346", "u3345", "u3344", "u3343", "u3342", "u3341",
               "u3340", "u3339", "u3338", "u3337", "u3336", "u3335",
               "u3334", "u3333", "u3332", "u3331", "u3330", "u3329",
               "u3328", "u3327", "u3326", "u3325", "u3324", "u3323",
               "u3322", "u3321", "u3458", "u3459", "u3320", "u3319",
               "u3318", "u3317", "u3316", "u3315", "u3314", "u3313",
               "u3312", "u3311", "u3310", "u3309", "u3308", "u3307",
               "u3306", "u3305", "u3304", "u3303", "u3302", "u3301",
               "u3300", "u3299", "u3298", "u3297", "u3296", "u3295",
               "u3294", "u3293", "u3292", "u3291", "u3467", "u3469",
               "u3471", "u3473", "u3475", "u3477", "u3479", "u3481",
               "u3483", "u3485", "u3487", "u3489", "u3491", "u3493",
               "u3495", "u3497", "u3499", "u3501", "u3503", "u3505",
               "u3506", "u3507", "u3508", "u3509", "u3510", "u3511",
               "u3512", "u3513", "u3514", "u3515", "u3516", "u3517",
               "u3518", "u3519", "u3520", "u3521", "u3522", "u3523",
               "u3524", "u3525", "u3526", "u3527", "u3528", "u3529",
               "u3530", "u3531", "u3532", "u3533", "u3534", "u3535",
               "u3536", "u3537", "u3538", "u3539", "u3540", "u3541",
               "u3542", "u3543", "u3544", "u3545", "u3546", "u3547",
               "u3548", "u3549", "u3290", "u3289", "u3288", "u3287",
               "u3286", "u3285", "u3284", "u3283", "u3282", "u3281",
               "u3280", "u3279", "u3278", "u3277", "u3276", "u3275",
               "u3274", "u3273", "u3272", "u3271", "u3270", "u3269",
               "u3268", "u3267", "u3266", "u3265", "u3264", "u3263",
               "u3262", "u3354", "u3261", "u3260", "u3259", "u3258",
               "u3257", "u3256", "u3255", "u3254", "u3253", "u3252",
               "u3251", "u3250", "u3249", "u3248", "u3247", "u3246",
               "u3245", "u3244", "u3243", "u3242", "u3241", "u3240",
               "u3550", "u3551", "u3552", "u3553", "u3554", "u3555",
               "u3556", "u3557", "u3558", "u3559", "u3560", "u3561",
               "u3562", "u3563", "u3564", "u3565", "u3566", "u3567",
               "u3568", "u3569", "u3570", "u3571", "u3572", "u3573",
               "u3574", "u3575", "u3576", "u3577", "u3578", "u3579",
               "u3580", "u3581", "u3239", "u3238", "u3237", "u3236",
               "u3235", "u3234", "u3233", "u3232", "u3231", "u3230",
               "u3229", "u3228", "u3227", "u3226", "u3225", "u3224",
               "u3223", "u3222", "u3221", "u3220", "u3219", "u3218",
               "u3217", "u3216", "u3215", "u3214", "u3213", "u3212",
               "u3211", "u3210", "u3149", "u3148", "u4043", "addr_reg_19_",
               "addr_reg_18_", "addr_reg_17_", "addr_reg_16_", "addr_reg_15_", "addr_reg_14_", "addr_reg_13_",
               "addr_reg_12_", "addr_reg_11_", "addr_reg_10_", "addr_reg_9_", "addr_reg_8_", "addr_reg_7_",
               "addr_reg_6_", "addr_reg_5_", "addr_reg_4_", "addr_reg_3_", "addr_reg_2_", "addr_reg_1_",
               "addr_reg_0_", "datao_reg_31_", "datao_reg_30_", "datao_reg_29_", "datao_reg_28_", "datao_reg_27_",
               "datao_reg_26_", "datao_reg_25_", "datao_reg_24_", "datao_reg_23_", "datao_reg_22_", "datao_reg_21_",
               "datao_reg_20_", "datao_reg_19_", "datao_reg_18_", "datao_reg_17_", "datao_reg_16_", "datao_reg_15_",
               "datao_reg_14_", "datao_reg_13_", "datao_reg_12_", "datao_reg_11_", "datao_reg_10_", "datao_reg_9_",
               "datao_reg_8_", "datao_reg_7_", "datao_reg_6_", "datao_reg_5_", "datao_reg_4_", "datao_reg_3_",
               "datao_reg_2_", "datao_reg_1_", "datao_reg_0_", "rd_reg", "wr_reg");
}
elsif($benchmark_name eq "b15_ras"){
  $num_input = 485;
  $num_output = 519;
  $benchmark_name = "b15_ras";
  $Frequency  = "50";
  $NUM_IV     = "2";
@input_port = ("be_n_reg_3__extra","be_n_reg_2__extra","be_n_reg_1__extra","be_n_reg_0__extra","address_reg_29__extra","address_reg_28__extra","address_reg_27__extra","address_reg_26__extra","address_reg_25__extra","address_reg_24__extra",
        "address_reg_23__extra","address_reg_22__extra","address_reg_21__extra","address_reg_20__extra","address_reg_19__extra","address_reg_18__extra","address_reg_17__extra","address_reg_16__extra","address_reg_15__extra","address_reg_14__extra",
        "address_reg_13__extra","address_reg_12__extra","address_reg_11__extra","address_reg_10__extra","address_reg_9__extra","address_reg_8__extra","address_reg_7__extra","address_reg_6__extra","address_reg_5__extra","address_reg_4__extra",
        "address_reg_3__extra","address_reg_2__extra","address_reg_1__extra","address_reg_0__extra","state_reg_2_","state_reg_1_","state_reg_0_","datawidth_reg_0_","datawidth_reg_1_","datawidth_reg_2_",
        "datawidth_reg_3_","datawidth_reg_4_","datawidth_reg_5_","datawidth_reg_6_","datawidth_reg_7_","datawidth_reg_8_","datawidth_reg_9_","datawidth_reg_10_","datawidth_reg_11_","datawidth_reg_12_",
        "datawidth_reg_13_","datawidth_reg_14_","datawidth_reg_15_","datawidth_reg_16_","datawidth_reg_17_","datawidth_reg_18_","datawidth_reg_19_","datawidth_reg_20_","datawidth_reg_21_","datawidth_reg_22_",
        "datawidth_reg_23_","datawidth_reg_24_","datawidth_reg_25_","datawidth_reg_26_","datawidth_reg_27_","datawidth_reg_28_","datawidth_reg_29_","datawidth_reg_30_","datawidth_reg_31_","state2_reg_3_",
        "state2_reg_2_","state2_reg_1_","state2_reg_0_","instqueue_reg_15__7_","instqueue_reg_15__6_","instqueue_reg_15__5_","instqueue_reg_15__4_","instqueue_reg_15__3_","instqueue_reg_15__2_","instqueue_reg_15__1_",
        "instqueue_reg_15__0_","instqueue_reg_14__7_","instqueue_reg_14__6_","instqueue_reg_14__5_","instqueue_reg_14__4_","instqueue_reg_14__3_","instqueue_reg_14__2_","instqueue_reg_14__1_","instqueue_reg_14__0_","instqueue_reg_13__7_",
        "instqueue_reg_13__6_","instqueue_reg_13__5_","instqueue_reg_13__4_","instqueue_reg_13__3_","instqueue_reg_13__2_","instqueue_reg_13__1_","instqueue_reg_13__0_","instqueue_reg_12__7_","instqueue_reg_12__6_","instqueue_reg_12__5_",
        "instqueue_reg_12__4_","instqueue_reg_12__3_","instqueue_reg_12__2_","instqueue_reg_12__1_","instqueue_reg_12__0_","instqueue_reg_11__7_","instqueue_reg_11__6_","instqueue_reg_11__5_","instqueue_reg_11__4_","instqueue_reg_11__3_",
        "instqueue_reg_11__2_","instqueue_reg_11__1_","instqueue_reg_11__0_","instqueue_reg_10__7_","instqueue_reg_10__6_","instqueue_reg_10__5_","instqueue_reg_10__4_","instqueue_reg_10__3_","instqueue_reg_10__2_","instqueue_reg_10__1_",
        "instqueue_reg_10__0_","instqueue_reg_9__7_","instqueue_reg_9__6_","instqueue_reg_9__5_","instqueue_reg_9__4_","instqueue_reg_9__3_","instqueue_reg_9__2_","instqueue_reg_9__1_","instqueue_reg_9__0_","instqueue_reg_8__7_",
        "instqueue_reg_8__6_","instqueue_reg_8__5_","instqueue_reg_8__4_","instqueue_reg_8__3_","instqueue_reg_8__2_","instqueue_reg_8__1_","instqueue_reg_8__0_","instqueue_reg_7__7_","instqueue_reg_7__6_","instqueue_reg_7__5_",
        "instqueue_reg_7__4_","instqueue_reg_7__3_","instqueue_reg_7__2_","instqueue_reg_7__1_","instqueue_reg_7__0_","instqueue_reg_6__7_","instqueue_reg_6__6_","instqueue_reg_6__5_","instqueue_reg_6__4_","instqueue_reg_6__3_",
        "instqueue_reg_6__2_","instqueue_reg_6__1_","instqueue_reg_6__0_","instqueue_reg_5__7_","instqueue_reg_5__6_","instqueue_reg_5__5_","instqueue_reg_5__4_","instqueue_reg_5__3_","instqueue_reg_5__2_","instqueue_reg_5__1_",
        "instqueue_reg_5__0_","instqueue_reg_4__7_","instqueue_reg_4__6_","instqueue_reg_4__5_","instqueue_reg_4__4_","instqueue_reg_4__3_","instqueue_reg_4__2_","instqueue_reg_4__1_","instqueue_reg_4__0_","instqueue_reg_3__7_",
        "instqueue_reg_3__6_","instqueue_reg_3__5_","instqueue_reg_3__4_","instqueue_reg_3__3_","instqueue_reg_3__2_","instqueue_reg_3__1_","instqueue_reg_3__0_","instqueue_reg_2__7_","instqueue_reg_2__6_","instqueue_reg_2__5_",
        "instqueue_reg_2__4_","instqueue_reg_2__3_","instqueue_reg_2__2_","instqueue_reg_2__1_","instqueue_reg_2__0_","instqueue_reg_1__7_","instqueue_reg_1__6_","instqueue_reg_1__5_","instqueue_reg_1__4_","instqueue_reg_1__3_",
        "instqueue_reg_1__2_","instqueue_reg_1__1_","instqueue_reg_1__0_","instqueue_reg_0__7_","instqueue_reg_0__6_","instqueue_reg_0__5_","instqueue_reg_0__4_","instqueue_reg_0__3_","instqueue_reg_0__2_","instqueue_reg_0__1_",
        "instqueue_reg_0__0_","instqueuerd_addr_reg_4_","instqueuerd_addr_reg_3_","instqueuerd_addr_reg_2_","instqueuerd_addr_reg_1_","instqueuerd_addr_reg_0_","instqueuewr_addr_reg_4_","instqueuewr_addr_reg_3_","instqueuewr_addr_reg_2_","instqueuewr_addr_reg_1_",
        "instqueuewr_addr_reg_0_","instaddrpointer_reg_0_","instaddrpointer_reg_1_","instaddrpointer_reg_2_","instaddrpointer_reg_3_","instaddrpointer_reg_4_","instaddrpointer_reg_5_","instaddrpointer_reg_6_","instaddrpointer_reg_7_","instaddrpointer_reg_8_",
        "instaddrpointer_reg_9_","instaddrpointer_reg_10_","instaddrpointer_reg_11_","instaddrpointer_reg_12_","instaddrpointer_reg_13_","instaddrpointer_reg_14_","instaddrpointer_reg_15_","instaddrpointer_reg_16_","instaddrpointer_reg_17_","instaddrpointer_reg_18_",
        "instaddrpointer_reg_19_","instaddrpointer_reg_20_","instaddrpointer_reg_21_","instaddrpointer_reg_22_","instaddrpointer_reg_23_","instaddrpointer_reg_24_","instaddrpointer_reg_25_","instaddrpointer_reg_26_","instaddrpointer_reg_27_","instaddrpointer_reg_28_",
        "instaddrpointer_reg_29_","instaddrpointer_reg_30_","instaddrpointer_reg_31_","phyaddrpointer_reg_0_","phyaddrpointer_reg_1_","phyaddrpointer_reg_2_","phyaddrpointer_reg_3_","phyaddrpointer_reg_4_","phyaddrpointer_reg_5_","phyaddrpointer_reg_6_",
        "phyaddrpointer_reg_7_","phyaddrpointer_reg_8_","phyaddrpointer_reg_9_","phyaddrpointer_reg_10_","phyaddrpointer_reg_11_","phyaddrpointer_reg_12_","phyaddrpointer_reg_13_","phyaddrpointer_reg_14_","phyaddrpointer_reg_15_","phyaddrpointer_reg_16_",
        "phyaddrpointer_reg_17_","phyaddrpointer_reg_18_","phyaddrpointer_reg_19_","phyaddrpointer_reg_20_","phyaddrpointer_reg_21_","phyaddrpointer_reg_22_","phyaddrpointer_reg_23_","phyaddrpointer_reg_24_","phyaddrpointer_reg_25_","phyaddrpointer_reg_26_",
        "phyaddrpointer_reg_27_","phyaddrpointer_reg_28_","phyaddrpointer_reg_29_","phyaddrpointer_reg_30_","phyaddrpointer_reg_31_","lword_reg_15_","lword_reg_14_","lword_reg_13_","lword_reg_12_","lword_reg_11_",
        "lword_reg_10_","lword_reg_9_","lword_reg_8_","lword_reg_7_","lword_reg_6_","lword_reg_5_","lword_reg_4_","lword_reg_3_","lword_reg_2_","lword_reg_1_",
        "lword_reg_0_","uword_reg_14_","uword_reg_13_","uword_reg_12_","uword_reg_11_","uword_reg_10_","uword_reg_9_","uword_reg_8_","uword_reg_7_","uword_reg_6_",
        "uword_reg_5_","uword_reg_4_","uword_reg_3_","uword_reg_2_","uword_reg_1_","uword_reg_0_","datao_reg_0__extra","datao_reg_1__extra","datao_reg_2__extra","datao_reg_3__extra",
        "datao_reg_4__extra","datao_reg_5__extra","datao_reg_6__extra","datao_reg_7__extra","datao_reg_8__extra","datao_reg_9__extra","datao_reg_10__extra","datao_reg_11__extra","datao_reg_12__extra","datao_reg_13__extra",
        "datao_reg_14__extra","datao_reg_15__extra","datao_reg_16__extra","datao_reg_17__extra","datao_reg_18__extra","datao_reg_19__extra","datao_reg_20__extra","datao_reg_21__extra","datao_reg_22__extra","datao_reg_23__extra",
        "datao_reg_24__extra","datao_reg_25__extra","datao_reg_26__extra","datao_reg_27__extra","datao_reg_28__extra","datao_reg_29__extra","datao_reg_30__extra","datao_reg_31__extra","eax_reg_0_","eax_reg_1_",
        "eax_reg_2_","eax_reg_3_","eax_reg_4_","eax_reg_5_","eax_reg_6_","eax_reg_7_","eax_reg_8_","eax_reg_9_","eax_reg_10_","eax_reg_11_",
        "eax_reg_12_","eax_reg_13_","eax_reg_14_","eax_reg_15_","eax_reg_16_","eax_reg_17_","eax_reg_18_","eax_reg_19_","eax_reg_20_","eax_reg_21_",
        "eax_reg_22_","eax_reg_23_","eax_reg_24_","eax_reg_25_","eax_reg_26_","eax_reg_27_","eax_reg_28_","eax_reg_29_","eax_reg_30_","eax_reg_31_",
        "ebx_reg_0_","ebx_reg_1_","ebx_reg_2_","ebx_reg_3_","ebx_reg_4_","ebx_reg_5_","ebx_reg_6_","ebx_reg_7_","ebx_reg_8_","ebx_reg_9_",
        "ebx_reg_10_","ebx_reg_11_","ebx_reg_12_","ebx_reg_13_","ebx_reg_14_","ebx_reg_15_","ebx_reg_16_","ebx_reg_17_","ebx_reg_18_","ebx_reg_19_",
        "ebx_reg_20_","ebx_reg_21_","ebx_reg_22_","ebx_reg_23_","ebx_reg_24_","ebx_reg_25_","ebx_reg_26_","ebx_reg_27_","ebx_reg_28_","ebx_reg_29_",
        "ebx_reg_30_","ebx_reg_31_","reip_reg_0_","reip_reg_1_","reip_reg_2_","reip_reg_3_","reip_reg_4_","reip_reg_5_","reip_reg_6_","reip_reg_7_",
        "reip_reg_8_","reip_reg_9_","reip_reg_10_","reip_reg_11_","reip_reg_12_","reip_reg_13_","reip_reg_14_","reip_reg_15_","reip_reg_16_","reip_reg_17_",
        "reip_reg_18_","reip_reg_19_","reip_reg_20_","reip_reg_21_","reip_reg_22_","reip_reg_23_","reip_reg_24_","reip_reg_25_","reip_reg_26_","reip_reg_27_",
        "reip_reg_28_","reip_reg_29_","reip_reg_30_","reip_reg_31_","byteenable_reg_3_","byteenable_reg_2_","byteenable_reg_1_","byteenable_reg_0_","w_r_n_reg_extra","flush_reg",
        "more_reg","statebs16_reg","requestpending_reg","d_c_n_reg_extra","m_io_n_reg_extra","codefetch_reg","ads_n_reg_extra","readrequest_reg","memoryfetch_reg","datai_31_",
        "datai_30_","datai_29_","datai_28_","datai_27_","datai_26_","datai_25_","datai_24_","datai_23_","datai_22_","datai_21_",
        "datai_20_","datai_19_","datai_18_","datai_17_","datai_16_","datai_15_","datai_14_","datai_13_","datai_12_","datai_11_",
        "datai_10_","datai_9_","datai_8_","datai_7_","datai_6_","datai_5_","datai_4_","datai_3_","datai_2_","datai_1_",
        "datai_0_","na_n","bs16_n","ready_n","hold");
@output_port = ("u3445","u3446","u3447","u3448","u3213","u3212","u3211","u3210","u3209","u3208",
        "u3207","u3206","u3205","u3204","u3203","u3202","u3201","u3200","u3199","u3198",
        "u3197","u3196","u3195","u3194","u3193","u3192","u3191","u3190","u3189","u3188",
        "u3187","u3186","u3185","u3184","u3183","u3182","u3181","u3451","u3452","u3180",
        "u3179","u3178","u3177","u3176","u3175","u3174","u3173","u3172","u3171","u3170",
        "u3169","u3168","u3167","u3166","u3165","u3164","u3163","u3162","u3161","u3160",
        "u3159","u3158","u3157","u3156","u3155","u3154","u3153","u3152","u3151","u3453",
        "u3150","u3149","u3148","u3147","u3146","u3145","u3144","u3143","u3142","u3141",
        "u3140","u3139","u3138","u3137","u3136","u3135","u3134","u3133","u3132","u3131",
        "u3130","u3129","u3128","u3127","u3126","u3125","u3124","u3123","u3122","u3121",
        "u3120","u3119","u3118","u3117","u3116","u3115","u3114","u3113","u3112","u3111",
        "u3110","u3109","u3108","u3107","u3106","u3105","u3104","u3103","u3102","u3101",
        "u3100","u3099","u3098","u3097","u3096","u3095","u3094","u3093","u3092","u3091",
        "u3090","u3089","u3088","u3087","u3086","u3085","u3084","u3083","u3082","u3081",
        "u3080","u3079","u3078","u3077","u3076","u3075","u3074","u3073","u3072","u3071",
        "u3070","u3069","u3068","u3067","u3066","u3065","u3064","u3063","u3062","u3061",
        "u3060","u3059","u3058","u3057","u3056","u3055","u3054","u3053","u3052","u3051",
        "u3050","u3049","u3048","u3047","u3046","u3045","u3044","u3043","u3042","u3041",
        "u3040","u3039","u3038","u3037","u3036","u3035","u3034","u3033","u3032","u3031",
        "u3030","u3029","u3028","u3027","u3026","u3025","u3024","u3023","u3022","u3021",
        "u3020","u3455","u3456","u3459","u3460","u3461","u3019","u3462","u3463","u3464",
        "u3465","u3018","u3017","u3016","u3015","u3014","u3013","u3012","u3011","u3010",
        "u3009","u3008","u3007","u3006","u3005","u3004","u3003","u3002","u3001","u3000",
        "u2999","u2998","u2997","u2996","u2995","u2994","u2993","u2992","u2991","u2990",
        "u2989","u2988","u2987","u2986","u2985","u2984","u2983","u2982","u2981","u2980",
        "u2979","u2978","u2977","u2976","u2975","u2974","u2973","u2972","u2971","u2970",
        "u2969","u2968","u2967","u2966","u2965","u2964","u2963","u2962","u2961","u2960",
        "u2959","u2958","u2957","u2956","u2955","u2954","u2953","u2952","u2951","u2950",
        "u2949","u2948","u2947","u2946","u2945","u2944","u2943","u2942","u2941","u2940",
        "u2939","u2938","u2937","u2936","u2935","u2934","u2933","u2932","u2931","u2930",
        "u2929","u2928","u2927","u2926","u2925","u2924","u2923","u2922","u2921","u2920",
        "u2919","u2918","u2917","u2916","u2915","u2914","u2913","u2912","u2911","u2910",
        "u2909","u2908","u2907","u2906","u2905","u2904","u2903","u2902","u2901","u2900",
        "u2899","u2898","u2897","u2896","u2895","u2894","u2893","u2892","u2891","u2890",
        "u2889","u2888","u2887","u2886","u2885","u2884","u2883","u2882","u2881","u2880",
        "u2879","u2878","u2877","u2876","u2875","u2874","u2873","u2872","u2871","u2870",
        "u2869","u2868","u2867","u2866","u2865","u2864","u2863","u2862","u2861","u2860",
        "u2859","u2858","u2857","u2856","u2855","u2854","u2853","u2852","u2851","u2850",
        "u2849","u2848","u2847","u2846","u2845","u2844","u2843","u2842","u2841","u2840",
        "u2839","u2838","u2837","u2836","u2835","u2834","u2833","u2832","u2831","u2830",
        "u2829","u2828","u2827","u2826","u2825","u2824","u2823","u2822","u2821","u2820",
        "u2819","u2818","u2817","u2816","u2815","u2814","u2813","u2812","u2811","u2810",
        "u2809","u2808","u2807","u2806","u2805","u2804","u2803","u2802","u2801","u2800",
        "u2799","u2798","u2797","u2796","u2795","u3468","u2794","u3469","u3470","u2793",
        "u3471","u2792","u3472","u2791","u3473","u2790","u2789","u3474","u2788","be_n_reg_3_",
        "be_n_reg_2_","be_n_reg_1_","be_n_reg_0_","address_reg_29_","address_reg_28_","address_reg_27_","address_reg_26_","address_reg_25_","address_reg_24_","address_reg_23_",
        "address_reg_22_","address_reg_21_","address_reg_20_","address_reg_19_","address_reg_18_","address_reg_17_","address_reg_16_","address_reg_15_","address_reg_14_","address_reg_13_",
        "address_reg_12_","address_reg_11_","address_reg_10_","address_reg_9_","address_reg_8_","address_reg_7_","address_reg_6_","address_reg_5_","address_reg_4_","address_reg_3_",
        "address_reg_2_","address_reg_1_","address_reg_0_","w_r_n_reg","d_c_n_reg","m_io_n_reg","ads_n_reg","datao_reg_31_","datao_reg_30_","datao_reg_29_",
        "datao_reg_28_","datao_reg_27_","datao_reg_26_","datao_reg_25_","datao_reg_24_","datao_reg_23_","datao_reg_22_","datao_reg_21_","datao_reg_20_","datao_reg_19_",
        "datao_reg_18_","datao_reg_17_","datao_reg_16_","datao_reg_15_","datao_reg_14_","datao_reg_13_","datao_reg_12_","datao_reg_11_","datao_reg_10_","datao_reg_9_",
        "datao_reg_8_","datao_reg_7_","datao_reg_6_","datao_reg_5_","datao_reg_4_","datao_reg_3_","datao_reg_2_","datao_reg_1_","datao_reg_0_");
}
elsif($benchmark_name eq "b20_ras"){
  $num_input = 522;
  $num_output = 512;
  $benchmark_name = "b20_ras";
  $Frequency  = "50";
  $NUM_IV     = "2";
@input_port = ("si_31_","si_30_","si_29_","si_28_","si_27_","si_26_","si_25_","si_24_","si_23_","si_22_",
        "si_21_","si_20_","si_19_","si_18_","si_17_","si_16_","si_15_","si_14_","si_13_","si_12_",
        "si_11_","si_10_","si_9_","si_8_","si_7_","si_6_","si_5_","si_4_","si_3_","si_2_",
        "si_1_","si_0_","p1_ir_reg_0_","p1_ir_reg_1_","p1_ir_reg_2_","p1_ir_reg_3_","p1_ir_reg_4_","p1_ir_reg_5_","p1_ir_reg_6_","p1_ir_reg_7_",
        "p1_ir_reg_8_","p1_ir_reg_9_","p1_ir_reg_10_","p1_ir_reg_11_","p1_ir_reg_12_","p1_ir_reg_13_","p1_ir_reg_14_","p1_ir_reg_15_","p1_ir_reg_16_","p1_ir_reg_17_",
        "p1_ir_reg_18_","p1_ir_reg_19_","p1_ir_reg_20_","p1_ir_reg_21_","p1_ir_reg_22_","p1_ir_reg_23_","p1_ir_reg_24_","p1_ir_reg_25_","p1_ir_reg_26_","p1_ir_reg_27_",
        "p1_ir_reg_28_","p1_ir_reg_29_","p1_ir_reg_30_","p1_ir_reg_31_","p1_d_reg_0_","p1_d_reg_1_","p1_d_reg_2_","p1_d_reg_3_","p1_d_reg_4_","p1_d_reg_5_",
        "p1_d_reg_6_","p1_d_reg_7_","p1_d_reg_8_","p1_d_reg_9_","p1_d_reg_10_","p1_d_reg_11_","p1_d_reg_12_","p1_d_reg_13_","p1_d_reg_14_","p1_d_reg_15_",
        "p1_d_reg_16_","p1_d_reg_17_","p1_d_reg_18_","p1_d_reg_19_","p1_d_reg_20_","p1_d_reg_21_","p1_d_reg_22_","p1_d_reg_23_","p1_d_reg_24_","p1_d_reg_25_",
        "p1_d_reg_26_","p1_d_reg_27_","p1_d_reg_28_","p1_d_reg_29_","p1_d_reg_30_","p1_d_reg_31_","p1_reg0_reg_0_","p1_reg0_reg_1_","p1_reg0_reg_2_","p1_reg0_reg_3_",
        "p1_reg0_reg_4_","p1_reg0_reg_5_","p1_reg0_reg_6_","p1_reg0_reg_7_","p1_reg0_reg_8_","p1_reg0_reg_9_","p1_reg0_reg_10_","p1_reg0_reg_11_","p1_reg0_reg_12_","p1_reg0_reg_13_",
        "p1_reg0_reg_14_","p1_reg0_reg_15_","p1_reg0_reg_16_","p1_reg0_reg_17_","p1_reg0_reg_18_","p1_reg0_reg_19_","p1_reg0_reg_20_","p1_reg0_reg_21_","p1_reg0_reg_22_","p1_reg0_reg_23_",
        "p1_reg0_reg_24_","p1_reg0_reg_25_","p1_reg0_reg_26_","p1_reg0_reg_27_","p1_reg0_reg_28_","p1_reg0_reg_29_","p1_reg0_reg_30_","p1_reg0_reg_31_","p1_reg1_reg_0_","p1_reg1_reg_1_",
        "p1_reg1_reg_2_","p1_reg1_reg_3_","p1_reg1_reg_4_","p1_reg1_reg_5_","p1_reg1_reg_6_","p1_reg1_reg_7_","p1_reg1_reg_8_","p1_reg1_reg_9_","p1_reg1_reg_10_","p1_reg1_reg_11_",
        "p1_reg1_reg_12_","p1_reg1_reg_13_","p1_reg1_reg_14_","p1_reg1_reg_15_","p1_reg1_reg_16_","p1_reg1_reg_17_","p1_reg1_reg_18_","p1_reg1_reg_19_","p1_reg1_reg_20_","p1_reg1_reg_21_",
        "p1_reg1_reg_22_","p1_reg1_reg_23_","p1_reg1_reg_24_","p1_reg1_reg_25_","p1_reg1_reg_26_","p1_reg1_reg_27_","p1_reg1_reg_28_","p1_reg1_reg_29_","p1_reg1_reg_30_","p1_reg1_reg_31_",
        "p1_reg2_reg_0_","p1_reg2_reg_1_","p1_reg2_reg_2_","p1_reg2_reg_3_","p1_reg2_reg_4_","p1_reg2_reg_5_","p1_reg2_reg_6_","p1_reg2_reg_7_","p1_reg2_reg_8_","p1_reg2_reg_9_",
        "p1_reg2_reg_10_","p1_reg2_reg_11_","p1_reg2_reg_12_","p1_reg2_reg_13_","p1_reg2_reg_14_","p1_reg2_reg_15_","p1_reg2_reg_16_","p1_reg2_reg_17_","p1_reg2_reg_18_","p1_reg2_reg_19_",
        "p1_reg2_reg_20_","p1_reg2_reg_21_","p1_reg2_reg_22_","p1_reg2_reg_23_","p1_reg2_reg_24_","p1_reg2_reg_25_","p1_reg2_reg_26_","p1_reg2_reg_27_","p1_reg2_reg_28_","p1_reg2_reg_29_",
        "p1_reg2_reg_30_","p1_reg2_reg_31_","p1_addr_reg_19_","p1_addr_reg_18_","p1_addr_reg_17_","p1_addr_reg_16_","p1_addr_reg_15_","p1_addr_reg_14_","p1_addr_reg_13_","p1_addr_reg_12_",
        "p1_addr_reg_11_","p1_addr_reg_10_","p1_addr_reg_9_","p1_addr_reg_8_","p1_addr_reg_7_","p1_addr_reg_6_","p1_addr_reg_5_","p1_addr_reg_4_","p1_addr_reg_3_","p1_addr_reg_2_",
        "p1_addr_reg_1_","p1_addr_reg_0_","p1_datao_reg_0_","p1_datao_reg_1_","p1_datao_reg_2_","p1_datao_reg_3_","p1_datao_reg_4_","p1_datao_reg_5_","p1_datao_reg_6_","p1_datao_reg_7_",
        "p1_datao_reg_8_","p1_datao_reg_9_","p1_datao_reg_10_","p1_datao_reg_11_","p1_datao_reg_12_","p1_datao_reg_13_","p1_datao_reg_14_","p1_datao_reg_15_","p1_datao_reg_16_","p1_datao_reg_17_",
        "p1_datao_reg_18_","p1_datao_reg_19_","p1_datao_reg_20_","p1_datao_reg_21_","p1_datao_reg_22_","p1_datao_reg_23_","p1_datao_reg_24_","p1_datao_reg_25_","p1_datao_reg_26_","p1_datao_reg_27_",
        "p1_datao_reg_28_","p1_datao_reg_29_","p1_datao_reg_30_","p1_datao_reg_31_","p1_b_reg","p1_reg3_reg_15_","p1_reg3_reg_26_","p1_reg3_reg_6_","p1_reg3_reg_18_","p1_reg3_reg_2_",
        "p1_reg3_reg_11_","p1_reg3_reg_22_","p1_reg3_reg_13_","p1_reg3_reg_20_","p1_reg3_reg_0_","p1_reg3_reg_9_","p1_reg3_reg_4_","p1_reg3_reg_24_","p1_reg3_reg_17_","p1_reg3_reg_5_",
        "p1_reg3_reg_16_","p1_reg3_reg_25_","p1_reg3_reg_12_","p1_reg3_reg_21_","p1_reg3_reg_1_","p1_reg3_reg_8_","p1_reg3_reg_28_","p1_reg3_reg_19_","p1_reg3_reg_3_","p1_reg3_reg_10_",
        "p1_reg3_reg_23_","p1_reg3_reg_14_","p1_reg3_reg_27_","p1_reg3_reg_7_","p1_state_reg","p1_rd_reg","p1_wr_reg","p2_ir_reg_0_","p2_ir_reg_1_","p2_ir_reg_2_",
        "p2_ir_reg_3_","p2_ir_reg_4_","p2_ir_reg_5_","p2_ir_reg_6_","p2_ir_reg_7_","p2_ir_reg_8_","p2_ir_reg_9_","p2_ir_reg_10_","p2_ir_reg_11_","p2_ir_reg_12_",
        "p2_ir_reg_13_","p2_ir_reg_14_","p2_ir_reg_15_","p2_ir_reg_16_","p2_ir_reg_17_","p2_ir_reg_18_","p2_ir_reg_19_","p2_ir_reg_20_","p2_ir_reg_21_","p2_ir_reg_22_",
        "p2_ir_reg_23_","p2_ir_reg_24_","p2_ir_reg_25_","p2_ir_reg_26_","p2_ir_reg_27_","p2_ir_reg_28_","p2_ir_reg_29_","p2_ir_reg_30_","p2_ir_reg_31_","p2_d_reg_0_",
        "p2_d_reg_1_","p2_d_reg_2_","p2_d_reg_3_","p2_d_reg_4_","p2_d_reg_5_","p2_d_reg_6_","p2_d_reg_7_","p2_d_reg_8_","p2_d_reg_9_","p2_d_reg_10_",
        "p2_d_reg_11_","p2_d_reg_12_","p2_d_reg_13_","p2_d_reg_14_","p2_d_reg_15_","p2_d_reg_16_","p2_d_reg_17_","p2_d_reg_18_","p2_d_reg_19_","p2_d_reg_20_",
        "p2_d_reg_21_","p2_d_reg_22_","p2_d_reg_23_","p2_d_reg_24_","p2_d_reg_25_","p2_d_reg_26_","p2_d_reg_27_","p2_d_reg_28_","p2_d_reg_29_","p2_d_reg_30_",
        "p2_d_reg_31_","p2_reg0_reg_0_","p2_reg0_reg_1_","p2_reg0_reg_2_","p2_reg0_reg_3_","p2_reg0_reg_4_","p2_reg0_reg_5_","p2_reg0_reg_6_","p2_reg0_reg_7_","p2_reg0_reg_8_",
        "p2_reg0_reg_9_","p2_reg0_reg_10_","p2_reg0_reg_11_","p2_reg0_reg_12_","p2_reg0_reg_13_","p2_reg0_reg_14_","p2_reg0_reg_15_","p2_reg0_reg_16_","p2_reg0_reg_17_","p2_reg0_reg_18_",
        "p2_reg0_reg_19_","p2_reg0_reg_20_","p2_reg0_reg_21_","p2_reg0_reg_22_","p2_reg0_reg_23_","p2_reg0_reg_24_","p2_reg0_reg_25_","p2_reg0_reg_26_","p2_reg0_reg_27_","p2_reg0_reg_28_",
        "p2_reg0_reg_29_","p2_reg0_reg_30_","p2_reg0_reg_31_","p2_reg1_reg_0_","p2_reg1_reg_1_","p2_reg1_reg_2_","p2_reg1_reg_3_","p2_reg1_reg_4_","p2_reg1_reg_5_","p2_reg1_reg_6_",
        "p2_reg1_reg_7_","p2_reg1_reg_8_","p2_reg1_reg_9_","p2_reg1_reg_10_","p2_reg1_reg_11_","p2_reg1_reg_12_","p2_reg1_reg_13_","p2_reg1_reg_14_","p2_reg1_reg_15_","p2_reg1_reg_16_",
        "p2_reg1_reg_17_","p2_reg1_reg_18_","p2_reg1_reg_19_","p2_reg1_reg_20_","p2_reg1_reg_21_","p2_reg1_reg_22_","p2_reg1_reg_23_","p2_reg1_reg_24_","p2_reg1_reg_25_","p2_reg1_reg_26_",
        "p2_reg1_reg_27_","p2_reg1_reg_28_","p2_reg1_reg_29_","p2_reg1_reg_30_","p2_reg1_reg_31_","p2_reg2_reg_0_","p2_reg2_reg_1_","p2_reg2_reg_2_","p2_reg2_reg_3_","p2_reg2_reg_4_",
        "p2_reg2_reg_5_","p2_reg2_reg_6_","p2_reg2_reg_7_","p2_reg2_reg_8_","p2_reg2_reg_9_","p2_reg2_reg_10_","p2_reg2_reg_11_","p2_reg2_reg_12_","p2_reg2_reg_13_","p2_reg2_reg_14_",
        "p2_reg2_reg_15_","p2_reg2_reg_16_","p2_reg2_reg_17_","p2_reg2_reg_18_","p2_reg2_reg_19_","p2_reg2_reg_20_","p2_reg2_reg_21_","p2_reg2_reg_22_","p2_reg2_reg_23_","p2_reg2_reg_24_",
        "p2_reg2_reg_25_","p2_reg2_reg_26_","p2_reg2_reg_27_","p2_reg2_reg_28_","p2_reg2_reg_29_","p2_reg2_reg_30_","p2_reg2_reg_31_","p2_addr_reg_19_","p2_addr_reg_18_","p2_addr_reg_17_",
        "p2_addr_reg_16_","p2_addr_reg_15_","p2_addr_reg_14_","p2_addr_reg_13_","p2_addr_reg_12_","p2_addr_reg_11_","p2_addr_reg_10_","p2_addr_reg_9_","p2_addr_reg_8_","p2_addr_reg_7_",
        "p2_addr_reg_6_","p2_addr_reg_5_","p2_addr_reg_4_","p2_addr_reg_3_","p2_addr_reg_2_","p2_addr_reg_1_","p2_addr_reg_0_","p2_datao_reg_0_","p2_datao_reg_1_","p2_datao_reg_2_",
        "p2_datao_reg_3_","p2_datao_reg_4_","p2_datao_reg_5_","p2_datao_reg_6_","p2_datao_reg_7_","p2_datao_reg_8_","p2_datao_reg_9_","p2_datao_reg_10_","p2_datao_reg_11_","p2_datao_reg_12_",
        "p2_datao_reg_13_","p2_datao_reg_14_","p2_datao_reg_15_","p2_datao_reg_16_","p2_datao_reg_17_","p2_datao_reg_18_","p2_datao_reg_19_","p2_datao_reg_20_","p2_datao_reg_21_","p2_datao_reg_22_",
        "p2_datao_reg_23_","p2_datao_reg_24_","p2_datao_reg_25_","p2_datao_reg_26_","p2_datao_reg_27_","p2_datao_reg_28_","p2_datao_reg_29_","p2_datao_reg_30_","p2_datao_reg_31_","p2_b_reg",
        "p2_reg3_reg_15_","p2_reg3_reg_26_","p2_reg3_reg_6_","p2_reg3_reg_18_","p2_reg3_reg_2_","p2_reg3_reg_11_","p2_reg3_reg_22_","p2_reg3_reg_13_","p2_reg3_reg_20_","p2_reg3_reg_0_",
        "p2_reg3_reg_9_","p2_reg3_reg_4_","p2_reg3_reg_24_","p2_reg3_reg_17_","p2_reg3_reg_5_","p2_reg3_reg_16_","p2_reg3_reg_25_","p2_reg3_reg_12_","p2_reg3_reg_21_","p2_reg3_reg_1_",
        "p2_reg3_reg_8_","p2_reg3_reg_28_","p2_reg3_reg_19_","p2_reg3_reg_3_","p2_reg3_reg_10_","p2_reg3_reg_23_","p2_reg3_reg_14_","p2_reg3_reg_27_","p2_reg3_reg_7_","p2_state_reg",
        "p2_rd_reg","p2_wr_reg");
@output_port = ("add_1068_u4","add_1068_u55","add_1068_u56","add_1068_u57","add_1068_u58","add_1068_u59","add_1068_u60","add_1068_u61","add_1068_u62","add_1068_u63",
        "add_1068_u47","add_1068_u48","add_1068_u49","add_1068_u50","add_1068_u51","add_1068_u52","add_1068_u53","add_1068_u54","add_1068_u5","add_1068_u46",
        "u126","u123","p1_u3355","p1_u3354","p1_u3353","p1_u3352","p1_u3351","p1_u3350","p1_u3349","p1_u3348",
        "p1_u3347","p1_u3346","p1_u3345","p1_u3344","p1_u3343","p1_u3342","p1_u3341","p1_u3340","p1_u3339","p1_u3338",
        "p1_u3337","p1_u3336","p1_u3335","p1_u3334","p1_u3333","p1_u3332","p1_u3331","p1_u3330","p1_u3329","p1_u3328",
        "p1_u3327","p1_u3326","p1_u3325","p1_u3324","p1_u3439","p1_u3440","p1_u3323","p1_u3322","p1_u3321","p1_u3320",
        "p1_u3319","p1_u3318","p1_u3317","p1_u3316","p1_u3315","p1_u3314","p1_u3313","p1_u3312","p1_u3311","p1_u3310",
        "p1_u3309","p1_u3308","p1_u3307","p1_u3306","p1_u3305","p1_u3304","p1_u3303","p1_u3302","p1_u3301","p1_u3300",
        "p1_u3299","p1_u3298","p1_u3297","p1_u3296","p1_u3295","p1_u3294","p1_u3453","p1_u3456","p1_u3459","p1_u3462",
        "p1_u3465","p1_u3468","p1_u3471","p1_u3474","p1_u3477","p1_u3480","p1_u3483","p1_u3486","p1_u3489","p1_u3492",
        "p1_u3495","p1_u3498","p1_u3501","p1_u3504","p1_u3507","p1_u3509","p1_u3510","p1_u3511","p1_u3512","p1_u3513",
        "p1_u3514","p1_u3515","p1_u3516","p1_u3517","p1_u3518","p1_u3519","p1_u3520","p1_u3521","p1_u3522","p1_u3523",
        "p1_u3524","p1_u3525","p1_u3526","p1_u3527","p1_u3528","p1_u3529","p1_u3530","p1_u3531","p1_u3532","p1_u3533",
        "p1_u3534","p1_u3535","p1_u3536","p1_u3537","p1_u3538","p1_u3539","p1_u3540","p1_u3541","p1_u3542","p1_u3543",
        "p1_u3544","p1_u3545","p1_u3546","p1_u3547","p1_u3548","p1_u3549","p1_u3550","p1_u3551","p1_u3552","p1_u3553",
        "p1_u3293","p1_u3292","p1_u3291","p1_u3290","p1_u3289","p1_u3288","p1_u3287","p1_u3286","p1_u3285","p1_u3284",
        "p1_u3283","p1_u3282","p1_u3281","p1_u3280","p1_u3279","p1_u3278","p1_u3277","p1_u3276","p1_u3275","p1_u3274",
        "p1_u3273","p1_u3272","p1_u3271","p1_u3270","p1_u3269","p1_u3268","p1_u3267","p1_u3266","p1_u3265","p1_u3356",
        "p1_u3264","p1_u3263","p1_u3262","p1_u3261","p1_u3260","p1_u3259","p1_u3258","p1_u3257","p1_u3256","p1_u3255",
        "p1_u3254","p1_u3253","p1_u3252","p1_u3251","p1_u3250","p1_u3249","p1_u3248","p1_u3247","p1_u3246","p1_u3245",
        "p1_u3244","p1_u3243","p1_u3554","p1_u3555","p1_u3556","p1_u3557","p1_u3558","p1_u3559","p1_u3560","p1_u3561",
        "p1_u3562","p1_u3563","p1_u3564","p1_u3565","p1_u3566","p1_u3567","p1_u3568","p1_u3569","p1_u3570","p1_u3571",
        "p1_u3572","p1_u3573","p1_u3574","p1_u3575","p1_u3576","p1_u3577","p1_u3578","p1_u3579","p1_u3580","p1_u3581",
        "p1_u3582","p1_u3583","p1_u3584","p1_u3585","p1_u3242","p1_u3241","p1_u3240","p1_u3239","p1_u3238","p1_u3237",
        "p1_u3236","p1_u3235","p1_u3234","p1_u3233","p1_u3232","p1_u3231","p1_u3230","p1_u3229","p1_u3228","p1_u3227",
        "p1_u3226","p1_u3225","p1_u3224","p1_u3223","p1_u3222","p1_u3221","p1_u3220","p1_u3219","p1_u3218","p1_u3217",
        "p1_u3216","p1_u3215","p1_u3214","p1_u3213","p1_u3086","p1_u3085","p1_u3973","p2_u3295","p2_u3294","p2_u3293",
        "p2_u3292","p2_u3291","p2_u3290","p2_u3289","p2_u3288","p2_u3287","p2_u3286","p2_u3285","p2_u3284","p2_u3283",
        "p2_u3282","p2_u3281","p2_u3280","p2_u3279","p2_u3278","p2_u3277","p2_u3276","p2_u3275","p2_u3274","p2_u3273",
        "p2_u3272","p2_u3271","p2_u3270","p2_u3269","p2_u3268","p2_u3267","p2_u3266","p2_u3265","p2_u3264","p2_u3376",
        "p2_u3377","p2_u3263","p2_u3262","p2_u3261","p2_u3260","p2_u3259","p2_u3258","p2_u3257","p2_u3256","p2_u3255",
        "p2_u3254","p2_u3253","p2_u3252","p2_u3251","p2_u3250","p2_u3249","p2_u3248","p2_u3247","p2_u3246","p2_u3245",
        "p2_u3244","p2_u3243","p2_u3242","p2_u3241","p2_u3240","p2_u3239","p2_u3238","p2_u3237","p2_u3236","p2_u3235",
        "p2_u3234","p2_u3390","p2_u3393","p2_u3396","p2_u3399","p2_u3402","p2_u3405","p2_u3408","p2_u3411","p2_u3414",
        "p2_u3417","p2_u3420","p2_u3423","p2_u3426","p2_u3429","p2_u3432","p2_u3435","p2_u3438","p2_u3441","p2_u3444",
        "p2_u3446","p2_u3447","p2_u3448","p2_u3449","p2_u3450","p2_u3451","p2_u3452","p2_u3453","p2_u3454","p2_u3455",
        "p2_u3456","p2_u3457","p2_u3458","p2_u3459","p2_u3460","p2_u3461","p2_u3462","p2_u3463","p2_u3464","p2_u3465",
        "p2_u3466","p2_u3467","p2_u3468","p2_u3469","p2_u3470","p2_u3471","p2_u3472","p2_u3473","p2_u3474","p2_u3475",
        "p2_u3476","p2_u3477","p2_u3478","p2_u3479","p2_u3480","p2_u3481","p2_u3482","p2_u3483","p2_u3484","p2_u3485",
        "p2_u3486","p2_u3487","p2_u3488","p2_u3489","p2_u3490","p2_u3233","p2_u3232","p2_u3231","p2_u3230","p2_u3229",
        "p2_u3228","p2_u3227","p2_u3226","p2_u3225","p2_u3224","p2_u3223","p2_u3222","p2_u3221","p2_u3220","p2_u3219",
        "p2_u3218","p2_u3217","p2_u3216","p2_u3215","p2_u3214","p2_u3213","p2_u3212","p2_u3211","p2_u3210","p2_u3209",
        "p2_u3208","p2_u3207","p2_u3206","p2_u3205","p2_u3204","p2_u3203","p2_u3202","p2_u3201","p2_u3200","p2_u3199",
        "p2_u3198","p2_u3197","p2_u3196","p2_u3195","p2_u3194","p2_u3193","p2_u3192","p2_u3191","p2_u3190","p2_u3189",
        "p2_u3188","p2_u3187","p2_u3186","p2_u3185","p2_u3184","p2_u3183","p2_u3182","p2_u3491","p2_u3492","p2_u3493",
        "p2_u3494","p2_u3495","p2_u3496","p2_u3497","p2_u3498","p2_u3499","p2_u3500","p2_u3501","p2_u3502","p2_u3503",
        "p2_u3504","p2_u3505","p2_u3506","p2_u3507","p2_u3508","p2_u3509","p2_u3510","p2_u3511","p2_u3512","p2_u3513",
        "p2_u3514","p2_u3515","p2_u3516","p2_u3517","p2_u3518","p2_u3519","p2_u3520","p2_u3521","p2_u3522","p2_u3296",
        "p2_u3181","p2_u3180","p2_u3179","p2_u3178","p2_u3177","p2_u3176","p2_u3175","p2_u3174","p2_u3173","p2_u3172",
        "p2_u3171","p2_u3170","p2_u3169","p2_u3168","p2_u3167","p2_u3166","p2_u3165","p2_u3164","p2_u3163","p2_u3162",
        "p2_u3161","p2_u3160","p2_u3159","p2_u3158","p2_u3157","p2_u3156","p2_u3155","p2_u3154","p2_u3153","p2_u3151",
        "p2_u3150","p2_u3893");  
}
elsif($benchmark_name eq "b21_ras"){
  $num_input = 522;
  $num_output = 512;
  $benchmark_name = "b21_ras";
  $Frequency  = "50";
  $NUM_IV     = "2";
@input_port = ("si_31_","si_30_","si_29_","si_28_","si_27_","si_26_","si_25_","si_24_","si_23_","si_22_",
        "si_21_","si_20_","si_19_","si_18_","si_17_","si_16_","si_15_","si_14_","si_13_","si_12_",
        "si_11_","si_10_","si_9_","si_8_","si_7_","si_6_","si_5_","si_4_","si_3_","si_2_",
        "si_1_","si_0_","p1_ir_reg_0_","p1_ir_reg_1_","p1_ir_reg_2_","p1_ir_reg_3_","p1_ir_reg_4_","p1_ir_reg_5_","p1_ir_reg_6_","p1_ir_reg_7_",
        "p1_ir_reg_8_","p1_ir_reg_9_","p1_ir_reg_10_","p1_ir_reg_11_","p1_ir_reg_12_","p1_ir_reg_13_","p1_ir_reg_14_","p1_ir_reg_15_","p1_ir_reg_16_","p1_ir_reg_17_",
        "p1_ir_reg_18_","p1_ir_reg_19_","p1_ir_reg_20_","p1_ir_reg_21_","p1_ir_reg_22_","p1_ir_reg_23_","p1_ir_reg_24_","p1_ir_reg_25_","p1_ir_reg_26_","p1_ir_reg_27_",
        "p1_ir_reg_28_","p1_ir_reg_29_","p1_ir_reg_30_","p1_ir_reg_31_","p1_d_reg_0_","p1_d_reg_1_","p1_d_reg_2_","p1_d_reg_3_","p1_d_reg_4_","p1_d_reg_5_",
        "p1_d_reg_6_","p1_d_reg_7_","p1_d_reg_8_","p1_d_reg_9_","p1_d_reg_10_","p1_d_reg_11_","p1_d_reg_12_","p1_d_reg_13_","p1_d_reg_14_","p1_d_reg_15_",
        "p1_d_reg_16_","p1_d_reg_17_","p1_d_reg_18_","p1_d_reg_19_","p1_d_reg_20_","p1_d_reg_21_","p1_d_reg_22_","p1_d_reg_23_","p1_d_reg_24_","p1_d_reg_25_",
        "p1_d_reg_26_","p1_d_reg_27_","p1_d_reg_28_","p1_d_reg_29_","p1_d_reg_30_","p1_d_reg_31_","p1_reg0_reg_0_","p1_reg0_reg_1_","p1_reg0_reg_2_","p1_reg0_reg_3_",
        "p1_reg0_reg_4_","p1_reg0_reg_5_","p1_reg0_reg_6_","p1_reg0_reg_7_","p1_reg0_reg_8_","p1_reg0_reg_9_","p1_reg0_reg_10_","p1_reg0_reg_11_","p1_reg0_reg_12_","p1_reg0_reg_13_",
        "p1_reg0_reg_14_","p1_reg0_reg_15_","p1_reg0_reg_16_","p1_reg0_reg_17_","p1_reg0_reg_18_","p1_reg0_reg_19_","p1_reg0_reg_20_","p1_reg0_reg_21_","p1_reg0_reg_22_","p1_reg0_reg_23_",
        "p1_reg0_reg_24_","p1_reg0_reg_25_","p1_reg0_reg_26_","p1_reg0_reg_27_","p1_reg0_reg_28_","p1_reg0_reg_29_","p1_reg0_reg_30_","p1_reg0_reg_31_","p1_reg1_reg_0_","p1_reg1_reg_1_",
        "p1_reg1_reg_2_","p1_reg1_reg_3_","p1_reg1_reg_4_","p1_reg1_reg_5_","p1_reg1_reg_6_","p1_reg1_reg_7_","p1_reg1_reg_8_","p1_reg1_reg_9_","p1_reg1_reg_10_","p1_reg1_reg_11_",
        "p1_reg1_reg_12_","p1_reg1_reg_13_","p1_reg1_reg_14_","p1_reg1_reg_15_","p1_reg1_reg_16_","p1_reg1_reg_17_","p1_reg1_reg_18_","p1_reg1_reg_19_","p1_reg1_reg_20_","p1_reg1_reg_21_",
        "p1_reg1_reg_22_","p1_reg1_reg_23_","p1_reg1_reg_24_","p1_reg1_reg_25_","p1_reg1_reg_26_","p1_reg1_reg_27_","p1_reg1_reg_28_","p1_reg1_reg_29_","p1_reg1_reg_30_","p1_reg1_reg_31_",
        "p1_reg2_reg_0_","p1_reg2_reg_1_","p1_reg2_reg_2_","p1_reg2_reg_3_","p1_reg2_reg_4_","p1_reg2_reg_5_","p1_reg2_reg_6_","p1_reg2_reg_7_","p1_reg2_reg_8_","p1_reg2_reg_9_",
        "p1_reg2_reg_10_","p1_reg2_reg_11_","p1_reg2_reg_12_","p1_reg2_reg_13_","p1_reg2_reg_14_","p1_reg2_reg_15_","p1_reg2_reg_16_","p1_reg2_reg_17_","p1_reg2_reg_18_","p1_reg2_reg_19_",
        "p1_reg2_reg_20_","p1_reg2_reg_21_","p1_reg2_reg_22_","p1_reg2_reg_23_","p1_reg2_reg_24_","p1_reg2_reg_25_","p1_reg2_reg_26_","p1_reg2_reg_27_","p1_reg2_reg_28_","p1_reg2_reg_29_",
        "p1_reg2_reg_30_","p1_reg2_reg_31_","p1_addr_reg_19_","p1_addr_reg_18_","p1_addr_reg_17_","p1_addr_reg_16_","p1_addr_reg_15_","p1_addr_reg_14_","p1_addr_reg_13_","p1_addr_reg_12_",
        "p1_addr_reg_11_","p1_addr_reg_10_","p1_addr_reg_9_","p1_addr_reg_8_","p1_addr_reg_7_","p1_addr_reg_6_","p1_addr_reg_5_","p1_addr_reg_4_","p1_addr_reg_3_","p1_addr_reg_2_",
        "p1_addr_reg_1_","p1_addr_reg_0_","p1_datao_reg_0_","p1_datao_reg_1_","p1_datao_reg_2_","p1_datao_reg_3_","p1_datao_reg_4_","p1_datao_reg_5_","p1_datao_reg_6_","p1_datao_reg_7_",
        "p1_datao_reg_8_","p1_datao_reg_9_","p1_datao_reg_10_","p1_datao_reg_11_","p1_datao_reg_12_","p1_datao_reg_13_","p1_datao_reg_14_","p1_datao_reg_15_","p1_datao_reg_16_","p1_datao_reg_17_",
        "p1_datao_reg_18_","p1_datao_reg_19_","p1_datao_reg_20_","p1_datao_reg_21_","p1_datao_reg_22_","p1_datao_reg_23_","p1_datao_reg_24_","p1_datao_reg_25_","p1_datao_reg_26_","p1_datao_reg_27_",
        "p1_datao_reg_28_","p1_datao_reg_29_","p1_datao_reg_30_","p1_datao_reg_31_","p1_b_reg","p1_reg3_reg_15_","p1_reg3_reg_26_","p1_reg3_reg_6_","p1_reg3_reg_18_","p1_reg3_reg_2_",
        "p1_reg3_reg_11_","p1_reg3_reg_22_","p1_reg3_reg_13_","p1_reg3_reg_20_","p1_reg3_reg_0_","p1_reg3_reg_9_","p1_reg3_reg_4_","p1_reg3_reg_24_","p1_reg3_reg_17_","p1_reg3_reg_5_",
        "p1_reg3_reg_16_","p1_reg3_reg_25_","p1_reg3_reg_12_","p1_reg3_reg_21_","p1_reg3_reg_1_","p1_reg3_reg_8_","p1_reg3_reg_28_","p1_reg3_reg_19_","p1_reg3_reg_3_","p1_reg3_reg_10_",
        "p1_reg3_reg_23_","p1_reg3_reg_14_","p1_reg3_reg_27_","p1_reg3_reg_7_","p1_state_reg","p1_rd_reg","p1_wr_reg","p2_ir_reg_0_","p2_ir_reg_1_","p2_ir_reg_2_",
        "p2_ir_reg_3_","p2_ir_reg_4_","p2_ir_reg_5_","p2_ir_reg_6_","p2_ir_reg_7_","p2_ir_reg_8_","p2_ir_reg_9_","p2_ir_reg_10_","p2_ir_reg_11_","p2_ir_reg_12_",
        "p2_ir_reg_13_","p2_ir_reg_14_","p2_ir_reg_15_","p2_ir_reg_16_","p2_ir_reg_17_","p2_ir_reg_18_","p2_ir_reg_19_","p2_ir_reg_20_","p2_ir_reg_21_","p2_ir_reg_22_",
        "p2_ir_reg_23_","p2_ir_reg_24_","p2_ir_reg_25_","p2_ir_reg_26_","p2_ir_reg_27_","p2_ir_reg_28_","p2_ir_reg_29_","p2_ir_reg_30_","p2_ir_reg_31_","p2_d_reg_0_",
        "p2_d_reg_1_","p2_d_reg_2_","p2_d_reg_3_","p2_d_reg_4_","p2_d_reg_5_","p2_d_reg_6_","p2_d_reg_7_","p2_d_reg_8_","p2_d_reg_9_","p2_d_reg_10_",
        "p2_d_reg_11_","p2_d_reg_12_","p2_d_reg_13_","p2_d_reg_14_","p2_d_reg_15_","p2_d_reg_16_","p2_d_reg_17_","p2_d_reg_18_","p2_d_reg_19_","p2_d_reg_20_",
        "p2_d_reg_21_","p2_d_reg_22_","p2_d_reg_23_","p2_d_reg_24_","p2_d_reg_25_","p2_d_reg_26_","p2_d_reg_27_","p2_d_reg_28_","p2_d_reg_29_","p2_d_reg_30_",
        "p2_d_reg_31_","p2_reg0_reg_0_","p2_reg0_reg_1_","p2_reg0_reg_2_","p2_reg0_reg_3_","p2_reg0_reg_4_","p2_reg0_reg_5_","p2_reg0_reg_6_","p2_reg0_reg_7_","p2_reg0_reg_8_",
        "p2_reg0_reg_9_","p2_reg0_reg_10_","p2_reg0_reg_11_","p2_reg0_reg_12_","p2_reg0_reg_13_","p2_reg0_reg_14_","p2_reg0_reg_15_","p2_reg0_reg_16_","p2_reg0_reg_17_","p2_reg0_reg_18_",
        "p2_reg0_reg_19_","p2_reg0_reg_20_","p2_reg0_reg_21_","p2_reg0_reg_22_","p2_reg0_reg_23_","p2_reg0_reg_24_","p2_reg0_reg_25_","p2_reg0_reg_26_","p2_reg0_reg_27_","p2_reg0_reg_28_",
        "p2_reg0_reg_29_","p2_reg0_reg_30_","p2_reg0_reg_31_","p2_reg1_reg_0_","p2_reg1_reg_1_","p2_reg1_reg_2_","p2_reg1_reg_3_","p2_reg1_reg_4_","p2_reg1_reg_5_","p2_reg1_reg_6_",
        "p2_reg1_reg_7_","p2_reg1_reg_8_","p2_reg1_reg_9_","p2_reg1_reg_10_","p2_reg1_reg_11_","p2_reg1_reg_12_","p2_reg1_reg_13_","p2_reg1_reg_14_","p2_reg1_reg_15_","p2_reg1_reg_16_",
        "p2_reg1_reg_17_","p2_reg1_reg_18_","p2_reg1_reg_19_","p2_reg1_reg_20_","p2_reg1_reg_21_","p2_reg1_reg_22_","p2_reg1_reg_23_","p2_reg1_reg_24_","p2_reg1_reg_25_","p2_reg1_reg_26_",
        "p2_reg1_reg_27_","p2_reg1_reg_28_","p2_reg1_reg_29_","p2_reg1_reg_30_","p2_reg1_reg_31_","p2_reg2_reg_0_","p2_reg2_reg_1_","p2_reg2_reg_2_","p2_reg2_reg_3_","p2_reg2_reg_4_",
        "p2_reg2_reg_5_","p2_reg2_reg_6_","p2_reg2_reg_7_","p2_reg2_reg_8_","p2_reg2_reg_9_","p2_reg2_reg_10_","p2_reg2_reg_11_","p2_reg2_reg_12_","p2_reg2_reg_13_","p2_reg2_reg_14_",
        "p2_reg2_reg_15_","p2_reg2_reg_16_","p2_reg2_reg_17_","p2_reg2_reg_18_","p2_reg2_reg_19_","p2_reg2_reg_20_","p2_reg2_reg_21_","p2_reg2_reg_22_","p2_reg2_reg_23_","p2_reg2_reg_24_",
        "p2_reg2_reg_25_","p2_reg2_reg_26_","p2_reg2_reg_27_","p2_reg2_reg_28_","p2_reg2_reg_29_","p2_reg2_reg_30_","p2_reg2_reg_31_","p2_addr_reg_19_","p2_addr_reg_18_","p2_addr_reg_17_",
        "p2_addr_reg_16_","p2_addr_reg_15_","p2_addr_reg_14_","p2_addr_reg_13_","p2_addr_reg_12_","p2_addr_reg_11_","p2_addr_reg_10_","p2_addr_reg_9_","p2_addr_reg_8_","p2_addr_reg_7_",
        "p2_addr_reg_6_","p2_addr_reg_5_","p2_addr_reg_4_","p2_addr_reg_3_","p2_addr_reg_2_","p2_addr_reg_1_","p2_addr_reg_0_","p2_datao_reg_0_","p2_datao_reg_1_","p2_datao_reg_2_",
        "p2_datao_reg_3_","p2_datao_reg_4_","p2_datao_reg_5_","p2_datao_reg_6_","p2_datao_reg_7_","p2_datao_reg_8_","p2_datao_reg_9_","p2_datao_reg_10_","p2_datao_reg_11_","p2_datao_reg_12_",
        "p2_datao_reg_13_","p2_datao_reg_14_","p2_datao_reg_15_","p2_datao_reg_16_","p2_datao_reg_17_","p2_datao_reg_18_","p2_datao_reg_19_","p2_datao_reg_20_","p2_datao_reg_21_","p2_datao_reg_22_",
        "p2_datao_reg_23_","p2_datao_reg_24_","p2_datao_reg_25_","p2_datao_reg_26_","p2_datao_reg_27_","p2_datao_reg_28_","p2_datao_reg_29_","p2_datao_reg_30_","p2_datao_reg_31_","p2_b_reg",
        "p2_reg3_reg_15_","p2_reg3_reg_26_","p2_reg3_reg_6_","p2_reg3_reg_18_","p2_reg3_reg_2_","p2_reg3_reg_11_","p2_reg3_reg_22_","p2_reg3_reg_13_","p2_reg3_reg_20_","p2_reg3_reg_0_",
        "p2_reg3_reg_9_","p2_reg3_reg_4_","p2_reg3_reg_24_","p2_reg3_reg_17_","p2_reg3_reg_5_","p2_reg3_reg_16_","p2_reg3_reg_25_","p2_reg3_reg_12_","p2_reg3_reg_21_","p2_reg3_reg_1_",
        "p2_reg3_reg_8_","p2_reg3_reg_28_","p2_reg3_reg_19_","p2_reg3_reg_3_","p2_reg3_reg_10_","p2_reg3_reg_23_","p2_reg3_reg_14_","p2_reg3_reg_27_","p2_reg3_reg_7_","p2_state_reg",
        "p2_rd_reg","p2_wr_reg");
@output_port = ("add_1071_u4","add_1071_u55","add_1071_u56","add_1071_u57","add_1071_u58","add_1071_u59","add_1071_u60","add_1071_u61","add_1071_u62","add_1071_u63",
        "add_1071_u47","add_1071_u48","add_1071_u49","add_1071_u50","add_1071_u51","add_1071_u52","add_1071_u53","add_1071_u54","add_1071_u5","add_1071_u46",
        "u126","u123","p1_u3353","p1_u3352","p1_u3351","p1_u3350","p1_u3349","p1_u3348","p1_u3347","p1_u3346",
        "p1_u3345","p1_u3344","p1_u3343","p1_u3342","p1_u3341","p1_u3340","p1_u3339","p1_u3338","p1_u3337","p1_u3336",
        "p1_u3335","p1_u3334","p1_u3333","p1_u3332","p1_u3331","p1_u3330","p1_u3329","p1_u3328","p1_u3327","p1_u3326",
        "p1_u3325","p1_u3324","p1_u3323","p1_u3322","p1_u3440","p1_u3441","p1_u3321","p1_u3320","p1_u3319","p1_u3318",
        "p1_u3317","p1_u3316","p1_u3315","p1_u3314","p1_u3313","p1_u3312","p1_u3311","p1_u3310","p1_u3309","p1_u3308",
        "p1_u3307","p1_u3306","p1_u3305","p1_u3304","p1_u3303","p1_u3302","p1_u3301","p1_u3300","p1_u3299","p1_u3298",
        "p1_u3297","p1_u3296","p1_u3295","p1_u3294","p1_u3293","p1_u3292","p1_u3454","p1_u3457","p1_u3460","p1_u3463",
        "p1_u3466","p1_u3469","p1_u3472","p1_u3475","p1_u3478","p1_u3481","p1_u3484","p1_u3487","p1_u3490","p1_u3493",
        "p1_u3496","p1_u3499","p1_u3502","p1_u3505","p1_u3508","p1_u3510","p1_u3511","p1_u3512","p1_u3513","p1_u3514",
        "p1_u3515","p1_u3516","p1_u3517","p1_u3518","p1_u3519","p1_u3520","p1_u3521","p1_u3522","p1_u3523","p1_u3524",
        "p1_u3525","p1_u3526","p1_u3527","p1_u3528","p1_u3529","p1_u3530","p1_u3531","p1_u3532","p1_u3533","p1_u3534",
        "p1_u3535","p1_u3536","p1_u3537","p1_u3538","p1_u3539","p1_u3540","p1_u3541","p1_u3542","p1_u3543","p1_u3544",
        "p1_u3545","p1_u3546","p1_u3547","p1_u3548","p1_u3549","p1_u3550","p1_u3551","p1_u3552","p1_u3553","p1_u3554",
        "p1_u3291","p1_u3290","p1_u3289","p1_u3288","p1_u3287","p1_u3286","p1_u3285","p1_u3284","p1_u3283","p1_u3282",
        "p1_u3281","p1_u3280","p1_u3279","p1_u3278","p1_u3277","p1_u3276","p1_u3275","p1_u3274","p1_u3273","p1_u3272",
        "p1_u3271","p1_u3270","p1_u3269","p1_u3268","p1_u3267","p1_u3266","p1_u3265","p1_u3264","p1_u3263","p1_u3355",
        "p1_u3262","p1_u3261","p1_u3260","p1_u3259","p1_u3258","p1_u3257","p1_u3256","p1_u3255","p1_u3254","p1_u3253",
        "p1_u3252","p1_u3251","p1_u3250","p1_u3249","p1_u3248","p1_u3247","p1_u3246","p1_u3245","p1_u3244","p1_u3243",
        "p1_u3242","p1_u3241","p1_u3555","p1_u3556","p1_u3557","p1_u3558","p1_u3559","p1_u3560","p1_u3561","p1_u3562",
        "p1_u3563","p1_u3564","p1_u3565","p1_u3566","p1_u3567","p1_u3568","p1_u3569","p1_u3570","p1_u3571","p1_u3572",
        "p1_u3573","p1_u3574","p1_u3575","p1_u3576","p1_u3577","p1_u3578","p1_u3579","p1_u3580","p1_u3581","p1_u3582",
        "p1_u3583","p1_u3584","p1_u3585","p1_u3586","p1_u3240","p1_u3239","p1_u3238","p1_u3237","p1_u3236","p1_u3235",
        "p1_u3234","p1_u3233","p1_u3232","p1_u3231","p1_u3230","p1_u3229","p1_u3228","p1_u3227","p1_u3226","p1_u3225",
        "p1_u3224","p1_u3223","p1_u3222","p1_u3221","p1_u3220","p1_u3219","p1_u3218","p1_u3217","p1_u3216","p1_u3215",
        "p1_u3214","p1_u3213","p1_u3212","p1_u3211","p1_u3084","p1_u3083","p1_u4006","p2_u3358","p2_u3357","p2_u3356",
        "p2_u3355","p2_u3354","p2_u3353","p2_u3352","p2_u3351","p2_u3350","p2_u3349","p2_u3348","p2_u3347","p2_u3346",
        "p2_u3345","p2_u3344","p2_u3343","p2_u3342","p2_u3341","p2_u3340","p2_u3339","p2_u3338","p2_u3337","p2_u3336",
        "p2_u3335","p2_u3334","p2_u3333","p2_u3332","p2_u3331","p2_u3330","p2_u3329","p2_u3328","p2_u3327","p2_u3437",
        "p2_u3438","p2_u3326","p2_u3325","p2_u3324","p2_u3323","p2_u3322","p2_u3321","p2_u3320","p2_u3319","p2_u3318",
        "p2_u3317","p2_u3316","p2_u3315","p2_u3314","p2_u3313","p2_u3312","p2_u3311","p2_u3310","p2_u3309","p2_u3308",
        "p2_u3307","p2_u3306","p2_u3305","p2_u3304","p2_u3303","p2_u3302","p2_u3301","p2_u3300","p2_u3299","p2_u3298",
        "p2_u3297","p2_u3451","p2_u3454","p2_u3457","p2_u3460","p2_u3463","p2_u3466","p2_u3469","p2_u3472","p2_u3475",
        "p2_u3478","p2_u3481","p2_u3484","p2_u3487","p2_u3490","p2_u3493","p2_u3496","p2_u3499","p2_u3502","p2_u3505",
        "p2_u3507","p2_u3508","p2_u3509","p2_u3510","p2_u3511","p2_u3512","p2_u3513","p2_u3514","p2_u3515","p2_u3516",
        "p2_u3517","p2_u3518","p2_u3519","p2_u3520","p2_u3521","p2_u3522","p2_u3523","p2_u3524","p2_u3525","p2_u3526",
        "p2_u3527","p2_u3528","p2_u3529","p2_u3530","p2_u3531","p2_u3532","p2_u3533","p2_u3534","p2_u3535","p2_u3536",
        "p2_u3537","p2_u3538","p2_u3539","p2_u3540","p2_u3541","p2_u3542","p2_u3543","p2_u3544","p2_u3545","p2_u3546",
        "p2_u3547","p2_u3548","p2_u3549","p2_u3550","p2_u3551","p2_u3296","p2_u3295","p2_u3294","p2_u3293","p2_u3292",
        "p2_u3291","p2_u3290","p2_u3289","p2_u3288","p2_u3287","p2_u3286","p2_u3285","p2_u3284","p2_u3283","p2_u3282",
        "p2_u3281","p2_u3280","p2_u3279","p2_u3278","p2_u3277","p2_u3276","p2_u3275","p2_u3274","p2_u3273","p2_u3272",
        "p2_u3271","p2_u3270","p2_u3269","p2_u3268","p2_u3267","p2_u3266","p2_u3265","p2_u3264","p2_u3263","p2_u3262",
        "p2_u3261","p2_u3260","p2_u3259","p2_u3258","p2_u3257","p2_u3256","p2_u3255","p2_u3254","p2_u3253","p2_u3252",
        "p2_u3251","p2_u3250","p2_u3249","p2_u3248","p2_u3247","p2_u3246","p2_u3245","p2_u3552","p2_u3553","p2_u3554",
        "p2_u3555","p2_u3556","p2_u3557","p2_u3558","p2_u3559","p2_u3560","p2_u3561","p2_u3562","p2_u3563","p2_u3564",
        "p2_u3565","p2_u3566","p2_u3567","p2_u3568","p2_u3569","p2_u3570","p2_u3571","p2_u3572","p2_u3573","p2_u3574",
        "p2_u3575","p2_u3576","p2_u3577","p2_u3578","p2_u3579","p2_u3580","p2_u3581","p2_u3582","p2_u3583","p2_u3244",
        "p2_u3243","p2_u3242","p2_u3241","p2_u3240","p2_u3239","p2_u3238","p2_u3237","p2_u3236","p2_u3235","p2_u3234",
        "p2_u3233","p2_u3232","p2_u3231","p2_u3230","p2_u3229","p2_u3228","p2_u3227","p2_u3226","p2_u3225","p2_u3224",
        "p2_u3223","p2_u3222","p2_u3221","p2_u3220","p2_u3219","p2_u3218","p2_u3217","p2_u3216","p2_u3215","p2_u3152",
        "p2_u3151","p2_u3966");
}
# print "./main $benchmark_name $NUM_CORE $env $task_graph $policy $Frequency $NUM_IV $num_input @input_port $num_output @output_port\n";
print "============================ $benchmark_name, $policy============================\n";
system("date");
system("./main $benchmark_name $NUM_CORE $env $task_graph $policy $Frequency $NUM_IV $num_input @input_port $num_output @output_port");
system("date");

exit(0);
