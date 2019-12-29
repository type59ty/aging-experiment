* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Tue Feb 28 15:17:35 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : XOR2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt XOR2 in1 in2 out1 vvdd vgnd 
MM8 out1 N_2 N_3 vvdd pmos l=32nm w=128nm 
MM7 N_3 in1 vvdd vvdd pmos l=32nm w=128nm 
MM6 out1 in2 N_5 vvdd pmos l=32nm w=128nm 
MM5 N_5 N_1 vvdd vvdd pmos l=32nm w=128nm 
MM3 N_2 in2 N_7 vgnd pmos l=32nm w=128nm 
MM1 N_1 in1 vvdd vvdd pmos l=32nm w=128nm 
MM12 N_4 in2 vgnd vgnd nmos l=32nm w=64nm 
MM11 out1 in1 N_4 vgnd nmos l=32nm w=64nm 
MM10 N_6 N_2 vgnd vgnd nmos l=32nm w=64nm 
MM9 out1 N_1 N_6 vgnd nmos l=32nm w=64nm 
MM4 N_2 in2 vgnd vgnd nmos l=32nm w=64nm 
MM2 N_1 in1 N_7 vvdd nmos l=32nm w=64nm 
.ends XOR2

