reset;

set MONTHS ordered; # this is the way to tel Ample Jan followed by Feb

# Attendant
param max_hours_attendant;

param resigned{MONTHS};
param cost_attendant;
param attendants_Dec; # Optional



# Trainee

param max_hours_trainee;
param max_new_trainee;

param cost_trainee;
param trainees_hired_Nov; # Optional

# Hours

param req_hours{MONTHS};

# Decision VARIABLES

var attendants_available{MONTHS} >= 0, integer; # specify integer -> we can't hire 1.4 person / month for example.
var trainees_available{MONTHS} >= 0, integer;
var trainees_hired{MONTHS} >= 0, integer;
# MODEL

minimize Total_Cost:
	sum{m in MONTHS} ((attendants_available[m] * cost_attendant) + (trainees_available[m] * cost_trainee));
	
	
# CONSTRAINES
# Attendant 

subj to Attendant1st_Month:
	attendants_available['Jan'] = attendants_Dec + trainees_hired_Nov;
	
subj to Attendant_2nd_Month:
	attendants_available['Feb'] = attendants_available['Jan'] - resigned['Jan'];
	
	# telling ample it's for the months larger than two ( after feb.)
	# use ord(m) -> referring to ordered months > larger than 2
	# larger > 2 means that it is after the second month in our set (we are interrested after February (March))
subj to Attendant_Every_Other_Months {m in MONTHS: ord(m)>2} :
	attendants_available[m] = attendants_available[prev(m)] - resigned[prev(m)] + trainees_hired[prev(m,2)];
	
# Trainee

subj to Trainees_1st_Month:
	trainees_available['Jan'] = trainees_hired['Jan'];
	
	# telling Ample the trainees every other month after January, use ord specify larger than 1 
	# trainees available in each month = trainees hired in  this month + in the previous month.
subj to Trainees_Every_Other_Month {m in MONTHS: ord(m)>1}:
	trainees_available[m] = trainees_hired[m] + trainees_hired[prev(m)];
	
subj to New_trainees_Cap {m in MONTHS}:
	trainees_hired[m] <= max_new_trainee;
	
subj to Hours_Capacity {m in MONTHS}:
	(attendants_available[m] * max_hours_attendant) + (trainees_available[m] * max_hours_trainee) >= req_hours[m];
	
	
data;

set MONTHS:=
	Jan Feb Mar Apr	May Jun;
	
#PARAMS

# ATTENDANTS

param max_hours_attendant := 150;

param  resigned := 
	Jan 	2
	Feb		0
	Mar 	2
	Apr	0
	May		1
	Jun		1;
	
	
param req_hours :=
	Jan 	8000
	Feb		9000
	Mar 	9800
	Apr		9900
	May		10050
	Jun		10500;
	
	
	
	
param attendants_Dec := 
	60;


param max_hours_trainee :=
	25;

param trainees_hired_Nov := 
	3; 

param max_new_trainee := 
	5;
	

param cost_trainee := 3600;

param cost_attendant := 5100; 


option solver gurobi;	# since we use integers in our decision var, specify gurobi as solver. 
solve;
display Total_Cost, attendants_available, trainees_available, trainees_hired  ; 
	

# SOLUTION:=
#
#Total_Cost = 2080500

#   attendants_available trainees_available trainees_hired    :=
#	Jan           63                  4                4
#	Feb           61                  6                2
#	Mar           65                  4                2
#	Apr           65                  6                4
#	May           67                  4                0
#	Jun           70                  0                0
#;















	
	
	
	
	
	
	
	
	
	
	