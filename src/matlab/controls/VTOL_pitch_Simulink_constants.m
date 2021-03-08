% Set constants for VTOL roll control Simulink model 
clear all; clc; 

tau = 10; 
Fmax = 10; 
% Airflow ratio
rcp = 0.6;
rhp = 0.4;
% Distances of each post from the lateral axis 
dcp = 0.4;
dhp = 0.6;
% mean distance 
if round(dcp*rcp) == round(dhp*rhp)
    d = rcp * dcp;
else
    d = (rcp * dcp + rhp * dhp) / 2;  
end
Jyy = 1; 
V_wind = 1; 
d_threshold = 1; % turn on/off disturbance 
threshold = -1;  % switch between impulse disturbance and wind disturbance
                 % negative value = wind disturbance
                 % positive value = impulse disturbance
n_threshold = 1; % turn on/off noise 

% Tuned values for no noise or diturbance considered 
% kp = 0.000109064485537328
% ki = 1.09141322176216e-11
% kd = 1.3026117535107 
% N = 23.9048692719336                      
% where Tf = 1 / N 