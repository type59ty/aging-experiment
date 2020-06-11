* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 20:53:15 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR4
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR4 in1 in2 in3 in4 out1 vvdd vgnd 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vvdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vvdd pmos l=32nm w=64nm 
MM4 out1 in4 N_5 vvdd pmos l=32nm w=64nm 
MM9 out1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 out1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM11 out1 in3 vgnd vgnd nmos l=32nm w=64nm 
MM12 out1 in4 vgnd vgnd nmos l=32nm w=64nm 
.ends NOR4

