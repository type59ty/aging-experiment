* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sun Feb 19 20:05:56 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR3 in1 in2 in3 out1 vvdd vgnd 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vvdd pmos l=32nm w=64nm 
MM3 N_1 in3 N_6 vvdd pmos l=32nm w=64nm 
MM17 out1 N_1 vvdd vvdd pmos l=32nm w=128nm 
MM9 N_1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 N_1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM11 N_1 in3 vgnd vgnd nmos l=32nm w=64nm 
MM18 out1 N_1 vgnd vgnd nmos l=32nm w=64nm 
.ends OR3

