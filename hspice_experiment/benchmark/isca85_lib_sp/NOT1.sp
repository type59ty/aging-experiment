* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sat Feb 18 21:09:41 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOT1
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOT1 in1 out1 vvdd vgnd 
MM1 out1 in1 vvdd vvdd pmos l=32nm w=128nm 
MM2 out1 in1 vgnd vgnd nmos l=32nm w=64nm 
.ends NOT1

