%% Task 4 – Whole axle validation
clc; clear; close all;

Mode = lower(strtrim(input('Select mode (cruise/sport): ','s')));
if ~ismember(Mode, ["cruise","sport"])
    error('Invalid selection. Type "cruise" or "sport".');
end

% Parameters
M1 = 50; M2 = 250; M3 = 100;
K1 = 2200; C1 = 700; C3 = 300;
K3 = 120000;

K2_cruise = 8000;   C2_cruise = 900;
K2_sport  = 13000;  C2_sport  = 1500;

if Mode == "cruise"
    K2 = K2_cruise;  C2 = C2_cruise;
else
    K2 = K2_sport;   C2 = C2_sport;
end

fprintf('Running %s mode: K2=%g, C2=%g\n', upper(Mode), K2, C2);

% Road profile (must match From Workspace variable names in Simulink)
load('roadProfile.mat');
roadprofileL = timeseries(roadprofileL(:), sampledTime(:));
roadprofileR = timeseries(roadprofileR(:), sampledTime(:));

% Simulate one lap
modelName = 'task4simulinkmodel';
load_system(modelName);
set_param(modelName, 'StopTime', num2str(sampledTime(end)));
sim(modelName);

if ~exist('wheelAbsL','var') || ~exist('wheelAbsR','var')
    error('wheelAbsL/wheelAbsR not found. Check To Workspace block names and Save format = Timeseries.');
end

% RMSE (traction)
eL = wheelAbsL.Data - roadprofileL.Data;
eR = wheelAbsR.Data - roadprofileR.Data;
RMSE_L = sqrt(mean(eL.^2));
RMSE_R = sqrt(mean(eR.^2));

% MAE (stability)
MAE_LR = mean(abs(wheelAbsL.Data - wheelAbsR.Data));

fprintf('\nRMSE Left  = %.6f m\n', RMSE_L);
fprintf('RMSE Right = %.6f m\n', RMSE_R);
fprintf('MAE L-R    = %.6f m\n', MAE_LR);

% Plots
figure;
plot(roadprofileL.Time, roadprofileL.Data, '-o', 'MarkerSize', 2); hold on;
plot(roadprofileR.Time, roadprofileR.Data, '-o', 'MarkerSize', 2);
grid on; xlabel('Time (s)'); ylabel('Road displacement (m)');
title('Road profile inputs: Left vs Right');
legend('Road Left','Road Right','Location','best');

figure;
plot(roadprofileL.Time, roadprofileL.Data, '-o', 'MarkerSize', 2); hold on;
plot(wheelAbsL.Time, wheelAbsL.Data, '-', 'LineWidth', 0.8);
grid on; xlabel('Time (s)'); ylabel('Displacement (m)');
title(['Left wheel vs road - ' upper(Mode)]);
legend('Road (Left)','WheelAbs (Left)','Location','best');

figure;
plot(roadprofileR.Time, roadprofileR.Data, '-o', 'MarkerSize', 2); hold on;
plot(wheelAbsR.Time, wheelAbsR.Data, '-', 'LineWidth', 0.8);
grid on; xlabel('Time (s)'); ylabel('Displacement (m)');
title(['Right wheel vs road - ' upper(Mode)]);
legend('Road (Right)','WheelAbs (Right)','Location','best');

figure;
plot(wheelAbsL.Time, wheelAbsL.Data - wheelAbsR.Data, 'LineWidth', 1.2);
grid on; xlabel('Time (s)'); ylabel('WheelAbsL - WheelAbsR (m)');
title(['Horizontal stability indicator - ' upper(Mode)]);
