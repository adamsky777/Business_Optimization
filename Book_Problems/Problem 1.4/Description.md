####Here is a similar profit-maximizing model, but in a different context. An automobile manu- facturer produces several kinds of cars. Each kind requires a certain amount of factory time per car to produce, and yields a certain profit per car. A certain amount of factory time has been scheduled for the next week, and it is desired to use all this time; but at least a certain number of each kind of car must be manufactured to meet dealer requirements.####

**(a) What are the data values that define this problem? How would you declare the sets and param- eter values for this problem in AMPL? What are the decision variables, and how would you declare them in AMPL?
(b) Assuming that the objective is to maximize total profit, how would you declare an objective in AMPL for this problem? How would you declare the constraints?
(c) For purposes of experiment, suppose that there are three kinds of cars, known at the factory as T, C and L, that 120 hours are available, and that the time per car, profit per car and dealer orders for each kind of car are as follows:**

**How much of each car should be produced, and what is the maximum profit? You should find that your solution specifies a fractional amount of one of the cars. As a practical matter, how could you make use of this solution?**

**(d) If you maximize the total number of cars produced instead of the total profit, how many more cars do you make? How much less profit?
(e) Each kind of car achieves a certain fuel efficiency, and the manufacturer is required by law to maintain a certain ‘‘fleet average’’ efficiency. The fleet average is computed by multiplying the efficiency of each kind of car times the number of that kind produced, summing all of the resulting products, and dividing by the total of all cars produced. Extend your AMPL model to contain a minimum fleet average efficiency constraint. Rearrange the constraint as necessary to make it lin- ear — no variables divided into other variables.
(f) Find the optimal solution for the case where cars T, C and L achieve fuel efficiencies of 50, 30 and 20 miles/gallon, and the fleet average efficiency must be at least 35 miles/gallon. Explain how this changes the production amounts and the total profit. Dealing with the fractional amounts in the solution is not so easy in this case. What might you do?**

**If you had 10 more hours of production time, you could make more profit. Does the addition of the fleet average efficiency constraint make the extra 10 hours more or less valuable?**

**(g) Explain how you could further refine this model to account for different production stages that have different numbers of hours available per stage, much as in the steel model of Section 1.6.**
