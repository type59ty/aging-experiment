* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 20:16:38 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND3 in1 in2 in3 out1 vvdd vgnd  
MM1 out1 in1 vvdd vvdd pmos l=32 w=128 
MM2 out1 in2 vvdd vvdd pmos l=32 w=128 
MM3 out1 in3 vvdd vvdd pmos l=32 w=128 
MM9 out1 in1 N_1 vgnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 vgnd nmos l=32nm w=64nm 
MM11 N_2 in3 vgnd vgnd nmos l=32nm w=64nm 
.ends NAND3

