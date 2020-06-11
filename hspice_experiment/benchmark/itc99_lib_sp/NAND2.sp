* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 14:42:18 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND2 in2 in1 out1 vvdd vgnd 
MM1 out1 in1 N_1 vgnd nmos l=32nm w=64nm 
MM2 N_1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM3 out1 in1 vvdd vvdd pmos l=32nm w=128nm 
MM4 out1 in2 vvdd vvdd pmos l=32nm w=128nm 
.ends NAND2

