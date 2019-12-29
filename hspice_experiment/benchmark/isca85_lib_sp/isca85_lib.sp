**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND2 out1 in1 in2 vdd gnd  
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM2 N_8 in2 vdd vdd pmos l=32nm w=128nm 
MM19 out1 N_8 vdd vdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 gnd gnd nmos l=32nm w=64nm 
MM20 out1 N_8 gnd gnd nmos l=32nm w=64nm 
.ends AND2

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND3 out1 in1 in2 in3 vdd gnd  
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM2 N_8 in2 vdd vdd pmos l=32nm w=128nm 
MM3 N_8 in3 vdd vdd pmos l=32nm w=128nm 
MM19 out1 N_8 vdd vdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 gnd gnd nmos l=32nm w=64nm 
MM20 out1 N_8 gnd gnd nmos l=32nm w=64nm 
.ends AND3

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND4
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND4 out1 in1 in2 in3 in4 vdd gnd  
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM2 N_8 in2 vdd vdd pmos l=32nm w=128nm 
MM3 N_8 in3 vdd vdd pmos l=32nm w=128nm 
MM4 N_8 in4 vdd vdd pmos l=32nm w=128nm 
MM19 out1 N_8 vdd vdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 gnd gnd nmos l=32nm w=64nm 
MM20 out1 N_8 gnd gnd nmos l=32nm w=64nm 
.ends AND4

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND5
* Library Path : /home/jainting/experiment_training/genHspiceNetlist/laker_adp/myisca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND5 out1 in1 in2 in3 in4 in5 vdd gnd  
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM2 N_8 in2 vdd vdd pmos l=32nm w=128nm 
MM3 N_8 in3 vdd vdd pmos l=32nm w=128nm 
MM4 N_8 in4 vdd vdd pmos l=32nm w=128nm 
MM5 N_8 in5 vdd vdd pmos l=32nm w=128nm 
MM19 out1 N_8 vdd vdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 gnd nmos l=32nm w=64nm 
MM13 N_4 in5 gnd gnd nmos l=32nm w=64nm 
MM20 out1 N_8 gnd gnd nmos l=32nm w=64nm 
.ends AND5

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND8
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND8 out1 in1 in2 in3 in4 in5 in6 in7 in8 vdd gnd  
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM2 N_8 in2 vdd vdd pmos l=32nm w=128nm 
MM3 N_8 in3 vdd vdd pmos l=32nm w=128nm 
MM4 N_8 in4 vdd vdd pmos l=32nm w=128nm 
MM5 N_8 in5 vdd vdd pmos l=32nm w=128nm 
MM6 N_8 in6 vdd vdd pmos l=32nm w=128nm 
MM7 N_8 in7 vdd vdd pmos l=32nm w=128nm 
MM8 N_8 in8 vdd vdd pmos l=32nm w=128nm 
MM19 out1 N_8 vdd vdd pmos l=32nm w=128nm 
MM9 N_8 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 gnd nmos l=32nm w=64nm 
MM13 N_4 in5 N_5 gnd nmos l=32nm w=64nm 
MM14 N_5 in6 N_6 gnd nmos l=32nm w=64nm 
MM15 N_6 in7 N_7 gnd nmos l=32nm w=64nm 
MM16 N_7 in8 gnd gnd nmos l=32nm w=64nm 
MM20 out1 N_8 gnd gnd nmos l=32nm w=64nm 
.ends AND8

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : AND9
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt AND9 out1 in1 in2 in3 in4 in5 in6 in7 in8 in9 vdd gnd   
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM2 N_8 in2 vdd vdd pmos l=32nm w=128nm 
MM3 N_8 in3 vdd vdd pmos l=32nm w=128nm 
MM4 N_8 in4 vdd vdd pmos l=32nm w=128nm 
MM5 N_8 in5 vdd vdd pmos l=32nm w=128nm
MM6 N_8 in6 vdd vdd pmos l=32nm w=128nm 
MM17 N_8 in9 vdd vdd pmos l=32nm w=128nm 
MM7 N_8 in7 vdd vdd pmos l=32nm w=128nm 
MM8 N_8 in8 vdd vdd pmos l=32nm w=128nm 
MM19 out1 N_8 vdd vdd pmos l=32nm w=128nm 
MM18 N_10 in9 gnd gnd nmos l=32nm w=64nm 
MM9 N_8 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 gnd nmos l=32nm w=64nm 
MM13 N_4 in5 N_5 gnd nmos l=32nm w=64nm 
MM14 N_5 in6 N_6 gnd nmos l=32nm w=64nm 
MM15 N_6 in7 N_7 gnd nmos l=32nm w=64nm 
MM16 N_7 in8 N_10 gnd nmos l=32nm w=64nm 
MM20 out1 N_8 gnd gnd nmos l=32nm w=64nm 
.ends AND9

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR2 out1 in1 in2 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 N_1 in2 N_7 vdd pmos l=32nm w=64nm 
MM17 out1 N_1 vdd vdd pmos l=32nm w=128nm 
MM9 N_1 in1 gnd gnd nmos l=32nm w=64nm 
MM10 N_1 in2 gnd gnd nmos l=32nm w=64nm 
MM18 out1 N_1 gnd gnd nmos l=32nm w=64nm 
.ends OR2

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR3 out1 in1 in2 in3 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vdd pmos l=32nm w=64nm 
MM3 N_1 in3 N_6 vdd pmos l=32nm w=64nm 
MM17 out1 N_1 vdd vdd pmos l=32nm w=128nm 
MM9 N_1 in1 gnd gnd nmos l=32nm w=64nm 
MM10 N_1 in2 gnd gnd nmos l=32nm w=64nm 
MM11 N_1 in3 gnd gnd nmos l=32nm w=64nm 
MM18 out1 N_1 gnd gnd nmos l=32nm w=64nm 
.ends OR3

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR4
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR4 out1 in1 in2 in3 in4 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vdd pmos l=32nm w=64nm 
MM4 N_4 in4 N_5 vdd pmos l=32nm w=64nm 
MM17 out1 N_4 vdd vdd pmos l=32nm w=128nm 
MM9 N_4 in1 gnd gnd nmos l=32nm w=64nm 
MM10 N_4 in2 gnd gnd nmos l=32nm w=64nm 
MM11 N_4 in3 gnd gnd nmos l=32nm w=64nm 
MM12 N_4 in4 gnd gnd nmos l=32nm w=64nm 
MM18 out1 N_4 gnd gnd nmos l=32nm w=64nm 
.ends OR4

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : OR5
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt OR5 out1 in1 in2 in3 in4 in5 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vdd pmos l=32nm w=64nm 
MM4 N_4 in4 N_5 vdd pmos l=32nm w=64nm 
MM5 N_3 in5 N_4 vdd pmos l=32nm w=64nm 
MM17 out1 N_3 vdd vdd pmos l=32nm w=128nm 
MM9 N_3 in1 gnd gnd nmos l=32nm w=64nm 
MM10 N_3 in2 gnd gnd nmos l=32nm w=64nm 
MM11 N_3 in3 gnd gnd nmos l=32nm w=64nm 
MM12 N_3 in4 gnd gnd nmos l=32nm w=64nm 
MM13 N_3 in5 gnd gnd nmos l=32nm w=64nm 
MM18 out1 N_3 gnd gnd nmos l=32nm w=64nm 
.ends OR5

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND2 out1 in2 in1  vdd gnd 
MM1 out1 in1 N_1 gnd nmos l=32nm w=64nm 
MM2 N_1 in2 gnd gnd nmos l=32nm w=64nm 
MM3 out1 in1 vdd vdd pmos l=32nm w=128nm 
MM4 out1 in2 vdd vdd pmos l=32nm w=128nm 
.ends NAND2

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND3 out1 in1 in2 in3 vdd gnd  
MM1 out1 in1 vdd vdd pmos l=32nm w=128nm 
MM2 out1 in2 vdd vdd pmos l=32nm w=128nm 
MM3 out1 in3 vdd vdd pmos l=32nm w=128nm 
MM9 out1 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 gnd gnd nmos l=32nm w=64nm 
.ends NAND3

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND4
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND4 out1 in1 in2 in3 in4 vdd gnd  
MM1 out1 in1 vdd vdd pmos l=32nm w=128nm 
MM2 out1 in2 vdd vdd pmos l=32nm w=128nm 
MM3 out1 in3 vdd vdd pmos l=32nm w=128nm 
MM4 out1 in4 vdd vdd pmos l=32nm w=128nm 
MM9 out1 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 gnd gnd nmos l=32nm w=64nm 
.ends NAND4

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND5
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND5 out1 in1 in2 in3 in4 in5 vdd gnd  
MM1 out1 in1 vdd vdd pmos l=32nm w=128nm 
MM2 out1 in2 vdd vdd pmos l=32nm w=128nm 
MM3 out1 in3 vdd vdd pmos l=32nm w=128nm 
MM4 out1 in4 vdd vdd pmos l=32nm w=128nm 
MM5 out1 in5 vdd vdd pmos l=32nm w=128nm 
MM9 out1 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 gnd nmos l=32nm w=64nm 
MM13 N_4 in5 gnd gnd nmos l=32nm w=64nm 
.ends NAND5

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NAND8
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NAND8 out1 in1 in2 in3 in4 in5 in6 in7 in8 vdd gnd  
MM1 out1 in1 vdd vdd pmos l=32nm w=128nm 
MM2 out1 in2 vdd vdd pmos l=32nm w=128nm 
MM3 out1 in3 vdd vdd pmos l=32nm w=128nm 
MM4 out1 in4 vdd vdd pmos l=32nm w=128nm 
MM5 out1 in5 vdd vdd pmos l=32nm w=128nm 
MM6 out1 in6 vdd vdd pmos l=32nm w=128nm 
MM7 out1 in7 vdd vdd pmos l=32nm w=128nm 
MM8 out1 in8 vdd vdd pmos l=32nm w=128nm 
MM9 out1 in1 N_1 gnd nmos l=32nm w=64nm 
MM10 N_1 in2 N_2 gnd nmos l=32nm w=64nm 
MM11 N_2 in3 N_3 gnd nmos l=32nm w=64nm 
MM12 N_3 in4 N_4 gnd nmos l=32nm w=64nm 
MM13 N_4 in5 N_5 gnd nmos l=32nm w=64nm 
MM14 N_5 in6 N_6 gnd nmos l=32nm w=64nm 
MM15 N_6 in7 N_7 gnd nmos l=32nm w=64nm 
MM16 N_7 in8 gnd gnd nmos l=32nm w=64nm 
.ends NAND8

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR2
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR2 out1 in1 in2 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 out1 in2 N_7 vdd pmos l=32nm w=64nm 
MM9 out1 in1 gnd gnd nmos l=32nm w=64nm 
MM10 out1 in2 gnd gnd nmos l=32nm w=64nm 
.ends NOR2

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR3
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR3 out1 in1 in2 in3 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vdd pmos l=32nm w=64nm 
MM3 out1 in3 N_6 vdd pmos l=32nm w=64nm 
MM9 out1 in1 gnd gnd nmos l=32nm w=64nm 
MM10 out1 in2 gnd gnd nmos l=32nm w=64nm 
MM11 out1 in3 gnd gnd nmos l=32nm w=64nm 
.ends NOR3

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR4
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR4 out1 in1 in2 in3 in4 vdd gnd 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vdd pmos l=32nm w=64nm 
MM4 out1 in4 N_5 vdd pmos l=32nm w=64nm 
MM9 out1 in1 gnd gnd nmos l=32nm w=64nm 
MM10 out1 in2 gnd gnd nmos l=32nm w=64nm 
MM11 out1 in3 gnd gnd nmos l=32nm w=64nm 
MM12 out1 in4 gnd gnd nmos l=32nm w=64nm 
.ends NOR4

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOR8
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOR8 out1 in1 in2 in3 in4 in5 in6 in7 in8 vdd gnd 
MM8 out1 in8 N_1 vdd pmos l=32nm w=64nm 
MM6 N_2 in6 N_3 vdd pmos l=32nm w=64nm 
MM7 N_1 in7 N_2 vdd pmos l=32nm w=64nm 
MM5 N_3 in5 N_4 vdd pmos l=32nm w=64nm 
MM4 N_4 in4 N_5 vdd pmos l=32nm w=64nm 
MM3 N_5 in3 N_6 vdd pmos l=32nm w=64nm 
MM2 N_6 in2 N_7 vdd pmos l=32nm w=64nm 
MM1 N_7 in1 vdd vdd pmos l=32nm w=64nm 
MM9 out1 in1 gnd gnd nmos l=32nm w=64nm 
MM10 out1 in2 gnd gnd nmos l=32nm w=64nm 
MM11 out1 in3 gnd gnd nmos l=32nm w=64nm 
MM12 out1 in4 gnd gnd nmos l=32nm w=64nm 
MM13 out1 in5 gnd gnd nmos l=32nm w=64nm 
MM14 out1 in6 gnd gnd nmos l=32nm w=64nm 
MM16 out1 in8 gnd gnd nmos l=32nm w=64nm 
MM15 out1 in7 gnd gnd nmos l=32nm w=64nm 
.ends NOR8

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : NOT1
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt NOT1 out1 in1 vdd gnd 
MM1 out1 in1 vdd vdd pmos l=32nm w=128nm 
MM2 out1 in1 gnd gnd nmos l=32nm w=64nm 
.ends NOT1

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : BUFF1
* Library Path : /home/kunwei/experiment/genHspiceNetlist/laker_adp/isca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt BUFF1 out1 in1 vdd gnd 
MM1 N_1 in1 vdd vdd pmos l=32nm w=128nm 
MM3 out1 N_1 vdd vdd pmos l=32nm w=128nm 
MM2 N_1 in1 gnd gnd nmos l=32nm w=64nm 
MM4 out1 N_1 gnd gnd nmos l=32nm w=64nm 
.ends BUFF1

