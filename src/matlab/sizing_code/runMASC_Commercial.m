%% This sizing routing size a Subsonic Commercial Transport aircraft for    %
% a set of given input parameters. It largely based on Raymer's aircraft    %
% sizing approach - equations and tables are referenced throughout the code.%                                 
%                                                                           %
% Note 1:                                                                   % 
% This code does not have an engine-deck generation. Thurst is  obtained    % 
% from the T/W parameter and the engine sized accordingly. This is a        % 
% simplified way to get engine information and may need to be changed       % 
% according to desired studies/analyses.                                    % 
% Note 2:                                                                   % 
% The cabin (fuselage) layout is computed based on a series of parameters   %
% that are listed in LayoutFunction.m. These must be changed if alternate   % 
% cabin layout configurations are desired.                                  % 
% Revised: B. Sells, T. Kanno (2018), (c) Parithi Govindaraju - Jan 2016    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% HOUSEKEEPING
clear all; close all; clc;

%% DESIGN MISSION PARAMETERS
MissionInputs.R           = imperial2metric(722,'nmi');    % aircraft range [km] convert to [m]
MissionInputs.loiter_time = 0.75*3600;                       % loiter time [hours] convert to [s]
MissionInputs.pax         = 6;                            % number of passengers   

%% ECONOMIC MISSION PARAMETERS
%EconMission.range         = 9420;    % economic mission length [nmi]

%% PERFORMANCE PARAMETERS
PerformanceInputs.TW   = 1.2;                                   % thrust-to-weight ratio [lb/lb] or [N/N]
PerformanceInputs.WS   = imperial2metric(60,'lb/ft^2');         % wing loading [lbs/ft^2] convert to [kg/m^2]
PerformanceInputs.V    = 206.5; 
% PerformanceInputs.V    = imperial2metric(401.5, 'knot');           % cruise velocity [knots] convert to [m/s]
PerformanceInputs.Vlt  = imperial2metric(296, 'knot');           % loiter velocity [knots] convert to [m/s]
PerformanceInputs.nmax = 1.5;                                      % maximum load factor
PerformanceInputs.hc   = imperial2metric(38000, 'ft');           % cruise altitude [ft] convert to [m]
PerformanceInputs.hlt  = imperial2metric(29000, 'ft');            % loiter altitude [ft] convert to [m]

[PerformanceInputs.cruiseSpeedOfSound, temp1, temp2, temp3] = ...
    AtmosphereFunction(PerformanceInputs.hc);                    % speed of sound at cruise altitude [m/s]

PerformanceInputs.M    = ...
    PerformanceInputs.V / PerformanceInputs.cruiseSpeedOfSound;  % cruise velocity [Mach]. 

%% GEOMETRY PARAMETERS
GeometryInputs.df          = 2;       % Fuselage Diameter [m]
GeometryInputs.AR          = 8.989;     % wing aspect ratio
GeometryInputs.WingSweep   = 9.519;    % wing sweep, Lambda (LE) [deg]
GeometryInputs.HtSweep     = 21.34;      % horizontal tail sweep angle [deg]
GeometryInputs.VtSweep     = 45;      % vertical tail sweep angle [deg]
GeometryInputs.thick2chord = 0.12;    % wing thickness-to-chord ratio
GeometryInputs.t2c_ht      = 0.14;     % horizontal tail thickness-to-chord ratio
GeometryInputs.t2c_vt      = 0.1;     % vertical tail thickness-to-chord ratio
GeometryInputs.TR          = 0.33;     % wing taper ratio
GeometryInputs.FinessRatio = 7;      % fuselage finess ratio

GeometryInputs.Swetfus     = 69.93;    % Fuselage wetted area [m^2]

GeometryInputs.AR_ht       = 6.4;     % horizontal tail aspect ratio
% GeometryInputs.AR_vt       = 1.3;     % vertical tail aspect ratio

