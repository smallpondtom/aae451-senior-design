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

tau = 1/2;  % time constant reciprocal
Fmax = 71.22e3;  % max thrust
l = 3.68;  % long axis to engine duct 
Jxx = Iyy + Izz;  % polar moment of inertia Iyy + Izz

f = 0.6250551925273969;  % max freq
Ad = 1.1968251487024621;  % max amp

d_threshold = 1; % turn on/off disturbance 
n_threshold = 1; % turn on/off noise 

% Tuned values for no noise or diturbance considered 
% kp = 2.27819592159632e-07
% ki = 1.69145522308596e-10
% kd = 1.13885309526558 
% N = 111.055675353426                      
% where Tf = 1 / N 

%Plotting and saving 
sim = sim("vtol_roll.slx");
t = sim.tout;
res = sim.res.signals.values;
fig = figure("Renderer", "painters", "Position", [60 60 900 700]);
    plot(t, res)
    grid on; grid minor; box on; 
    ylabel("roll angle")
    xlabel("t")
saveas(fig, "roll_resp.png");