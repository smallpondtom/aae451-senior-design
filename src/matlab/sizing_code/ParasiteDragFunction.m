%% Parasite Drag Function                                           %
% Function that computes parasite drag coefficient.                 %
% This function uses Raymer Eq. 12.24 to calculate the parasite drag%
% coefficient under subsonic flight.                                %
% Input：inputs parameters, flight altitude                         %
% Parasite drag coef = Component drag coef + Miscellaneous drag coef%
%                                                                   %
% Component drag coef considered in order:                          %
% Fuselage, Wing, Horizontal Tail, Vertical Tail, Nacelle           %
%                                                                   %
% Miscellaneous drag coef considered:                               %
% Upsweep drag coef, Leakage and protuberance drag coef             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
    This function REQUIRES massive change using the info on Lecture Slide 
    "Topic 8: Drag Prediction" Slides 8 to 37

%}


function [output] = ParasiteDragFunction(inputs, h)

%% Original Code
% Equivalent skin friction coefficient (based on Raymer Ch.12 Table 12.3)
% Cfe = 0.0026;    % Civil Transporter

% Parasite Drag coefficient (Zero-lift drag coef)
% Cdo = Cfe*inputs.GeometryOutput.Swet/inputs.GeometryOutput.Sw; 

% --->(REQUIRE MODIFICATION) DEREK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
V = inputs.PerformanceInputs.V;             % Cruise Velocity [m/s]
MC_wing = inputs.GeometryOutput.MAC;        % Mean Aerodynamic Chord Length for Wing [m]
MC_ht = inputs.GeometryOutput.MC_ht;       % Mean Aerodynamic Chord Length for Horizontal Tail [m]
MC_vt = inputs.GeometryOutput.MC_vt;       % Mean Aerodynamic Chord Length for Vertical Tail [m]
L_fuse = inputs.LayoutOutput.lf;            % Aircraft fuselage length [m]
k = inputs.GeometryInputs.k;                % Skin roughness value [m]
WingSweep = inputs.GeometryInputs.WingSweep;    % Wing Sweep Angle [deg]
VtSweep = inputs.GeometryInputs.VtSweep;        % Vertical Sweep Angle [deg]
HtSweep = inputs.GeometryInputs.HtSweep;        % Horizontl Sweep Angle [deg]
t2c_w = inputs.GeometryInputs.thick2chord;      % Wing thickness-to-chord ratio   
t2c_ht = inputs.GeometryInputs.t2c_ht;          % horizontal tail thickness-to-chord ratio
t2c_vt = inputs.GeometryInputs.t2c_vt;          % vertical tail thickness-to-chord ratio
fin_rat = inputs.GeometryInputs.FinessRatio;    % fuselage finess ratio
A_max = inputs.GeometryInputs.A_max;            % fuselage max cross sectional area [m^2]
Q_fuse = inputs.GeometryInputs.Q_fuse;          % Fuselage-Nacelle interference factor
Q_wing = inputs.GeometryInputs.Q_wing;          % Wing-Nacelle interference factor
Q_ht = inputs.GeometryInputs.Q_ht;              % Horizontal tail interference factor
Q_vt = inputs.GeometryInputs.Q_vt;              % Vertical tail interference factor 
Q_n = inputs.GeometryInputs.Q_nacel;            % Nacelle-wing interference factor
S_ref = inputs.GeometryOutput.Sw;               % Reference area (Wing area to center axis)[m^2]  % NEED CHECK
Swetfus = inputs.GeometryOutput.Swetfus;        % Fuselage wetted area [m^2]
Swetwing = inputs.GeometryOutput.Swetwing;      % Wing wetted area [m^2]
Sweth = inputs.GeometryOutput.Sweth;            % Horizontal tail wetted area [m^2]
Swetv = inputs.GeometryOutput.Swetv;            % Vertical tail wetted area [m^2]
Swetn = inputs.GeometryOutput.Swetn;            % Nacelle wetted area [m^2]
upsweep = inputs.GeometryInputs.upsweep;        % Upsweep angle of tail [deg]
L_nacel = inputs.GeometryInputs.L_nacel;        % Nacelle length [m]
D_nacel= inputs.GeometryInputs.D_nacel;        % Nacelle diameter [m]

