# findSteadySection

This is a function that finds the Steady operating section when a steady state test such as a map test

## input variable 
 + tsData1 : Time series data of the first variable to search for steady state section ex) rpm
 + tsData2 : Time series data of the second variable to search for the steady state section ex) torque
 + thldData1 : threshold value of the first variable ex) For rpm, 50rpm for engine and 10rpm for motor
 + thldData2 : threshold value of the second variable ex) For torque, 10Nm for engine and motor
 + stdCheckDur : Minimum interval to find a steady state, 50 means to find a steady state interval of 5 seconds or more in 10Hz data
 + stdCheckSpan : Data comparison interval when looking for a steady state -> 10 in 10Hz data means checking whether the normal state is in the normal state at intervals of 1 second
 + lowerLimData1 : Minimum value standard to check operation for the first variable ex) For rpm, 500rpm for engine and 50rpm for motor
 + lowerLimData2 : Minimum value standard to check operation for the second variable ex) Apply 10Nm to torque for engine and motor

## Output variable
 + steadySection.steadyStPoint : steady-state section starting point row position
 + steadySection.steadyEdPoint : steady-state section end point row position