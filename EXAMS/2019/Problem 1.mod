reset;

set SITES;
set MARKET;

param location{SITES};


param demand{MARKET} >=0;

param prod_cap{SITES} >=0;

param vc{SITES, MARKET} >=0;



var Ship{SITES, MARKET} >=0;



minimize Total_Cost:
	sum{s in SITES, m in MARKET} vc[s,m] * Ship[s, m];


subj to production_capacity {s in SITES}:
	sum{m in MARKET} Ship[s,m] <= prod_cap[s];
	
subj to market_demand {m in MARKET}:
	sum{s in SITES} Ship[s,m] >= demand[m];
	



data;

set SITES :=
	Bratislava Lvov Krakow Sibiu Kharkiv Pleven Nizhny;

set MARKET :=
	A	B	C	D	E	F	G	H	I	J	K	L;
	
	
param demand :=																	
	A	200	
	B	150	
	C	225	
	D	120
	E	155
	F	180
	G	170
	H	230	
	I	230
	J	190	
	K	265
	L	300;
	
	
param prod_cap :=
	Bratislava		370
	Lvov 			200
	Krakow 			300
	Sibiu 			670
	Kharkiv 		750
	Pleven 			450
	Nizhny			300;		

param vc: 
					A		B		C		D		E		F		G		H		I		J		K		L :=
	Bratislava		52		49		49		39		28		30		22		20		27		14		16		18
	Lvov 			48		37		38		27		24		28		25		14		29		13		29		25
	Krakow 			34		21		20		29		21		20		28		11		15		14		20		13
	Sibiu 			30		15		20		14		12		22		13		20		10		27		11		20
	Kharkiv 		27		15		15		29		23		11		21		13		29		47		20		47
	Pleven 			16		19		21		20		21		19		25		13		37		47		55		59
	Nizhny			19		30		19		10		11		25		28		30		47		50		66		63;
	
	
	
	
	
solve;

display	Ship, Total_Cost; 

# : Bratislava Kharkiv Krakow  Lvov Nizhny Pleven Sibiu    :=
#A      0          0      0      0     0    200      0
#B      0        145      0      0     0      0      5
#C      0        225      0      0     0      0      0
#D      0          0      0      0   120      0      0
#E      0          0      0      0   155      0      0
#F      0        180      0      0     0      0      0
#G      0          0      0      0     0      0    170
#H      0        200      0      0     0     30      0
#I      0          0      0      0     0      0    230
#J      0          0      0    190     0      0      0
#K      0          0      0      0     0      0    265
#L      0          0    300      0     0      0      0

#Total_Cost = 30495












