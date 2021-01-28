
%% Function that computes the fuel and takeoff weight for different economic missions
% The approach is similar to the aircraft sizing routine, but with the
% exception that the empty weight of the aircraft is fixed (already known)
% The economic mission is assumed to be:
%
%              ______cruise_____
%             /                 \ descend
%            /                   \___
%           /climb                \_/ loiter
%          /                        \ 
%_________/                          \_____ 
%taxi & TO                          landing & taxi
%
% Additional mission segments can be added but this function must be
% changed to accomodate these.
function output = EconMissionFunction_elec(inputs)

inputs.MissionInputs.R = inputs.EconMission.range;  % RANGE
PW = inputs.PerformanceInputs.PW;                   % POWER-TO-WEIGHT RATIO [hp/lbs]
eta_e     = inputs.PropulsionInputs.eta_e;          % ELECTRIC efficiency BATTERY TO SHAFT
Esb       = inputs.PerformanceInputs.Esb;                                    % (W-hr)/kg

%% Start Aircraft Sizing Iterations
TOGW_temp = 18000;      % guess of takeoff gross weight [lbs] 
tolerance = 0.001;       % sizing tolerance
diff      = tolerance+1; % initial tolerance gap

while diff > tolerance
   inputs.Sizing.TOGW_temp = TOGW_temp;             % store initial gross weight
   W0                      = TOGW_temp;             % initial gross weight for current iteration [lbs]
   Wb = 0;
%% Begin estimation of weight components (empty, fuel, and total weights)

  
% Warm-up and Takeoff segment BATT weight fraction
  t_to                = 11/60; % TIME TO WARMUP (10MIN) + T/O (1MIN) [hr] 
  WarmupTakeoff_Wb    = (745.7*(PW*W0)*t_to/(eta_e*Esb))*2.205; % BATTERY WEIGHT [lbs]

% Climb segment BATT weight fraction
  t_climb             = 8/60; % TIME TO CLIMB (8MIN) [hr] 
  Climb_Wb            = (745.7*(PW*W0)*t_climb/(eta_e*Esb))*2.205;  % BATTERY WEIGHT [lbs]
 
% Cruise segment BATT weight fraction
  CruiseOutput        = CruiseFunction_elec(inputs,W0);
  Cruise_Wb           = CruiseOutput.batt;           % BATTERY WEIGHT [lbs]         
  
% Loiter segment BATT weight fraction
  LoiterOutput        = LoiterFunction_elec(inputs,W0);
  Loiter_Wb           = LoiterOutput.batt;          % BATTERY WEIGHT [lbs]
  
% Landing and taxi BATT weight fraction
  t_land              = 10/60; % TIME TO CLIMB (10MIN) [hr] 
  LandingTaxi_Wb      = (745.7*(PW*W0)*t_land/(eta_e*Esb))*2.205;   %[lbs]

%% Compute new weights based on results of current iteration  
% Total BATT weight fraction (including trapped BATT of 5%)

  Wbatt     = WarmupTakeoff_Wb + Climb_Wb + Cruise_Wb + Loiter_Wb + LandingTaxi_Wb;                        % Total BATT weight [lbs] (Overestimates - used scaling factor)
  BWF       = Wbatt/W0;  % BATT  weight fraction
  
% Aircraft Takeoff Gross Weight Weight (TOGW) [lbs]: Wempty+Wpayload+WBATT  
  TOGW      = inputs.EmptyWeight.We + inputs.PayloadInputs.w_payload + Wbatt;  
  
% Compute convergence criteria & set-up for next iteration   
  diff      = abs(TOGW_temp - TOGW);
  TOGW_temp = TOGW;                  
  TOGW      = 0; 
end
TOGW = TOGW_temp;     % Aircraft takeoff gross weight [lbs]

%% OUTPUTS
output.Wbatt = Wbatt; % mission fuel weight [lbs]
output.Wto   = TOGW;  % mission takeoff gross weight [lbs]

