reset;

set PROD;
set TANK;

param volume {TANK};
param density {PROD};

var X {PROD, TANK} binary;

minimize NoOfTanks:
					sum {p in PROD, t in TANK} X[p,t] ;
					
s.t. Con1 {t in TANK}: sum{p in PROD} X[p,t] <= 1;
s.t. Con2 {p in PROD}: sum{t in TANK} volume[t]*density[p]*X[p,t] >= 6500;

data;
 
 set PROD:= Product_01
			Product_02
			Product_03
			Product_04
			Product_05
			Product_06
			Product_07
			Product_08
			Product_09
			Product_10
			Product_11
			Product_12
			Product_13
			Product_14
			Product_15
			Product_16
			Product_17
			Product_18
			Product_19
			Product_20
;
set TANK:=  Tank_01
			Tank_02
			Tank_03
			Tank_04
			Tank_05
			Tank_06
			Tank_07
			Tank_08
			Tank_09
			Tank_10
			Tank_11
			Tank_12
			Tank_13
			Tank_14
			Tank_15
			Tank_16
			Tank_17
			Tank_18
			Tank_19
			Tank_20
			Tank_21
			Tank_22
			Tank_23
			Tank_24
			Tank_25
			Tank_26
			Tank_27
			Tank_28
			Tank_29
			Tank_30
			Tank_31
			Tank_32
;

param density:= Product_01	 1.46 
				Product_02	 1.49 
				Product_03	 1.27 
				Product_04	 1.45 
				Product_05	 1.66 
				Product_06	 1.79 
				Product_07	 1.28 
				Product_08	 1.72 
				Product_09	 1.90 
				Product_10	 1.62 
				Product_11	 1.82 
				Product_12	 1.48 
				Product_13	 1.30 
				Product_14	 1.40 
				Product_15	 1.90 
				Product_16	 1.77 
				Product_17	 1.87 
				Product_18	 1.54 
				Product_19	 1.22 
				Product_20	 1.50 
;

param volume:=  Tank_01	2500
				Tank_02	3800
				Tank_03	3400
				Tank_04	1600
				Tank_05	1800
				Tank_06	6600
				Tank_07	5200
				Tank_08	2200
				Tank_09	4000
				Tank_10	4300
				Tank_11	5000
				Tank_12	4000
				Tank_13	2500
				Tank_14	2100
				Tank_15	4200
				Tank_16	5600
				Tank_17	5500
				Tank_18	5800
				Tank_19	7000
				Tank_20	7700
				Tank_21	3400
				Tank_22	5200
				Tank_23	4600
				Tank_24	6600
				Tank_25	7000
				Tank_26	5600
				Tank_27	3000
				Tank_28	2600
				Tank_29	2600
				Tank_30	4800
				Tank_31	6700
				Tank_32	1200

;

option solver gurobi;
solve;
display X;
#display{t in TANK}: sum{p in PROD}X[p,t]; # We can notice that 20 biggest tanks (in volume) were selected. 