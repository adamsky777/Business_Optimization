# Limiting to 500 punds and 300 cubic feet.
reset;

set PRODUCTS;

param value {PRODUCTS};
param weight {PRODUCTS};
param volume {PRODUCTS};
param available {PRODUCTS};

param weight_limit >=0;
param volume_limit >=0;

var X{PRODUCTS} >= 0;

maximize total_profit:
	sum {p in PRODUCTS} X[p]* value[p];

subj to quantity_avail {p in PRODUCTS}: X[p]  <= available[p];

subj to total_weight: sum{p in PRODUCTS} X[p] * weight[p] <= weight_limit;

subj to total_volume: sum{p in PRODUCTS} X[p] * volume[p] <= volume_limit;




data;

set PRODUCTS :=
	TV
	radio
	camera
	CDplayer
	VCR
	camcorder;

param value :=
	TV			50
	radio		15
	camera		85
	CDplayer	40	
	VCR			50
	camcorder	120;
	
	
param weight :=
	TV			35
	radio		5
	camera		4
	CDplayer	3
	VCR			15
	camcorder	20;
	
	
param volume := 
	TV			8
	radio		1
	camera		2
	CDplayer	1
	VCR			5
	camcorder	4;
	
	
param available :=
	TV			20
	radio		50
	camera		20
	CDplayer	30
	VCR			30
	camcorder	15;
	
param weight_limit := 500;
	
param volume_limit := 300;
	
solve;
display {p in PRODUCTS} X[p], total_profit;




# Solution

# NB: with the current weight limit we are not exceeding our 300 cubic feet volume limitation.
# Thus, the bottleneck is weight limit. If we manage to extend out weight limit we can increase our profit without exceeding our volume limit.

#5 iterations, objective 4800
#X[p] [*] :=
# CDplayer  30
##      TV   0
#      VCR   2
#camcorder  15
#   camera  20
#    radio   0
#;

#total_profit = 4800