**************************************************
* Schematic Information
*-------------------------------------------------
* Cell Name    : XOR2
* Library Path : /home/jainting/experiment_training/genHspiceNetlist/laker_adp/myisca85ADP.lib++
* Top Cell     : YES
**************************************************
.subckt XOR2 out1 in1 in2 vdd gnd 
MM1 N_8 in1 vdd vdd pmos l=32nm w=128nm 
MM3 N_20 in2 vdd vdd pmos l=32nm w=128nm 
MM5 N_5 N_8 vdd vdd pmos l=32nm w=128nm 
MM6 out1 in2 N_5 vdd pmos l=32nm w=128nm 
MM7 N_3 N_20 vdd vdd pmos l=32nm w=128nm 
MM8 out1 in1 N_3 vdd pmos l=32nm w=128nm 
MM2 N_8 in1 gnd gnd nmos l=32nm w=64nm 
MM4 N_20 in2 gnd gnd nmos l=32nm w=64nm 
MM9 out1 in1 N_6 gnd nmos l=32nm w=64nm 
MM10 N_6 in2 gnd gnd nmos l=32nm w=64nm 
MM11 out1 N_8 N_4 gnd nmos l=32nm w=64nm 
MM12 N_4 N_20 gnd gnd nmos l=32nm w=64nm 
.ends XOR2