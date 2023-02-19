reset;

set FinishedProducts;
set IntermidieryProducts;
set RawProducts;



var Y{FinishedProducts} >= 0;    
var Z{IntermidieryProducts} >= 0;
var X{RawProducts} >= 0;

maximize Profit: 4*Y["Juice_for_sale"]+8*Y["Cider_for_sale"]+10*Y["Calvados_for_sale"]+
			     - 1500*(X["Apples_for_juice"]+X["Apples_for_cider"]) ; 
			     
s.t. MaximumSale1: Y["Juice_for_sale"] <= 5000;
s.t. MaximumSale2: Y["Cider_for_sale"] <= 2000;
s.t. MaximumSale3: Y["Calvados_for_sale"] <= 500;

s.t. con1: Y["Juice_for_sale"] = 500*X["Apples_for_juice"] - Z["Juice_for_cider"];
s.t. con2: Y["Cider_for_sale"] = 250*X["Apples_for_cider"] - Z["Cider_for_calvados"] + 0.6*Z["Juice_for_cider"];
s.t. con3: Y["Calvados_for_sale"] = 0.4*Z["Cider_for_calvados"];


data;

set FinishedProducts := Juice_for_sale Cider_for_sale Calvados_for_sale;
set IntermidieryProducts := Juice_for_cider Cider_for_calvados;
set RawProducts := Apples_for_juice Apples_for_cider;


option solver cplex;
solve;
display Y;
display Z;
display X;

