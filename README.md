 Quarter-Car Suspension Modelling (MATLAB + Simulink)

This project models and analyses a quarter-car suspension system using MATLAB and Simulink.  
The simulations investigate how different suspension configurations affect the chassis displacement when the vehicle encounters road disturbances.

The project includes simulations for:

- Cruise vs Sport suspension modes
- Bump-stop implementation
- Whole axle validation



 Tools Used

MATLAB  
Simulink



 Repository Structure

code – MATLAB scripts and Simulink models used for simulations  
results – plots generated from the simulations  
report – detailed project report explaining modelling and results  
roadProfile.mat – road disturbance input used in the simulations



 Road Profile Input

The simulations use an external file called `roadProfile.mat`.

This file contains the road disturbance signal used as the input to the suspension system.  
It represents how the road height changes over time and allows the model to simulate how the vehicle suspension responds to bumps.

The MATLAB scripts load this file automatically using:
load('roadProfile.mat')-

 How to Run the Project

1. Download or clone this repository.
2. Open MATLAB.
3. Navigate to the project folder.
4. Run the MATLAB scripts located in the `code` folder.

Example scripts:

- `Task_1.m` – Cruise vs Sport suspension comparison  
- `task_2.m` – Suspension behaviour before and after bump-stops  
- `task_4.m` – Whole axle validation simulation  

The scripts automatically run the corresponding Simulink models and generate plots showing chassis displacement.



 Example Outputs

Simulation results showing chassis displacement are available in the `results` folder.

These plots compare how the suspension system responds under different configurations.



Author

Ugochukwu Oreh  
Mechatronics & Robotics Engineering Student  
University of Sheffield
