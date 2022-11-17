reset;

set SITES;
set DISTRICTS;



param supply_calls {s in SITES}; # the amount of calls that the hospitals able to recieve.

param demand_calls {d in DISTRICTS}; # the amount of calls that coming from each districits.

param travel_time {s in SITES, d in DISTRICTS}; # the travel time between each districit and hospital.


var X {s in SITES, d in DISTRICTS} >=0;


minimize Avg_travel_time: sum{s in SITES, d in DISTRICTS} travel_time[s,d] * X[s,d];



subj to Cap_call {s in SITES}: sum{d in DISTRICTS} X[s,d] <= supply_calls[s];
subj to Demand_const {d in DISTRICTS}: sum {s in SITES} X[s,d] >= demand_calls[d];





data;


set SITES := 		hospital1	hospital2;	

set DISTRICTS:= 1	2	3	4	5	6	7	8	9	10 	11 	12;


param travel_time : 
			1	2	3	4	5	6	7	8	9	10 	11 	12 	:=
hospital1	5	6	7	5	6	7	9	10	11	7	8	9
hospital2	8	9	10	7	8	9	5	6	7	3	4	5;	 

						






param supply_calls := 
					hospital1 		4.9
					hospital2 		5.5;
	

	
		
param demand_calls :=

	1		0.5
	2		0.6
	3		0.4
	4		0.3
	5		0.4
	6		0.6
	7		0.7
	8		0.9
	9		1
	10		0.2
	11		0.6
	12		0.1;
	
	
option solver gurobi;

solve;
display Avg_travel_time,  X, Avg_travel_time / sum{d in DISTRICTS} demand_calls[d]; 












	
	
	