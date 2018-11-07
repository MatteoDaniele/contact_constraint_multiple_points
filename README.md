MATTEO DANIELE

tested with Matlab r2016b (linux 64bit)

This folder contatins the simulation of a contact between a ball and a platform.
The system uses MBDyn multibody software and Matlab Simulink tool interacting together.
In particular, MBDyn solver calculates the dynamics of the 2 points representing the "Flying object"
and the platform, while simulink uses the position and attitude informations to calculate when the 
contact happens and to apply a simple model of reaction forces.
Procedure:
1) open the file "platform_and_ball_characteristics.m" in Matlab and change the desired parameters;
2) run "platform_and_ball_characteristics.m" to save the changes in the workspace;
3) run ./cc_main.mbd to start the simulation from the MBDyn side (chmod +x cc_main.mbd in case);
4) open and run "main.slx" in Simulink to run the simulation from Matlab side;
5) when the simulation is over, it is possible to run "Output/cc_out.m" to see the results with Matlab.
