% Set constants for VTOL roll control Simulink model 
clear all; clc; 

tau = 10; 
Fmax = 10; 
l = 1;  
Jxx = 1; 
V_wind = 1; 
d_threshold = 1; % turn on/off disturbance 
n_threshold = 1; % turn on/off noise 

% Tuned values for no noise or diturbance considered 
% kp = 1.81481547825078e-05 
% ki = 1.81171194402346e-12 
% kd = 0.3129809309805 
% N = 23.7738638769895                      
% where Tf = 1 / N 