// Verilog
// c7
// Ninputs 8
// Noutputs 4
// NtotalGates 8
// NAND2 8

module c7 (N1,N2,N3,N4,N5,N6,N7,N8,N20,N21,N22,N23);

input N1,N2,N3,N4,N5,N6,N7,N8;

output N20,N21,N22,N23;

wire N9,N10,N11,N12;

nand NAND2_1 (N9 , N1 , N2 ); 
nand NAND2_2 (N10, N3 , N4 ); 
nand NAND2_3 (N11, N5 , N6 ); 
nand NAND2_4 (N12, N7 , N8 ); 
nand NAND2_5 (N20, N9 , N10); 
nand NAND2_6 (N21, N11, N12); 
nand NAND2_7 (N22, N9 , N11); 
nand NAND2_8 (N23, N10, N12); 
endmodule
