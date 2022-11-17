reset; 

# Sets
set CROPS;
set MONTH; 
#Parameters
param hectar_land; 						#The hecters of land 
param allocated_land{MONTH, CROPS};		# Calender of land occupation

param water_price; 						#Price of water for the year 
param monthly_limit_water;				# The monthly limit of water 
param year_limit_water; 				# Annual limit on water 
param water_req {MONTH, CROPS}; 		# crop water requirements m^3/hectare

param family_wage; 						#Cost of one person/year 
param family_labor;						# Availibale family labor person/year 
param temp_hourly_wage; 				# cash per hour
param permYr_Wage;						# outside permanent yearly wage (cash/year per person) 
param labor_req {MONTH, CROPS};			#Crop labor requirements (hour/hectar) and montly hours (hour/person)
param monthly_hour{MONTH};

param yield {CROPS};					#Anticipated yield for each crop 
param price {CROPS};					#cash/ton, price for the six crops

#Decistion variabel 

#Labor:
var TempHire {MONTH} >= 0;  			#Number of temporary workers to hire in a month 
var PermHire >= 0;						# Number of permanent workers to hire

#Land: 
var Area_used {CROPS} >= 0;				#The number of hectars used for crop c in month m 


#Objective 
maximize Total_Profit:
		sum {c in CROPS} Area_used[c] * yield[c] * price[c]
		- sum {m in MONTH,c in CROPS} Area_used[c] * water_req[m,c] * water_price
		- sum {m in MONTH} TempHire[m]*temp_hourly_wage
		- (family_wage *family_labor) - (PermHire * permYr_Wage);

# Constrains:
# Land
s.t. land_limit {m in MONTH}:
 	sum {c in CROPS} Area_used[c] * allocated_land[m,c]<= hectar_land;
	

#Labor 
s.t. labor_limit{m in MONTH}:
	sum {c in CROPS} labor_req[m,c] * Area_used[c] <= TempHire[m] + (PermHire * monthly_hour[m]) + (family_labor * monthly_hour[m]);           


#Water
s.t. AreaRestrictWater{m in MONTH}:
	sum {c in CROPS} Area_used[c]* water_req[m,c] <= monthly_limit_water;

s.t. AreaRestrictWaterYR:
	sum {m in MONTH,c in CROPS} Area_used[c]* water_req[m,c] <= year_limit_water;


#The dataset
data; 
set CROPS :=	beans cotton	maize	onions	tomatoes	wheat;
set MONTH :=	Jan	Feb	Mar	Apr	Mai	Jun	Jul	Aug	Sep Oct	Nov	Dec;


param hectar_land := 10;
param water_price := 0.01;
param monthly_limit_water := 5000;
param year_limit_water := 50000;
 
param family_wage := 4144; 
param family_labor := 1.5;
param temp_hourly_wage := 4;
param permYr_Wage := 5180;

param allocated_land:
			beans	cotton	maize	onions	tomatoes	wheat:=
		Jan		1		0		0		1		0			1
		Feb		1		0		0		1		0			1
		Mar		1		0.5		0		1		0			1
		Apr		1		1		0		1		0			1
		Mai		0		1		0.25	0.25	0			1
		Jun		0		1		1		0		0			0	
		Jul		0		1		1		0		0.75		0
		Aug		0		1		1		0		1			0
		Sep		0		1		1		0		1			0
		Oct		0		1		0.5		0		1			0
		Nov		0.25	0.75	0		0.5		0.75		0.5
		Dec		1		0		0		1		0			1; 
		
param water_req:
				beans	cotton	maize	onions	tomatoes	wheat:=
		Jan		438		0		0		452		0			535
		Feb		479		0		0		507		0			802
		Mar		505		197		0		640		0			556
		Apr		142		494		0		453		0			59
		Mai		0		1047	303		0		0			0
		Jun		0		1064	893		0		0			0	
		Jul		0		1236	1318	0		120			0
		Aug		0		722		953		0		241			0
		Sep		0		89		205		0		525			0
		Oct		0		0		0		0		881			0
		Nov		272		0		0		0		865			373
		Dec		335		0		0		305		0			456; 
	
param labor_req: 
				beans	cotton	maize	onions	tomatoes	wheat:=
		Jan		6		0		0		41		0			14
		Feb		6		0		0		40		0			4
		Mar		6		40		0		40		0			8
		Apr		128		40		0		155		0			8
		Mai		0		72		34		19		0			137
		Jun		0		16		40		0		0			0	
		Jul		0		12		57		0		136			0
		Aug		0		16		64		0		120			0
		Sep		0		8		35		0		96			0
		Oct		0		46		9		0		56			0
		Nov		60		34		0		89		48			19
		Dec		6		0		0		37		0			11;
		
param monthly_hour:=
		Jan	160
		Feb	160
		Mar	184
		Apr	176
		Mai	168
		Jun	176
		Jul	176
		Aug	176
		Sep	176
		Oct	168
		Nov	176
		Dec	176; 

param yield:=
		beans		1.00
		cotton		1.50
		maize		1.75
		onions		6.00
		tomatoes	6.00
		wheat		1.50;


param price:=
		beans		2000	
		cotton		3500
		maize		700
		onions		750
		tomatoes	800
		wheat		1000;
		
option solver gurobi;
solve;
display Total_Profit, TempHire, PermHire, Area_used;


		
