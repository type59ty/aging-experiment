* Spice-Out for hspice, Version: 2015.03, Linux x86_64/64bit, Sun Feb 19 15:38:26 2017





**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND5
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND5 in1 in2 in3 in4 in5 out1 vvdd vgnd  
MM1 N_8 in1 vvdd vvdd pmos l=32 w=128 
MM2 N_8 in2 vvdd vvdd pmos l=32 w=128 
MM3 N_8 in3 vvdd vvdd pmos l=32 w=128 
MM4 N_8 in4 vvdd vvdd pmos l=32 w=128 
MM5 N_8 in5 vvdd vvdd pmos l=32 w=128 
MM19 out1 N_8 vvdd vvdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 N_7 nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 N_7 nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 N_7 nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 N_7 nmos l=32nm w=64nm 
MM13 N_4 in5 vgnd N_7 nmos l=32nm w=64nm 
MM20 out1 N_8 vgnd vgnd nmos l=32nm w=64nm 
.ends AND5

