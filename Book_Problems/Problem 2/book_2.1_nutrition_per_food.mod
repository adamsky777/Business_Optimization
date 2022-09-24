reset;

set NUTRITIONS;
set PRODUCTS;

param required {NUTRITIONS} >=0;
param cost {PRODUCTS} >= 0;

param nutrition_per_product {NUTRITIONS, PRODUCTS} >=0;


var Buy {p in PRODUCTS} >= 0;

minimize total_cost: sum{p in PRODUCTS} cost[p] * Buy[p];


# NB:  to get to sum of each calories that we buy we need to get the sum of (products we buy * calorie inhold respectively)

subj req_nutrition {n in NUTRITIONS}: sum{p in PRODUCTS} Buy[p] * nutrition_per_product[n, p] >=  required[n];



data;

set NUTRITIONS := calories protein calcium vitaminA;

set PRODUCTS := bread meat potatoes cabbage milk gelatin;


param required :=
	calories 	3000
	protein		70
	calcium		800
	vitaminA	500;
	
	
param cost :=
	bread 		0.30
	meat		1
	potatoes	0.05
	cabbage		0.08
	milk		0.23
	gelatin		0.48;			
	
	

param nutrition_per_product: 	bread	meat	potatoes	cabbage 	milk	gelatin=
					calories	1254	1457	318			46			309		1725
					protein		39		73		8			4			16		43
					calcium		418		41		42			141			536		0
					vitaminA	0		0		70			860			720		0;


solve;

display total_cost, {p in PRODUCTS} Buy[p];