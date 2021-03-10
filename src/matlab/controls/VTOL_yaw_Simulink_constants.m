% Set constants for VTOL roll control Simulink model 
clear all; clc; 

tau_p = 4; 
theta_max = pi / 4; 
l = 1;  
F = 10;
Jzz = 1; 
V_wind = 1; 
d_threshold = 1; % turn on/off disturbance 
threshold = -1;  % switch between impulse disturbance and wind disturbance
                 % negative value = wind disturbance
                 % positive value = impulse disturbance
n_threshold = 1; % turn on/off noise 

% Tuned values for no noise or diturbance considered 
% kp = 9.36743389908816e-08 
% ki = 5.08261650479512e-11 
% kd = 0.468303052208702 
% N = 184.314581201354                     
% where Tf = 1 / N 