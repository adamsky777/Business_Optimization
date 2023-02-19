reset;

param Segment;
param Channel;

param cost{1..Channel};
param a{1..Channel,1..Segment};

var X{1..Channel} binary;

minimize totalcosts:
					sum{c in 1..Channel}cost[c] * X[c];
					
s.t. ConA {s in 1..Segment}:
					sum{c in 1..Channel} a[c,s]*X[c] >= 1;

				
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

option solver gurobi;
solve;
display X;






