reset;

set ORIG; # Origins
set DEST; # Destinations


param supply{ORIG} >= 0;
param demand{DEST} >= 0;


# check stament says that she sum of the supplies has to equal the sum of the demands
#check: sum(i in ORIG} supply[i] = sum{j in DEST} DEMAND[j];


param cost{ORIG, DEST} >= 0;

var Trans{ORIG, DEST} >=0; # here we declare how many goods we should ship.


# objective function

minimize Total_Cost:
	sum{o in ORIG, d in DEST} cost[o,d] * Trans[o,d];
	

subj to Supply {o in ORIG}: 
	sum {d in DEST} Trans[o,d] = supply[o];


subj to Demand {d in DEST}: 
	sum{o in ORIG} Trans[o,d] = demand[d];
	

data;

set ORIG :=
	GARY	CLEV 	PITT;

set DEST :=
	FRA
	DET
	LAN
	WIN
	STL
	FRE
	LAF;

param supply :=
	GARY	1400	
	CLEV 	2600
	PITT	2900;
	
param demand :=
	FRA		900
	DET		1200
	LAN		600
	WIN		400	
	STL		1700
	FRE		1100
	LAF		1000;
	
	
	
param cost:
		FRA		DET		LAN		WIN		STL		FRE		LAF	:=
GARY	39		14		11		14		16		82		8
CLEV	27		9		12		9		26		95		17
PITT	24		14		17		13		28		99		20;



solve;
display Trans;



# SOLUTION

# TOTAL COST = 196200
#:     CLEV   GARY   PITT    :=
#DET   1200      0      0
#FRA      0      0    900
#FRE      0   1100      0
#LAF    400    300    300
#LAN    600      0      0
#STL      0      0   1700
#WIN    400      0      0















	
	
	
	
	
	
	