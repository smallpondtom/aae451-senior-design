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

tau = 1/2; 
Fmax = 71.22e3; 
% Airflow ratio
rcp = 0.5;
rhp = 0.5;
% Distances of each post from the lateral axis 
dcp = 1.181;
dhp = 1.105;
% mean distance 
if round(dcp*rcp) == round(dhp*rhp)
    d = rcp * dcp;
else
    d = (rcp * dcp + rhp * dhp) / 2;  
end
Jyy = Ixx + Izz; 

f = 0.517947467923121;  % max freq
Ad = 1.175699206758237;  % max amp

d_threshold = 1; % turn on/off disturbance 
n_threshold = 1; % turn on/off noise 

% Tuned values for no noise or diturbance considered 
% kp = 2.44992025334364e-06
% ki = 3.06547663120764e-10
% kd = 8.65079280777963 
% N = 75.5192599403064                      
% where Tf = 1 / N 

%Plotting and saving 
sim = sim("vtol_pitch.slx");
t = sim.tout;
res = sim.res.signals.values;
fig = figure("Renderer", "painters", "Position", [60 60 900 700]);
    plot(t, res)
    grid on; grid minor; box on; 
    ylabel("pitch angle")
    xlabel("t")
saveas(fig, "pitch_resp.png");