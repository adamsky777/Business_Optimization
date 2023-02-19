reset;

param Segment;
param Channel;

param cost{1..Channel};
param a{1..Channel,1..Segment};
param sales {1..Segment};
param budget;

var X{1..Channel} binary;
var Z{1..Segment} binary;

maximize revenue:
					sum{s in 1..Segment} Z[s]*sales[s]
;

s.t. Con1: sum{c in 1..Channel} X[c]*cost[c] <= 200;

s.t. Con2{s in 1..Segment}: Z[s] <= sum{c in 1..Channel} a[c,s]*X[c]; 
					
data;

param Segment:= 
14
;

param Channel :=
20
;

param cost := 
1	12
2	45
3	86
4	56
5	72
6	73
7	82
8	40
9	25
10	53
11	28
12	27
13	53
14	77
15	64
16	33
17	75
18	84
19	75
20	83
;

param a : 	1	2	3	4	5	6	7	8	9	10	11	12	13	14 = 

			1	1	0	0	0	0	0	0	0	0	0	0	0	0	0
			2	1	0	0	0	0	1	0	1	0	0	0	1	0	0
			3	0	0	0	0	1	0	0	1	0	0	0	0	0	0
			4	0	0	0	0	0	1	1	1	0	0	0	0	0	0
			5	0	0	1	1	1	0	1	0	0	0	0	0	0	0
			6	1	0	0	0	1	0	0	0	0	0	0	0	0	0
			7	1	1	0	0	0	0	0	0	0	0	1	0	0	0
			8	0	0	0	1	0	1	0	0	0	0	0	1	0	1
			9	0	0	0	0	1	1	0	0	0	0	1	1	0	0
			10	0	0	0	0	0	0	0	1	1	0	0	1	0	0
			11	0	0	0	0	0	0	0	0	0	0	0	0	1	0
			12	0	0	0	0	0	1	1	1	0	1	0	0	1	0
			13	0	0	1	0	0	1	1	0	0	0	0	0	0	0
			14	0	0	1	0	0	0	1	0	0	0	1	0	0	0
			15	0	1	0	0	0	0	0	1	0	0	0	0	0	0
			16	0	0	0	0	0	0	0	0	0	0	1	1	0	0
			17	0	1	0	0	1	0	0	0	0	0	0	0	0	0
			18	0	0	0	1	0	0	0	0	0	0	0	0	1	0
			19	0	0	0	0	0	0	1	1	0	0	0	0	0	1
			20	0	1	0	0	0	0	0	0	0	0	0	0	0	0
;

param budget := 200;

param sales := 
1	571
2	384
3	773
4	844
5	934
6	113
7	313
8	190
9	629
10	965
11	924
12	505
13	973
14	779
;

option solver gurobi;
solve;
display X;
display Z;