Swet = [Swetfus, Swetwing, Sweth, Swetv, Swetn]; % Assign vector storing selected wetted area [m^2]
Q = [Q_fuse, Q_wing, Q_ht, Q_vt, Q_n];           % Assign vector storing selected interference factors
Char_L = [L_fuse, MC_wing, MC_ht, MC_vt, D_nacel];   % Assign characteristic lengths as vector [m]   % NEED CHECK NACELLE REF S
% Char_L = [L_fuse, MC_wing, MC_ht, MC_vt, L_nacel];     % Assign characteristic lengths as vector [m]   % NEED CHECK NACELLE REF S
Re_num = zeros(1,length(Char_L));           % Assign vector storing selected Reynolds numbers
t2c = [t2c_w, t2c_ht, t2c_vt];              % Assign vector storing airfoil thickness-to-chord ratio (t2c_wing, t2c_horizontal tail, t2c_vertical tail)
Sweep = [WingSweep, HtSweep, VtSweep];      % Assign vector storing airfoil sweep angle [deg] (wing sweep, horizontal tail sweep, vertical tail sweep)

% Sf = inputs.GeometryOutput.Sf;                  % Fuselage reference area [m^2]
% Sh = inputs.GeometryOutput.Sh;                  % Horizontal tail reference area [m^2]
% Sv = inputs.GeometryOutput.Sv;                  % Vertical tail reference area [m^2]
% S = [Sf, Sw, Sh, St];                       % Assign vector storing selected reference area [m^2]


%% Environmental Parameter Calculation
[a, rho, P, Temp] =  AtmosphereFunction(h);          % Calculate Speed of Sound [m/s], Air Density [kg/ m^3], Pressure [Pa], Temperature [K] at given altitude h [m]
meu = sutherland_visc_calc(Temp, 'air');             % Calculate Dynamic Viscosity of Air [kg / (m * s)]  
M = V / a;                                           % Calculate Cruise Mach Number [Mach]

%% Reynolds Number & Cutoff Reynolds Number Calculation
Re = rho * V * Char_L / meu;             % Calculate Components Reynolds Numbers (Re_fuse, Re_wing, Re_ht, Re_vt, Re_n) Raymer Eq 12.26
Re_c = 38.21 * (Char_L / k) .^ 1.053;    % Calculate Subsonic Cutoff Reynolds Numbers (Re_c_fuse, Re_c_wing, Re_c_ht, Re_c_vt, Re_c_n) Raymer Eq 12.28

% Re_fuse = rho * V * L_fuse / meu;      % Calculate Fuselage Reynolds Number
% Re_wing = rho * V * MC_wing / meu;     % Calculate Wing Reynolds Number
% Re_ht = rho * V * MC_ht / meu;         % Calculate Horizontal Tail Reynolds Number
% Re_vt = rho * V * MC_vt / meu;         % Calculate Vertical Tail Reynolds Number


%% Reynolds Number Selection
% Select the lower of actual Reynolds Number and Cut-off Reynolds Number
for indx = 1 : length(Re)
    if Re(indx) <= Re_c(indx)
        Re_num(indx) = Re(indx);
    else
        Re_num(indx) = Re_c(indx);
    end
end

%% Flat-plate skin friction coefficient calculation (Assume Turbulent Flow, Conservative Approx)
C_f = 0.455 ./ (((log10(Re_num)) .^ 2.58) * ((1 + 0.144 * (M ^ 2)) ^ 0.65));   % Calculate turbulent flow flat-place skin friction coefficient (Cf_fuse, Cf_wing, Cf_ht, Cf_vt, Cf_n) Raymer Eq 12.27

