% This function performs fuel weight estimation for loiter % 
% It assumes CONSTANT ALTITUDE and MACH NUMBER for cruise. %
% Hence, L/D is assumed to be constant (for given altitude %
% and mach number.                                         %
% See Raymer Ch.3 equations 3.7 and 3.8                    %
% Outputs:                                                 %
%   Loiter fuel weight fraction                            %
%   Loiter fuel weight                                     %    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = LoiterFunction_elec(inputs,Wi)

%% Inputs for loiter fuel computations
time   = inputs.MissionInputs.loiter_time;           % Loiter time [hours]
eta_p  = inputs.PropulsionInputs.eta_p;              % propeller efficiency
eta_e  = inputs.PropulsionInputs.eta_e;             % ELECTRIC efficiency BATTERY TO SHAFT

%% Parasite drag computation
 inputs.Aero.Cdo = ParasiteDragFunction(inputs); % Parasite Drag Coefficient, Cdo
 inputs.Aero.e0  = OswaldEfficiency(inputs);     % Oswald Efficiency Factor, e0
 
%% Additional inputs needed for cruise segment analysis
 inputs.Aero.V = inputs.PerformanceInputs.Vlt;   % Loiter velocity [knots]
 inputs.Aero.h = inputs.PerformanceInputs.hlt;   % Loiter altitude [ft]
 
  V =  inputs.Aero.V;                            % Loiter velocity [knots]
 
%% loiter fuel computation  
    Esb = inputs.PerformanceInputs.Esb;                                                              % (W-hr)/kg                                        
    [Cdi,CL]    = InducedDragFunction(inputs,Wi);                           % induced drag and lift coefficients
    CD          = inputs.Aero.Cdo + Cdi;                                    % total drag coefficient
    LDrat       = CL/CD;                                                    % lift-to-drag ratio during segment
    Wb = (2.725*(Wi/2.205)*(V/0.54)*time / (eta_e*eta_p*Esb*LDrat))*2.205;  % BATT MASS NEEDED FOR RANGE [lbs]
    output.b_lt     = Wb/Wi;                                                % loiter batt-weight ratio (for entire mission)
    output.batt     = Wb;                                              % total loiter batt [lbs]
end




    
