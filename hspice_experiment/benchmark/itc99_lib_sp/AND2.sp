* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sun Feb 19 16:18:11 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND2 in1 in2 out1 vvdd vgnd  
MM1 N_8 in1 vvdd vvdd pmos l=32 w=128 
MM2 N_8 in2 vvdd vvdd pmos l=32 w=128 
MM19 out1 N_8 vvdd vvdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 vgnd nmos l=32nm w=64nm 
MM10 N_1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM20 out1 N_8 vgnd vgnd nmos l=32nm w=64nm 
.ends AND2

