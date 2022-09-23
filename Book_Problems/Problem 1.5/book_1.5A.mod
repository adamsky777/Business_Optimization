reset;

set PRODUCTS;

param value {PRODUCTS};
param weight {PRODUCTS};
param volume {PRODUCTS};
param available {PRODUCTS};

var X{PRODUCTS} >= 0;

maximize total_profit:
	sum {p in PRODUCTS} X[p]* value[p];

subj to quantity_avail {p in PRODUCTS}: X[p] <= available[p];



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
	
	
	
solve;
display {p in PRODUCTS} X[p], total_profit;



#Solution 
#X[p] [*] :=
# CDplayer  30
#      TV  20
#      VCR  30
#camcorder  15
 #  camera  20
 #  radio  50


#total_profit = 7950




