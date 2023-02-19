reset;

set Vegetables;
set Fertilizer;

param y {Vegetables};
param cap {Fertilizer};
param l {Fertilizer, Vegetables};

var X {Vegetables} >= 0;

maximize Total_Vegetables_Weight:
	sum {v in Vegetables} y[v]*X[v];

s.t. Constraint1_Capacity {f in Fertilizer}:
	sum {v in Vegetables} l[f,v]*X[v] <= cap[f];
	
data;

set Vegetables := cucumber	onion;
set Fertilizer := 1	2	3;

param y:= 
cucumber 4	
onion 5;

param cap:= 
1 8	
2 7	
3 3;

param l:
	cucumber onion:=
1	2 1
2	1 2
3	0 1;

option solver gurobi;
solve;
display X;
