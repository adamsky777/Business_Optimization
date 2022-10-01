

	
reset;

#Sets

set PRODUCTS;
set MACHINES;
set MONTHS ordered; # ordered declears the order in months and it matters, and the way how the data is addded.


#Parameters
#Machine/Production Related
param machine_installed{MACHINES};
param time_req{MACHINES, PRODUCTS};
param machine_down{MACHINES, MONTHS};
param hours_cap;

#Inventory Related
param inventory_cap;
param inventory_target;
param holding_cost;

#Sales Related
param unit_profit{PRODUCTS};
param max_sales{MONTHS, PRODUCTS};

#Decision Variables
var unit_produced{MONTHS, PRODUCTS} >=0;
var unit_sold{MONTHS, PRODUCTS} >=0;
var ending_inventory{MONTHS, PRODUCTS} >=0;

#Model
maximize TotalProfit:
	sum{t in MONTHS, p in PRODUCTS} (unit_profit[p] * unit_sold[t,p] - holding_cost * ending_inventory[t,p]);

#Constraints
#Machine/Production Related
s.t. HoursCapacity {m in MACHINES, t in MONTHS}:
	sum{p in PRODUCTS} unit_produced[t,p] * time_req [m,p] <= hours_cap * (machine_installed[m] - machine_down[m,t]);
	
#Inventory Related
s.t. FirstMonthEndingInventory {p in PRODUCTS}:
	ending_inventory["Jan",p] = unit_produced["Jan",p] - unit_sold["Jan",p];

s.t. EndingInventoryAfterwards {p in PRODUCTS, t in MONTHS: ord(t)>1}: # ord indicates that  we start the second month

	ending_inventory[t,p] = ending_inventory[prev(t),p] + unit_produced[t,p] - unit_sold[t,p];
	
s.t. EndingInventoryAsTargeted {p in PRODUCTS}:
	ending_inventory["Jun",p] = inventory_target;
	
s.t. InventoryCapacity {t in MONTHS, p in PRODUCTS}:
	ending_inventory[t,p] <= inventory_cap;

#Sales Related
s.t. SalesCap {t in MONTHS, p in PRODUCTS}:
	unit_sold[t,p] <= max_sales[t,p];

#Data
data;

set MACHINES:=
	Grinder	Vertical_Drill	Horizontal_Drill	Borer	Planer;
	
set PRODUCTS:=
	P1	P2	P3	P4	P5	P6	P7;
	
set MONTHS:=
	Jan	Feb	Mar	Apr	May	Jun;
	
param machine_installed:=
	Grinder				4
	Vertical_Drill		2
	Horizontal_Drill	3
	Borer				1
	Planer				1;
	
param unit_profit:=
	P1	10	
	P2	6	
	P3	8
	P4	4
	P5	11
	P6	9
	P7	3;

param time_req:
						P1		P2		P3		P4		P5		P6		P7:=
	Grinder				0.5		0.7		0		0		0.3		0.2		0.5
	Vertical_Drill		0.1		0.2		0		0.3		0		0.6		0
	Horizontal_Drill	0.2		0		0.8		0		0		0		0.08
	Borer				0.05	0.03	0		0.07	0.1		0		0.08	
	Planer				0		0		0.01	0		0.05	0		0.05;

param machine_down:
						Jan	Feb	Mar	Apr	May	Jun:=
	Grinder				1	0	0	0	1	0
	Vertical_Drill		0	0	0	1	1	0
	Horizontal_Drill	0	2	0	0	0	1
	Borer				0	0	1	0	0	0
	Planer				0	0	0	0	0	1;
	
	
param max_sales:
		P1		P2		P3		P4		P5		P6		P7:=
	Jan	500		1000	300		300		800		200		100
	Feb	600		500		200		0		400		300		150
	Mar	300		600		0		0		500		400		100
	Apr	200		300		400		500		200		0		100
	May	0		100		500		100		1000	300		0
	Jun	500		500		100		300		1100	500		60;	
		
param inventory_cap:= 100;
param inventory_target:= 50;
param holding_cost:= 0.5;
param hours_cap:= 384;
	
solve;
display TotalProfit;
	
	
	
