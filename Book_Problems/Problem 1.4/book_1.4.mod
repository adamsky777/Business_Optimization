reset;
set PRODUCTS;


param time {PRODUCTS};
param profit {PRODUCTS};
param orders {PRODUCTS};
param hours_available >= 0;

var X{PRODUCTS} >= 0;

maximize Total_profit: 
	sum{p in PRODUCTS} profit[p] * X[p];

subj to prod_time: sum{p in PRODUCTS} X[p] * time[p] <= hours_available;

subj to demand_q {p in PRODUCTS}: X[p] >= orders[p];


data;

set PRODUCTS := 
	Tesla
	Chevy
	Lexus;
	
param orders :=
	 	Tesla 	10
		Chevy 	20
		Lexus 	15;
	
param time := 
	Tesla 	1
	Chevy	2
	Lexus	3;
	
	
param profit := 
	Tesla 	200
	Chevy 	500
	Lexus 	700;

param hours_available :=
	120;

solve;
display Total_profit, X;
	