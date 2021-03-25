% Set constants for VTOL roll control Simulink model 
clear all; clc; 
addpath("../../../parameters/");

% Load the excel sheet in the parameters folder to obtain the moment of
% intertias 
T = readtable("catiaMeas.xlsx","Sheet","OGWingPosition");

% Obtain moment of inertias 
Ixx = T.IoxG_kgxm2_(8);
Iyy = T.IoyG_kgxm2_(8);
Izz = T.IozG_kgxm2_(8);

tau_p = 1/2;  % motor time constant
theta_max = 120 / 180 * pi; 
l = 3.68;  % long axis to engine duct  
F = 71.22e3;  % max thrust
Jzz = Ixx + Iyy; 

Ad = 1.434674412004357;  % max amp
f = 4.941713361323833;  % max freq

d_threshold = 1; % turn on/off disturbance 
n_threshold = 1; % turn on/off noise 

% Tuned values for no noise or diturbance considered 
% kp = 3.18990571608165e-07
% ki = 1.07659897952381e-09
% kd = 1.59388178732738 
% N = 82.3653245643473                   
% where Tf = 1 / N 

%Plotting and saving 
% sim = sim("vtol_yaw.slx");
% t = sim.tout;
% res = sim.res.signals.values;
% fig = figure("Renderer", "painters", "Position", [60 60 900 700]);
%     plot(t, res)
%     grid on; grid minor; box on; 
%     ylabel("yaw angle")
%     xlabel("t")
% saveas(fig, "yaw_resp.png");