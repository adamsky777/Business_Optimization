reset;
# Sets
set Month ordered; 


# Parameters
param demand_shoes{Month}; # The forecasted demand 

param monthly_wage; # Regular wages per month, per worker 
param overtime_wage_hourly; #the overtime wage per rate per hour 
param regular_hours; #per worker per month 
param max_overtime; #maximum overtime hours per worker per month


param hiring_cost; 
param firing_cost; 
param init_workers; #Initial number of workers
param init_inv; # Initial number of shoes  #BEGGINING INVENTORY
param hours_per_unit; #Hours per produced pair  (labor hour pair of shoes)
param Raw_material_cost; #raw material to produce shoes  # Production? per product 
param holding_cost; # Per pair of shos (inventory) 


# Decision variable 
var hiring_workers {Month} >= 0 integer; # The number of workers we need to hire each month
var firing_workers {Month} >= 0 integer; # The number of workers we need to fire each month.
var overtime_X {Month} >= 0;
var produce_X {Month} >= 0 integer; # Production of the shoes 
var store_X {Month} >= 0 integer; # storage of the shoes in the inventory
var total_labor{Month} >= 0 integer;


# Objective 
minimize Total_Cost:
	sum{m in Month} produce_X[m] * Raw_material_cost
	+ sum{m in Month} holding_cost * store_X [m] 
	+ sum{m in Month} hiring_workers[m] * hiring_cost
	+ sum{m in Month} firing_workers[m] * firing_cost
	+ sum{m in Month} overtime_X[m] * overtime_wage_hourly
	+ sum{m in Month} total_labor[m] * monthly_wage;




s.t. balance_labor:
	total_labor[1] = init_workers + hiring_workers[1] - firing_workers[1];

s.t. balance_labor_otherperiod {m in Month:ord(m)>1}:
	total_labor[m] = total_labor[m-1] + hiring_workers[m] - firing_workers[m];


s.t. hours_cap {m in Month}:
	overtime_X[m]+total_labor[m] * regular_hours >= produce_X[m] * hours_per_unit;
	
s.t. maximum_overtime{m in Month}:
	overtime_X[m] <= max_overtime * total_labor[m] ;
	
s.t. balance_firstperiod:
	store_X[1] = init_inv  + produce_X[1] - demand_shoes[1];

s.t. balance_Otherperiod {m in Month:ord(m)>1}:
	store_X[m] = store_X[m-1] + produce_X[m] - demand_shoes[m];
	



#The dataset: 
data; 

set Month:=	1	2	3	4; 

param demand_shoes:=
	1	3000
	2	5000
	3	2000
	4	1000; 

param monthly_wage := 1500;
param overtime_wage_hourly:= 13;
param regular_hours := 160; 
param max_overtime := 20;

param hiring_cost:= 1600;
param firing_cost := 2000; 
param init_workers := 100;
param init_inv := 500; 
param hours_per_unit := 4; 
param Raw_material_cost := 15; 
param holding_cost := 3; 

option solver gurobi;

solve;
display Total_Cost , produce_X, store_X, hiring_workers, firing_workers, overtime_X;

