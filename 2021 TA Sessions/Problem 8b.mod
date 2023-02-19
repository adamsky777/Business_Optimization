reset;

set FACTORY;
set MARKET;

param d {MARKET};				# market demand
param cap {FACTORY};			# fatory capacity
param c {FACTORY, MARKET};		# variable costs
param fc {FACTORY};				# factory fixed costs

var X {FACTORY, MARKET} >= 0;	# quantity shipped from factory f to market m
var Z {FACTORY} binary;			# 1 - if factory f is opened, 0 - otherwise

minimize Costs:
	    sum{f in FACTORY, m in MARKET} c[f,m]*X[f,m] 
	  + sum{f in FACTORY} fc[f]*Z[f];

s.t. Constraint1_Demand {m in MARKET}:
	sum{f in FACTORY} X[f,m] = d[m];

s.t. Constraint2_Capacity {f in FACTORY}:
	sum{m in MARKET} X[f,m] <= cap[f]*Z[f];
	

data;

set FACTORY :=
Bratislava
Lvov
Krakow
Sibiu
Kharkiv
Pleven
Nizhniy;

set MARKET :=
A
B
C
D
E
F
G
H
I
J
K
L;


param d :=
A 200
B 150
C 225
D 120
E 155
F 180
G 170
H 230
I 230
J 190
K 265
L 300;

param cap :=
Bratislava 370
Lvov 200
Krakow 300
Sibiu 670
Kharkiv 750
Pleven 450
Nizhniy 300;

param c:
	A	B	C	D	E	F	G	H	I	J	K	L=
Bratislava	52	49	49	39	28	30	22	20	27	14	16	18
Lvov	48	37	38	27	24	28	24	14	29	13	29	25
Krakow	34	21	20	29	21	20	28	11	15	14	20	13
Sibiu	30	15	20	14	12	22	13	20	10	27	11	20
Kharkiv	27	15	15	29	23	11	21	13	29	47	20	47
Pleven	16	19	21	20	21	19	25	13	37	47	55	59
Nizhniy	19	30	19	10	11	25	28	30	47	50	66	63;

param fc :=
Bratislava 16
Lvov 13
Krakow 20
Sibiu 12
Kharkiv 18
Pleven 15
Nizhniy 17;

option solver gurobi;
solve;
display X;
display Z;

