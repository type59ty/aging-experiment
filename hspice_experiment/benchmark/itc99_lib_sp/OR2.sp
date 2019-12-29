* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sun Feb 19 20:06:58 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR2 in1 in2 out1 vvdd vgnd 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM2 N_1 in2 N_7 vvdd pmos l=32nm w=64nm 
MM17 out1 N_1 vvdd vvdd pmos l=32nm w=128nm 
MM9 N_1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 N_1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM18 out1 N_1 vgnd vgnd nmos l=32nm w=64nm 
.ends OR2

