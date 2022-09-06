reset;
# Problem 1a,

# Parameters 
# number of Projects
param n;  
param cost {1..n};
param value {1..n};

param budget;

# Variables 

var Invest {1..n} >=0, <=1;


# Objective functions

maximize TotalValue: sum{i in 1..n} value[i] * Invest[i];

# Constraints

s.t. Budget: sum {i in 1..n} cost[i] * Invest[i] <= budget;


data;

param n := 3;

param cost := 
	1	3
	2	5
	3	7;
	
	
param value:= 
	1	7
	2	8
	3	10;
	

param budget:= 10;

solve;








