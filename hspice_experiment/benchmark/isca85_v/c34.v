// Verilog
// c174
// Ninputs 10
// Noutputs 4
// NtotalGates 12
// NAND2 12

module c34 (P1_N1,P1_N2,P1_N3,P1_N6,P1_N7,P1_N22,P1_N23,
             P2_N1,P2_N2,P2_N3,P2_N6,P2_N7,P2_N22,P2_N23
);
input P1_N1,P1_N2,P1_N3,P1_N6,P1_N7,P2_N1,P2_N2,P2_N3,P2_N6,P2_N7;
output P1_N22,P1_N23,P2_N22,P2_N23;

wire P1_N10,P1_N11,P1_N16,P1_N19,P2_N10,P2_N11,P2_N16,P2_N19;

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

endmodule
