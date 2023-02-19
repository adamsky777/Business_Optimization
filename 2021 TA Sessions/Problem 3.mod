reset;

set Assets;

param r{Assets};    # Estimated Return for each asset 
param b;			# Invetment Budget
param c;            # Personal loan percentage capacity of total portfolio

var X{Assets} >= 0; # Amount of money to be invested in each asset

maximize EstimatedReturn:
					      sum{a in Assets} X[a]*r[a];
					      
s.t. InvetmentBudget:
						  sum{a in Assets} X[a] <= b;
						  			
s.t. PersoanlLoansCapacity:
						  X['Personal_Loans'] - c*sum{a in Assets} X[a] <= 0;
						  					  
s.t. MortgagesVSpersonalLoans:
						  X['Mortgages'] - X['Personal_Loans'] >= 0; # Alternatively, we can substitute zero to a different number to ensure Morgages are higher than Personal loan by at least that amount. 
						  
s.t. BondsVSpersonalLoans:
						  X['Bonds'] - X['Personal_Loans'] >= 0;
						  
data;

set Assets := Bonds Mortgages Car_Loans Personal_Loans;

param r := 
			Bonds           0.1
			Mortgages		0.085
			Car_Loans		0.095
			Personal_Loans	0.125
;

param b := 6500000;
param c:= 0.25;


option solver gurobi;
solve;
display X;