%  Title: Task 1 – Quarter Car Suspension (Cruise vs Sport)
%  Author: Ugochukwu Oreh
%  Date: 12/12/2025
%
%  Purpose:
%  This script analyses the dynamic response of a quarter-car
%  suspension system for cruise and sport suspension modes.
%
%  Description:
%  - Allows the user to select cruise, sport, or comparison mode
%  - Assigns appropriate suspension parameters
%  - Executes the Simulink quarter-car suspension model
%  - Plots chassis and seat displacement responses
%  - Calculates key performance metrics including overshoot
%    and settling time using the stepinfo function
%
%  Inputs:
%  - User selection of suspension mode
%  - Suspension and vehicle parameters defined in the script
%
%  Outputs:
%  - Time-domain response plots
%  - Step response performance metrics
%
%  Notes:
%  - The model assumes linear spring and damper behaviour



clc; close all;

choice = lower(strtrim(input('Select mode (cruise/sport) or type "compare": ','s')));

% Fixed parameters
M1 = 50; M2 = 250; M3 = 100;
K1 = 2200; C1 = 700; C3 = 300;
K3 = 120000;

% Mode-specific
K2_cruise = 8000;   C2_cruise = 900;
K2_sport  = 13000;  C2_sport  = 1500;

modelName = "task1simulinkmodel";


finalValue = 0.1;

if choice == "compare"

   
    K2 = K2_cruise;   C2 = C2_cruise;
    fprintf('Running Cruise: K2=%g, C2=%g\n', K2, C2);
    sim(modelName);
    t = output.Time;
    seat_cruise = output.Data(:,4);


    K2 = K2_sport;    C2 = C2_sport;
    fprintf('Running Sport: K2=%g, C2=%g\n', K2, C2);
    sim(modelName);
    seat_sport = output.Data(:,4);

   
    figure
    plot(t, seat_cruise, 'b-', 'LineWidth', 1.5); hold on
    plot(t, seat_sport,  'r--','LineWidth', 1.5);
    grid on
    xlabel('Time (s)')
    ylabel('Seat displacement (m)')
    title('Seat displacement response: Cruise vs Sport')
    legend('Cruise mode','Sport mode','Location','best')
    exportgraphics(gcf, 'Task1_Seat_Cruise_vs_Sport.emf', 'ContentType', 'vector');

  
    info2_cruise = stepinfo(seat_cruise, t, finalValue, 'SettlingTimeThreshold', 0.02);
    info5_cruise = stepinfo(seat_cruise, t, finalValue, 'SettlingTimeThreshold', 0.05);

    info2_sport  = stepinfo(seat_sport,  t, finalValue, 'SettlingTimeThreshold', 0.02);
    info5_sport  = stepinfo(seat_sport,  t, finalValue, 'SettlingTimeThreshold', 0.05);

    fprintf('\n--- Step Response Metrics (CRUISE) ---\n');
    fprintf('Rise time: %.4f s\n', info5_cruise.RiseTime);
    fprintf('Overshoot: %.4f %%\n', info5_cruise.Overshoot);
    fprintf('Settling time (5%%): %.4f s\n', info5_cruise.SettlingTime);
    fprintf('Settling time (2%%): %.4f s\n', info2_cruise.SettlingTime);

    fprintf('\n--- Step Response Metrics (SPORT) ---\n');
    fprintf('Rise time: %.4f s\n', info5_sport.RiseTime);
    fprintf('Overshoot: %.4f %%\n', info5_sport.Overshoot);
    fprintf('Settling time (5%%): %.4f s\n', info5_sport.SettlingTime);
    fprintf('Settling time (2%%): %.4f s\n', info2_sport.SettlingTime);

elseif choice == "cruise" || choice == "sport"

    if choice == "cruise"
        K2 = K2_cruise; C2 = C2_cruise;
    else
        K2 = K2_sport;  C2 = C2_sport;
    end

    fprintf('Running %s: K2=%g, C2=%g\n', choice, K2, C2);

    sim(modelName);
    t = output.Time;
    seat = output.Data(:,4);

    figure
    plot(t, seat, 'LineWidth', 1.5); grid on
    xlabel('Time (s)')
    ylabel('Seat displacement (m)')
    title("Seat displacement – " + upper(choice))

    info2 = stepinfo(seat, t, finalValue, 'SettlingTimeThreshold', 0.02);
    info5 = stepinfo(seat, t, finalValue, 'SettlingTimeThreshold', 0.05);

    fprintf('\n--- Step Response Metrics (%s mode) ---\n', upper(choice));
    fprintf('Rise time: %.4f s\n', info5.RiseTime);
    fprintf('Overshoot: %.4f %%\n', info5.Overshoot);
    fprintf('Settling time (5%%): %.4f s\n', info5.SettlingTime);
    fprintf('Settling time (2%%): %.4f s\n', info2.SettlingTime);

else
    error('Invalid selection. Type "cruise", "sport", or "compare".');
end 