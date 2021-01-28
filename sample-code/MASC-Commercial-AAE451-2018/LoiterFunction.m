% This function performs fuel weight estimation for loiter % 
% It assumes CONSTANT ALTITUDE and MACH NUMBER for cruise. %
% Hence, L/D is assumed to be constant (for given altitude %
% and mach number.                                         %
% See Raymer Ch.3 equations 3.7 and 3.8                    %
% Outputs:                                                 %
%   Loiter fuel weight fraction                            %
%   Loiter fuel weight                                     %    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = LoiterFunction(inputs,Wi)

%% Inputs for loiter fuel computations
time   = inputs.MissionInputs.loiter_time;           % Loiter time [hours]
SFCl  = inputs.PropulsionInputs.SFCl;               % specific fuel consumption - loiter [lb/hr]
%%
%% Parasite drag computation
 inputs.Aero.Cdo = ParasiteDragFunction(inputs); % Parasite Drag Coefficient, Cdo
 inputs.Aero.e0  = OswaldEfficiency(inputs);     % Oswald Efficiency Factor, e0
 
%% Additional inputs needed for cruise segment analysis
 inputs.Aero.V = inputs.PerformanceInputs.Vlt;   % Loiter velocity [knots]
 inputs.Aero.h = inputs.PerformanceInputs.hlt;   % Loiter altitude [ft]
 
  V_ft_s =  inputs.Aero.V*1.68781;               % Loiter velocity [ft/s]
 
%% loiter fuel computation  
  [Cdi,CL]    = InducedDragFunction(inputs,Wi);  % induced drag and lift coefficients 
  CD          = inputs.Aero.Cdo + Cdi;           % total drag coefficient
  LDrat       = CL/CD;                           % lift-to-drag ratio during cruise
  fl          = exp(-time*(SFCl)/(LDrat));       % loiter fuel weight fraction
  Wf          = Wi*fl;                           % final aircraft weight after loiter segment
  output.f_lt = Wf/Wi;                           % loiter fuel-weight ratio (for entire segment)
  output.fuel = Wi-Wf;                           % total loiter fuel [lbs]
end




    
