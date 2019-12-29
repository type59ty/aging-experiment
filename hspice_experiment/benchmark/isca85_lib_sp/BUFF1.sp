* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 21:17:17 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : BUFF1
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt BUFF1 in1 out1 vvdd vgnd 
MM1 N_1 in1 vvdd vvdd pmos l=32nm w=128nm 
MM3 out1 N_1 vvdd vvdd pmos l=32nm w=128nm 
MM2 N_1 in1 vgnd vgnd nmos l=32nm w=64nm 
MM4 out1 N_1 vgnd vgnd nmos l=32nm w=64nm 
.ends BUFF1

