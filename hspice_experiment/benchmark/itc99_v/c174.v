// Verilog
// c174
// Ninputs 20
// Noutputs 8
// NtotalGates 24
// NAND2 24

module c174 (P1_N1,P1_N2,P1_N3,P1_N6,P1_N7,P1_N22,P1_N23,
             P2_N1,P2_N2,P2_N3,P2_N6,P2_N7,P2_N22,P2_N23,
             P3_N1,P3_N2,P3_N3,P3_N6,P3_N7,P3_N22,P3_N23,
             P4_N1,P4_N2,P4_N3,P4_N6,P4_N7,P4_N22,P4_N23
);
input P1_N1,P1_N2,P1_N3,P1_N6,P1_N7,P2_N1,P2_N2,P2_N3,P2_N6,P2_N7,P3_N1,P3_N2,P3_N3,P3_N6,P3_N7,P4_N1,P4_N2,P4_N3,P4_N6,P4_N7;

output P1_N22,P1_N23,P2_N22,P2_N23,P3_N22,P3_N23,P4_N22,P4_N23;

wire P1_N10;
wire P1_N11;
wire P1_N16;
wire P1_N19;
wire P1_N22;
wire P1_N23;

wire P2_N10;
wire P2_N11;
wire P2_N16;
wire P2_N19;
wire P2_N22;
wire P2_N23;

wire P3_N10;
wire P3_N11;
wire P3_N16;
wire P3_N19;
wire P3_N22;
wire P3_N23;

wire P4_N10;
wire P4_N11;
wire P4_N16;
wire P4_N19;
wire P4_N22;
wire P4_N23;

nand NAND2_1  (P1_N10, P1_N1,  P1_N3);
nand NAND2_2  (P1_N11, P1_N3,  P1_N6);
nand NAND2_3  (P1_N16, P1_N2,  P1_N11);
nand NAND2_4  (P1_N19, P1_N11, P1_N7);
nand NAND2_5  (P1_N22, P1_N10, P1_N16);
nand NAND2_6  (P1_N23, P1_N16, P1_N19);

nand NAND2_7  (P2_N10, P2_N1,  P2_N3);
nand NAND2_8  (P2_N11, P2_N3,  P2_N6);
nand NAND2_9  (P2_N16, P2_N2,  P2_N11);
nand NAND2_10 (P2_N19, P2_N11, P2_N7);
nand NAND2_11 (P2_N22, P2_N10, P2_N16);
nand NAND2_12 (P2_N23, P2_N16, P2_N19);

nand NAND2_13 (P3_N10, P3_N1,  P3_N3);
nand NAND2_14 (P3_N11, P3_N3,  P3_N6);
nand NAND2_15 (P3_N16, P3_N2,  P3_N11);
nand NAND2_16 (P3_N19, P3_N11, P3_N7);
nand NAND2_17 (P3_N22, P3_N10, P3_N16);
nand NAND2_18 (P3_N23, P3_N16, P3_N19);

nand NAND2_19 (P4_N10, P4_N1,  P4_N3);
nand NAND2_20 (P4_N11, P4_N3,  P4_N6);
nand NAND2_21 (P4_N16, P4_N2,  P4_N11);
nand NAND2_22 (P4_N19, P4_N11, P4_N7);
nand NAND2_23 (P4_N22, P4_N10, P4_N16);
nand NAND2_24 (P4_N23, P4_N16, P4_N19);

endmodule
