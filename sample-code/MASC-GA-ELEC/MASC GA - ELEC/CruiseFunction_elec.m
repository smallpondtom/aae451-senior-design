% This function estimates fuel weight  for cruise.         % 
% It assumes CONSTANT ALTITUDE and MACH NUMBER for cruise. %
% Hence, L/D is assumed to be constant (for given altitude %
% and mach number).                                        %
% See Raymer Ch.3 equations 3.5 and 3.6                    %
% Outputs:                                                 %
%   Cruise batt weight fraction                            %
%   Cruise batt weight                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = CruiseFunction_elec(inputs,Wo)

%% Inputs for cruise fuel computations
Range  = inputs.MissionInputs.R;                    % aircraft design range [nmi]
eta_p  = inputs.PropulsionInputs.eta_p;             % propeller efficiency
eta_e  = inputs.PropulsionInputs.eta_e;             % ELECTRIC efficiency BATTERY TO SHAFT

%% Parasite drag computation
 inputs.Aero.Cdo = ParasiteDragFunction(inputs);    % Parasite Drag Coefficient, Cdo
 inputs.Aero.e0  = OswaldEfficiency(inputs);        % Oswald Efficiency Factor, e0

%% Additional inputs needed for cruise segment analysis
 inputs.Aero.V = inputs.PerformanceInputs.V;        % cruise velocity [knots]
 inputs.Aero.h = inputs.PerformanceInputs.hc;       % cruise altitude [ft]
 
%% Cruise fuel computation  
    Esb = inputs.PerformanceInputs.Esb;                                                              % (W-hr)/kg                                        
    [Cdi,CL]    = InducedDragFunction(inputs,Wo);                           % induced drag and lift coefficients
    CD          = inputs.Aero.Cdo + Cdi;                                    % total drag coefficient
    LDrat       = CL/CD                                                    % lift-to-drag ratio during segment
    Wb          = (2.725*(Wo/2.205)*(Range/0.54) / (eta_e*eta_p*Esb*LDrat))*2.205   % BATT MASS NEEDED FOR RANGE [lbs]
    output.b_cr = Wb/Wo;                                                % cruise batt-weight ratio (for entire mission)
    output.batt = Wb;                                              % total cruise batt [lbs]
end
  
  
