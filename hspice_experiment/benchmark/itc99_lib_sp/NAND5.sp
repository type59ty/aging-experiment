* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 20:08:34 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND5
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND5 in1 in2 in3 in4 in5 out1 vvdd vgnd  
MM1 out1 in1 vvdd vvdd pmos l=32 w=128 
MM2 out1 in2 vvdd vvdd pmos l=32 w=128 
MM3 out1 in3 vvdd vvdd pmos l=32 w=128 
MM4 out1 in4 vvdd vvdd pmos l=32 w=128 
MM5 out1 in5 vvdd vvdd pmos l=32 w=128 
MM9 out1 in1 N_1 vgnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 vgnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 vgnd nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 vgnd nmos l=32nm w=64nm 
MM13 N_4 in5 vgnd vgnd nmos l=32nm w=64nm 
.ends NAND5