%% Airfoil Form factor calculation
% Calculate Airfoil Form Factor (Raymer 12.30) 
x_c_rat = 0.3;              % Chordwise non-dimensional location of airfoil max thickness point (Assume low speed airfoils)
FF_foil = (1 + (0.6 / x_c_rat) * t2c + 100 * (t2c .^ 4)) .* (1.34 * (M ^ 0.18) * (cosd(Sweep) .^ 0.28));  % Calculate airfoil form factors (FF_w, FF_ht, FF_vt)

%% Optional Airfoil Form Factor Calculation (Shevell)
% Calculate Airfoil Form Factor (Shevell)
% Z = ((2 - (M ^ 2)) * cos(Sweep)) ./ sqrt(1 - (M ^ 2) * (cos(Sweep) .^ 2));    % Calculate sweep correction factor
% FF_foil = 1 + Z .* t2c + 100 * (t2c .^ 4);           % Calculate airfoil form factors (FF_w, FF_ht, FF_vt)

%% Fuselage Form Factor calculation(Raymer Eq. 12.31)
% Effective Diameter (Optional)
% D_f = sqrt((4 * pi) * A_max);     % Fuselage diameter if fuselage is not hot dog shape 
FF_fuse = 0.9  + (5 / (fin_rat ^ 1.5)) + (fin_rat / 400);   % Calculate fuselage form factor

%% Nacelle Form Factor calculation {Raymer Eq. 12.32 & Eq. 12.33)
f = L_nacel / D_nacel;                % Calculate nacelle length-to-diameter ratio
FF_nacel = 1 + (0.35 / f);            % Calculate nacelle form factor
FF = [FF_fuse, FF_foil, FF_nacel];    % Assign vector storing form factor (FF_fuse, FF_wing, FF_ht, FF_vt, FF_nacel]

%% Parasite Drag C_D0 calculation
C_Dmisc_up = 3.83 * (deg2rad(upsweep) ^ 2.5) * A_max / S_ref;     % Calculate miscellaneous C_D due to upsweep
C_D0_comp = (C_f .* FF .* Q .* Swet) / S_ref;            % Calculate C_D0 due to components (Cd_fuselage, Cd_wing, Cd_ht, Cd_vt, Cd_nacelle)
C_D0_comp_tot = sum(C_D0_comp);                          % Calculate total component C_D0
C_Dmisc_lp = 0.03 * C_D0_comp_tot;                           % Calculate miscellaneous C_D due to leakage and protuberance (assumed to be 3% of component C_D0 for normal production aircraft)
Cdo = C_D0_comp_tot + C_Dmisc_lp + C_Dmisc_up;               % Calculate parasite drag coefficient

%% Function Outputs
    output.Cdo = Cdo;                 % Total parasite drag coef (Component drag coef + Miscellaneous drag coef)
    output.Cd_fuse = C_D0_comp(1);    % Fuselage component drag coef
    output.Cd_wing = C_D0_comp(2);    % Wing component drag coef
    output.Cd_ht = C_D0_comp(3);      % Horizontal tail component drag coef
    output.Cd_vt = C_D0_comp(4);      % Vertical tail component drag coef
    output.Cd_nacel = C_D0_comp(5);   % Nacelle component drag coef
    output.Cd_misc = C_Dmisc_lp + C_Dmisc_up;   % Miscellaneous drag coef (upsweep + leak & protuberance)
    
    output.Re_fuse = Re_num(1);       % Fuselage Reynolds Number
    output.Re_wing = Re_num(2);       % Wing Reynolds Number
    output.Re_ht = Re_num(3);         % Horizontal Tail Reynolds Number
    output.Re_vt = Re_num(4);         % Vertical Tail Reynolds Number
    output.Re_nacel = Re_num(5);      % Nacelle Reynolds Number
    output.FF_fuse = FF_fuse;         % Fuselage Form Factor
    output.Re_fuse_old = Re(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% <---(END)

end