* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 20:48:27 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR8
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR8 in1 in2 in3 in4 in5 in6 in7 in8 out1 vvdd vgnd 
MM8 out1 in8 N_1 vvdd pmos l=32nm w=64nm 
MM6 N_2 in6 N_3 vvdd pmos l=32nm w=64nm 
MM7 N_1 in7 N_2 vvdd pmos l=32nm w=64nm 
MM5 N_3 in5 N_4 vvdd pmos l=32nm w=64nm 
MM4 N_4 in4 N_5 vvdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vvdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vvdd pmos l=32nm w=64nm 
MM1 N_7 in1 vvdd vvdd pmos l=32nm w=64nm 
MM9 out1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM10 out1 in2 vgnd vgnd nmos l=32nm w=64nm 
MM11 out1 in3 vgnd vgnd nmos l=32nm w=64nm 
MM12 out1 in4 vgnd vgnd nmos l=32nm w=64nm 
MM13 out1 in5 vgnd vgnd nmos l=32nm w=64nm 
MM14 out1 in6 vgnd vgnd nmos l=32nm w=64nm 
MM16 out1 in8 vgnd vgnd nmos l=32nm w=64nm 
MM15 out1 in7 vgnd vgnd nmos l=32nm w=64nm 
.ends NOR8

