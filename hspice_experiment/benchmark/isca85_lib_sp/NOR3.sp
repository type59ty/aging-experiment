* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 20:57:57 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR3 in1 in2 in3 out1 vvdd vgnd 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vvdd pmos l=32nm w=64nm 
MM3 out1 in3 N_6 vvdd pmos l=32nm w=64nm 
MM9 out1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 out1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM11 out1 in3 vgnd vgnd nmos l=32nm w=64nm 
.ends NOR3

