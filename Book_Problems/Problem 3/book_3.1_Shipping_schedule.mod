reset;

set ORIGIN;
set DEST;


param supply{ORIGIN} >=0;

param demand{DEST} >=0;

param distance {ORIGIN, DEST} >=0;

param unit_cost_per_1000_miles >=0;

var Ship{ORIGIN, DEST} >=0;


minimize Total_Cost:
	sum{o in ORIGIN, d in DEST} (distance[o,d]* unit_cost_per_1000_miles) * Ship[o,d];


# here we iterate over each origin, sum up all the units that we have shipped must be less than the our supply for each origin.

subj to supply_const {o in ORIGIN}: 
	sum{d in DEST} Ship[o,d] <= supply[o];


subj to demand_const {d in DEST}:
	sum{o in ORIGIN} Ship[o,d] >= demand[d];
	


data;

set ORIGIN := 	
	Seattle 	San_Diego;

set DEST := 
	New_York 	Chicago 	Topeka;
	
	
	
param supply := 
	Seattle  	350
	San_Diego	600;
	
param demand :=
	New_York	325	
	Chicago		300
	Topeka		275;

param distance: 
				New_York	Chicago		Topeka :=
	Seattle		2500		1700		1800
	San_Diego	2500		1800		1400;
	
	
param unit_cost_per_1000_miles:= 0.09;


solve;

display Total_Cost, Ship;


# SOLUTION

# Total_Cost = 153675

# San_Diego Chicago      0
# San_Diego New_York   275
# San_Diego Topeka     275
# Seattle   Chicago    300
# Seattle   New_York    50
# Seattle   Topeka       0





