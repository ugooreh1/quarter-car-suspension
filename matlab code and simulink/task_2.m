%% ------------------------------------------------------------
% Task 2 – Bump-stops
% Separate plots for BEFORE and AFTER models
% Chassis displacement (r + x + y)
%% ------------------------------------------------------------

clc; close all;

% Model names
model_before = "task1simulinkmodel";
model_after  = "task2simulink";

% Load road profile
load('roadProfile.mat');

% Fixed parameters
M1 = 50;  M2 = 250;  M3 = 100;
K1 = 2200; C1 = 700; C3 = 300;
K3 = 120000;

% Mode-specific parameters
K2_cruise = 8000;   C2_cruise = 900;
K2_sport  = 13000;  C2_sport  = 1500;

% Chassis displacement column (r + x + y)
chassis_col = 3;

%% ================= CRUISE MODE =================

K2 = K2_cruise;
C2 = C2_cruise;

% ---- BEFORE bump-stops ----
sim(model_before);
t = output.Time;
chassis_before = output.Data(:, chassis_col);

figure
plot(t, chassis_before, 'LineWidth', 1.5)
grid on
xlabel('Time (s)')
ylabel('Chassis displacement (m)')
title('Cruise mode – Chassis displacement (Before bump-stops)')

% ---- AFTER bump-stops ----
sim(model_after);
% ---- AFTER bump-stops ----
sim(model_after);
t_after = output.Time;
chassis_after = output.Data(:, chassis_col);

figure
plot(t_after, chassis_after, 'LineWidth', 1.5)
grid on
xlabel('Time (s)')
ylabel('Chassis displacement (m)')
title('Cruise mode – Chassis displacement (After bump-stops)')

%% ================= SPORT MODE =================

K2 = K2_sport;
C2 = C2_sport;

% ---- BEFORE bump-stops ----
sim(model_before);
t = output.Time;
chassis_before = output.Data(:, chassis_col);

figure
plot(t, chassis_before, 'LineWidth', 1.5)
grid on
xlabel('Time (s)')
ylabel('Chassis displacement (m)')
title('Sport mode – Chassis displacement (Before bump-stops)')

% ---- AFTER bump-stops ----
sim(model_after);
% ---- AFTER bump-stops ----
sim(model_after);
t_after = output.Time;
chassis_after = output.Data(:, chassis_col);

figure
plot(t_after, chassis_after, 'LineWidth', 1.5)
grid on
xlabel('Time (s)')
ylabel('Chassis displacement (m)')
title('Cruise mode – Chassis displacement (After bump-stops)')
disp('Done: chassis displacement plots generated separately.');

