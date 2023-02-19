reset;

param P;
param r {1..P};
param pm {1..P};
param d {1..P};
param cap;

var X {1..P} >= 0;

maximize Profit:
	sum {p in 1..P} pm[p]*r[p]*X[p];
	
s.t. Constraint1_Capacity:
	sum {p in  1..P} X[p] <= cap;

s.t. Constraint2_Demand {p in 1..P}:
	r[p]*X[p] <= d[p];
	
data;

param P := 2;

param r:= 1 200	2 140;

param pm:= 1 25	2 30;

param d:= 1 6000	2 4000;

param cap:= 40;


option solver gurobi;
solve;
display X;




