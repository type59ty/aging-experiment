* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sun Feb 19 19:55:52 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR5
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR5 in1 in2 in3 in4 in5 out1 vvdd vgnd 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vvdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vvdd pmos l=32nm w=64nm 
MM4 N_4 in4 N_5 vvdd pmos l=32nm w=64nm 
MM5 N_3 in5 N_4 vvdd pmos l=32nm w=64nm 
MM17 out1 N_3 vvdd vvdd pmos l=32nm w=128nm 
MM9 N_3 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 N_3 in2 vgnd vgnd nmos l=32nm w=64nm 
MM11 N_3 in3 vgnd vgnd nmos l=32nm w=64nm 
MM12 N_3 in4 vgnd vgnd nmos l=32nm w=64nm 
MM13 N_3 in5 vgnd vgnd nmos l=32nm w=64nm 
MM18 out1 N_3 vgnd vgnd nmos l=32nm w=64nm 
.ends OR5

