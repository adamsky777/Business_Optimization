reset;

set Skill; # skill types of worker
set Retraining; # different retraining possibilities
set Downgrading; # different downgrading possibilities

param T; # time period (years)

param d {1..T, Skill}; # requirements
param init {Skill}; # initial/current workforce
param w1 {Skill}; # wastage rate by less than 1 year
param w2 {Skill}; # wastage rate by more than 1 year
param maxRec {Skill}; # max. number of recruiting each year 
param redP {Skill}; # redundancy payment for each leaving worker
param maxOver; #max ovemanning
param maxSt; # max. number of short-time worker
param stC {Skill}; # short-time costs
param overC {Skill}; # overmanning costs for each worker

var W {0..T, Skill} >= 0; # number of workers
var WRec {1..T, Skill} >= 0; # number of recruited workers
var WSt {1..T, Skill} >= 0; # number of workers on short-time
var WRed {1..T, Skill} >= 0; # number of workers made redundant
var WOver {1..T, Skill} >= 0; # number of superfluous workers
var WRet {1..T, Retraining} >= 0; # number of retrained workers
var WDown {1..T, Downgrading} >= 0; # number of downgraded workers

minimize Redundancy:
	sum{t in 1..T} sum{s in Skill} WRed[t,s];

s.t. Constraint1_Initial {s in Skill}:
	W[0,s] = init[s];
		
s.t. Constraint2_Continuity_SkilledWorker {t in 1..T}:
	W[t,'skilled'] = w2['skilled']*W[t-1,'skilled']
	+ w1['skilled']*WRec[t,'skilled'] 
	+ w2['skilled']*WRet[t, 'semi-skilled_to_skilled']
	- WDown[t, 'skilled_to_semi-skilled'] - WDown[t, 'skilled_to_unskilled']
	- WRed[t, 'skilled'];
	
s.t. Constraint3_Continuity_SemiSkilledWorker {t in 1..T}:
	W[t,'semi-skilled'] = w2['semi-skilled']*W[t-1,'semi-skilled']
	+ w1['semi-skilled']*WRec[t,'semi-skilled'] 
	+ w2['semi-skilled']*WRet[t, 'unskilled_to_semi-skilled'] - WRet[t, 'semi-skilled_to_skilled']
	+ 0.5*WDown[t, 'skilled_to_semi-skilled'] - WDown[t, 'semi-skilled_to_unskilled']
	- WRed[t, 'semi-skilled'];
	
s.t. Constraint4_Continuity_UnskilledWorker {t in 1..T}:
	W[t,'unskilled'] = w2['unskilled']*W[t-1,'unskilled']
	+ w1['unskilled']*WRec[t,'unskilled'] 
	- WRet[t, 'unskilled_to_semi-skilled']
	+ 0.5*WDown[t, 'skilled_to_unskilled'] + 0.5*WDown[t, 'semi-skilled_to_unskilled']
	- WRed[t, 'unskilled'];
	
s.t. Constraint5_Demand {t in 1..T, s in Skill}:
	W[t,s] - 0.5*WSt[t,s] - WOver[t,s] = d[t,s];
	
s.t. Constraint6_MaxRecruiting {t in 1..T, s in Skill}:
	WRec[t,s] <= maxRec[s];

s.t. Constraint7_MaxRetraining_SemiSkilled {t in 1..T, s in Skill}:
	WRet[t, 'semi-skilled_to_skilled'] <= 0.25*W[t, 'skilled'];
	
s.t. Constraint8_MaxRetraining_Unskilled {t in 1..T, s in Skill}:
	WRet[t, 'unskilled_to_semi-skilled'] <= 200;
	
s.t. Constraint9_MaxShortTime {t in 1..T, s in Skill}:
	WSt[t,s] <= maxSt;
	
s.t. Constraint10_MaxOvermanning {t in 1..T}:
	sum{s in Skill} WOver[t,s] <= maxOver;


data;

set Skill := unskilled semi-skilled skilled;
set Retraining := unskilled_to_semi-skilled semi-skilled_to_skilled;
set Downgrading := skilled_to_semi-skilled skilled_to_unskilled semi-skilled_to_unskilled;

param T := 3;

param d :
	unskilled semi-skilled skilled =
1 1000 1400 1000
2 500 2000 1500
3 0 2500 2000;

param init :=
unskilled 2000
semi-skilled 1500
skilled 1000;

param w1 :=
unskilled 0.75
semi-skilled 0.8
skilled 0.9;

param w2 :=
unskilled 0.9
semi-skilled 0.95
skilled 0.95;

param maxRec :=
unskilled 500
semi-skilled 800
skilled 500;

param redP :=
unskilled 200
semi-skilled 500
skilled 500;

param maxOver := 150;

param maxSt := 50;

param stC :=
unskilled 500
semi-skilled 400
skilled 400;

param overC :=
unskilled 1500
semi-skilled 2000
skilled 3000;


option solver gurobi;
solve;
display W;
display WRec;
display WSt;
display WRed;
display WOver;
display WRet;
display WDown;


