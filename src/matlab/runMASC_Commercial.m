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
MissionInputs.R           = 9420;    % aircraft range [nmi]
MissionInputs.loiter_time = 0.5;     % loiter time [hours]
MissionInputs.pax         = 301;     % number of passengers   

%% ECONOMIC MISSION PARAMETERS
%EconMission.range         = 9420;    % economic mission length [nmi]

%% PERFORMANCE PARAMETERS
PerformanceInputs.TW   = 0.28;  % thrust-to-weight ratio [lb/lb]
PerformanceInputs.WS   = 142;   % wing loading [lbs/ft^2]
PerformanceInputs.V    = 480;   % cruise velocity [knots]
PerformanceInputs.M    = 0.82;  % cruise velocity [Mach]. This needs to be changed to match V at desired altitude.  Can automate this calculation with the AtmosphereFunction
PerformanceInputs.Vlt  = 200;   % loiter velocity [knots]
PerformanceInputs.nmax = 3;     % maximum load factor
PerformanceInputs.hc   = 38000; % cruise altitude [ft]
PerformanceInputs.hlt  = 5000;  % loiter altitude [ft]

%% GEOMETRY PARAMETERS
GeometryInputs.AR          = 8.7;  % wing aspect ratio
GeometryInputs.WingSweep   = 31.6; % wing sweep, Lambda (LE) [deg]
GeometryInputs.thick2chord = 0.12; % wing thickness-to-chord ratio
GeometryInputs.TR          = 0.3;  % wing taper ratio
GeometryInputs.FinessRatio = 11;   % fuselage finess ratio
        
%% CONFIGURATION PARAMETERS
% These parameters and their default values are listed in the LayoutFunction.m file

%% AERODYNAMIC PARAMETERS
AeroInputs.Clmax   = 1.6;                % maximum lift coefficient

%% PROPULSION PARAMETERS
PropulsionInputs.num_eng = 2;    % number of engines
PropulsionInputs.SFCc    = 0.50; % Specific Fuel Consumption @ cruise
PropulsionInputs.SFCl    = 0.40; % Specific Fuel Consumption @ loiter
%PropulsionInputs.BPR         = 15          % Engine-Bypass Ratio

%% PAYLOAD PARAMETERS
PayloadInputs.crewnum    = 4;          % number of crew members (pilots)
PayloadInputs.paxweight  = 230;        % passenger weight (including luggage) [lbs]
PayloadInputs.crewweight = 200;        % crew member weight (including luggage) [lbs]

paxweight  = PayloadInputs.paxweight.*MissionInputs.pax;      % weight of passengers (including luggage) [lbs]
crewweight = PayloadInputs.crewweight*PayloadInputs.crewnum;  % weight of each crew member [lbs]
PayloadInputs.w_payload  = crewweight + paxweight;            % total payload weight

%% AGGREGATED INPUTS FOR AIRCRAFT SIZING
inputs.MissionInputs     = MissionInputs;
inputs.EconMission       = EconMission;
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