GeometryInputs.AR_vt       = 0.909;     % vertical tail aspect ratio
GeometryInputs.TR_ht       = 0.5;    % horizontal tail taper ratio
GeometryInputs.TR_vt       = 0.9346;    % vertical tail taper ratio CLOSE VALUE
GeometryInputs.k           = imperial2metric(2.08e-5, 'ft');    % Skin roughness value [m] (Assume smooth paint)
GeometryInputs.A_max       = imperial2metric((0.25*pi*(6.25^2)), 'ft^2');         % fuselage maximum cross sectional area [m^2]
% GeometryInputs.A_max       = pi;    % fuselage maximum cross sectional area [m^2]
GeometryInputs.Q_fuse      = 1;     % Fuselage-Nacelle interference factor
GeometryInputs.Q_wing      = 1.3;     % Wing-Nacelle interference factor
GeometryInputs.Q_nacel     = 1.3;       % Nacelle-Wing interference factor 
GeometryInputs.Q_ht        = 1.04;    % Horizontal tail interference factor
GeometryInputs.Q_vt        = 1.04;    % Vertical tail interference factor 
GeometryInputs.upsweep     = 5;       % Upsweep angle of tail [deg]
GeometryInputs.TR_vt       = .9346;    % vertical tail taper ratio
GeometryInputs.k           = imperial2metric(2.08e-5, 'ft');    % Skin roughness value [m]
GeometryInputs.A_max       = imperial2metric((0.25*pi*(6.25^2)), 'ft^2');         % fuselage maximum cross sectional area [m^2]
GeometryInputs.Q_fuse      = 1.4;     % Fuselage-Nacelle interference factor
GeometryInputs.Q_wing      = 1.2;     % Wing-Nacelle interference factor
GeometryInputs.Q_nacel     = 1.2;     % Nacelle-Wing interference factor 
GeometryInputs.Q_ht        = 1.05;    % Horizontal tail interference factor
GeometryInputs.Q_vt        = 1.05;    % Vertical tail interference factor 
GeometryInputs.upsweep     = 5;       % Upsweep angle of tail [deg]
GeometryInputs.L_nacel     = 3.3;       % Nacelle length [m]
GeometryInputs.D_nacel     = 1.3;       % Nacelle diamater (m)

%% CONFIGURATION PARAMETERS
% These parameters and their default values are listed in the LayoutFunction.m file

%% AERODYNAMIC PARAMETERS
AeroInputs.Clmax   = 2.1;                % maximum lift coefficient

%% PROPULSION PARAMETERS
PropulsionInputs.num_eng = 2;               % number of engines
PropulsionInputs.SFCc    = 0.4 / 3600;     % Specific Fuel Consumption @ cruise [1/hr] convert to [1/s]
PropulsionInputs.SFCl    = 0.4 / 3600;     % Specific Fuel Consumption @ loiter [1/hr] convert to [1/s]
% PropulsionInputs.BPR    = 5.5;               % Engine-Bypass Ratio

%% PAYLOAD PARAMETERS
PayloadInputs.crewnum    = 2;                                % number of crew members (pilots)
PayloadInputs.paxweight  = imperial2metric(270,'lb');        % passenger weight (including luggage) [lbs] convert 2 [kg]
PayloadInputs.crewweight = imperial2metric(240,'lb');        % crew member weight (including luggage) [lbs] convert 2 [kg]

paxweight  = PayloadInputs.paxweight.*MissionInputs.pax;      % weight of passengers (including luggage) [kg]
crewweight = PayloadInputs.crewweight*PayloadInputs.crewnum;  % weight of each crew member [kg]
PayloadInputs.w_payload  = crewweight + paxweight;            % total payload weight

%% AGGREGATED INPUTS FOR AIRCRAFT SIZING
inputs.MissionInputs     = MissionInputs;
% inputs.EconMission       = EconMission;   % What is EconMission for?
inputs.PerformanceInputs = PerformanceInputs;
inputs.GeometryInputs    = GeometryInputs;
inputs.PayloadInputs     = PayloadInputs;
inputs.PropulsionInputs  = PropulsionInputs;
inputs.AeroInputs        = AeroInputs;

%% SIZE AIRCRAFT
SizingOutput = SizingIterations(inputs);

%% ECONOMIC MISSION ANALYSIS
%EconMissionOutput = EconMissionFunction(SizingOutput);
   
%% PERFORMANCE ANALYSIS
%PerformanceOutput = PerformanceFunction(SizingOutput);
   
%% ACQUISITION COST ANALYSIS
%AqCostOutput = AcquisitionCostFunction(SizingOutput);
   
%% OPERATING COST ANALYSIS  
%OpCostOutput = OperatingCostFunction(SizingOutput,AqCostOutput,EconMissionOutput);
  
%% DISPLAY RESULTS
FinalOutput              = SizingOutput;

%FinalOutput.AqCostOutput = AqCostOutput;
%FinalOutput.OpCostOutput = OpCostOutput;

ReportFunction(FinalOutput);





