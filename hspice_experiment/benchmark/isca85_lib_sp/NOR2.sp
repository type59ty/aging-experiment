* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 21:03:51 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR2 in1 in2 out1 vvdd vgnd 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM2 out1 in2 N_7 vvdd pmos l=32nm w=64nm 
MM9 out1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 out1 in2 vgnd vgnd nmos l=32nm w=64nm 
.ends NOR2

