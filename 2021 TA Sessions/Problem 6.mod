reset;

set Months ordered;
set Products;
set Machines ordered;

param installed{Machines};
param profit{Products};
param timeReq{Products,Machines};
param hMonthCap;
param down{Machines,Months};
param maxSales{Products,Months};
param maxInv;
param invCost;
param invTarget;

var X{Months,Products} >= 0;
var S{Months,Products} >= 0;
var Inv{Months,Products} >= 0;
var Y{Months,Machines} >= 0 integer;

maximize TotalProfit:
			sum{t in Months,p in Products}(profit[p]*S[t,p] - invCost*Inv[t,p]);
			
s.t. InitialInventory {p in Products}:
			Inv["Jan",p] = X["Jan",p] - S["Jan",p] ;
			
s.t. Inventory {p in Products, t in Months: ord(t) > 1}:
			Inv[t,p] = Inv[prev(t),p] + X[t,p] - S[t,p] ;
			
s.t. InventoryTarget {p in Products}:
			Inv["Jun",p] = invTarget;

s.t. InvCapacity {t in Months,p in Products}:
			Inv[t,p] <= maxInv;
			
s.t. MaximumSale {t in Months,p in Products}:
			S[t,p] <= maxSales[p,t];
			
s.t. MachineCapacity {t in Months,m in Machines}:
			sum{p in Products}X[t,p]*timeReq[p,m] <= hMonthCap*(installed[m] - down[m,t]);


############### Modifications
/*
s.t. MachineCapacity {t in Months,m in Machines}:
			sum{p in Products}X[t,p]*timeReq[p,m] <= hMonthCap*(installed[m] - Y[t,m]);

s.t. MaintenenceRequirement{m in Machines diff {"Grinder"}}:
			sum{t in Months}Y[t,m] = installed[m];
s.t. MaintenenceRequirement2:
			sum{t in Months}Y[t,"Grinder"] = 2;
*/
###############			
data;

set Months := Jan Feb Mar Apr May Jun;
set Products := P1 P2 P3 P4 P5 P6 P7;
set Machines := Grinder VDrill HDrill Borer Planer;

param installed:= Grinder 4 VDrill 2 HDrill 3 Borer 1 Planer 1;
param profit := P1 10 P2 6 P3 8 P4 4 P5 11 P6 9 P7 3;
param timeReq : Grinder VDrill HDrill Borer Planer = 
			P1    0.5 	0.1 	0.2 	0.05   0
			P2 	  0.7 	0.2 	0 		0.03   0
			P3	  0 	0 		0.8 	0 	   0.01
			P4	  0 	0.3 	0 		0.07   0
			P5    0.3 	0 		0 		0.1    0.05
			P6    0.2 	0.6 	0 		0 	   0 
			P7    0.5 	0 		0.6 	0.08   0.05
			;
param hMonthCap := 384;
param down : Jan Feb Mar Apr May Jun =
	Grinder	  1   0   0   0  1    0
	VDrill	  0   0   0   1  1    0
	HDrill	  0	  2   0   0  0    1
	Borer	  0   0   1   0  0    0
	Planer	  0   0   0   0  0    1
	;
param maxSales : Jan Feb Mar Apr May Jun  = 
		P1		500		600		300		200		0		500
		P2		1000	500		600		300		100		500
		P3		300		200		0		400		500		100
		P4		300		0		0		500		100		300
		P5		800		400		500		200		1000	1100
		P6		200		300		400		0		300		500
		P7		100		150		100		100		0		60
;
param maxInv := 100;
param invCost := 0.5;
param invTarget := 50;

option solver gurobi;
solve;
display X;
display S;
display Inv;
display Y;










