# Suppose that it is desirable to acquire some of each item, so as to always have stock available
# for re-sale. Suppose in addition that there are upper bounds on how many of each item you can
# reasonably expect to sell. How would you add these conditions to the model?reset;

reset;

set PRODUCTS;

param value {PRODUCTS};
param weight {PRODUCTS};
param volume {PRODUCTS};
param available {PRODUCTS};
param desirable_stock {PRODUCTS}; # introduce a new parameter desirable stock

param weight_limit >=0;
param volume_limit >=0;

var X{PRODUCTS} >= 0;

maximize total_profit:
	sum {p in PRODUCTS} X[p]* value[p];

subj to quantity_avail {p in PRODUCTS}: X[p]  <= available[p];

subj to total_weight: sum{p in PRODUCTS} X[p] * weight[p] <= weight_limit;

subj to total_volume: sum{p in PRODUCTS} X[p] * volume[p] <= volume_limit;

subj to stock_required {p in PRODUCTS}: X[p] >= desirable_stock[p];



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
	
# lets assume for now we want to have 1 of each product on stock.
param desirable_stock := 
	TV			1
	radio		1
	camera		1
	CDplayer	1
	VCR			1
	camcorder	1;
	
param weight_limit := 500;
	
param volume_limit := 300;
	
solve;
display {p in PRODUCTS} X[p], total_profit;

# Solution 

# NB: if we want to have at least 1 item on stock of every item, our profit would decrease by $275.

# X[p] [*] :=
 #CDplayer  30
 #     TV   1
 #     VCR   1
#camcorder  13.75
 #  camera  20
  #  radio   1

# total_profit = 4665









