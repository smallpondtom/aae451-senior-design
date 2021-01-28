
%% Function that sizes the aircraft for the given input parameters
% The approach follows Raymer Ch.6
% The design mission is assumed to be:
%
%              ______cruise_____
%             /                 \ descend
%            /                   \___
%           /climb                \_/ loiter
%          /                        \ 
%_________/                          \_____ 
%taxi & TO                          landing & taxi
%
% Note that no reserve segment is present here. 
% Additional mission segments can be added but this function must be
% changed to accomodate these.
%%
function FinalOutput = SizingIterations_elec(inputs)

%% Start Aircraft Sizing Iterations
TOGW_temp = 20000;                           % guess of takeoff gross weight [lbs] 
tolerance = 0.1;                            % sizing tolerance [lbs]
diff      = tolerance+1;                    % initial tolerance gap [lbs]
eta_e     = inputs.PropulsionInputs.eta_e;  % ELECTRIC efficiency BATTERY TO SHAFT
Esb       = inputs.PerformanceInputs.Esb;                            % (W-hr)/kg
PW = inputs.PerformanceInputs.PW;           % POWER-TO-WEIGHT RATIO [hp/lbs]

while diff > tolerance
   inputs.Sizing.Power     = TOGW_temp*inputs.PerformanceInputs.PW; % compute total power (based on P/W)
   inputs.Sizing.TOGW_temp = TOGW_temp;                             % store initial gross weight
   W0                      = TOGW_temp;                             % initial gross weight for current iteration
   inputs.Sizing.W0        = W0;

%% Begin estimation of weight components (empty, BATT, and total weights)

% Generate internal layout data
  inputs.LayoutOutput   = LayoutFunction(inputs);

% Generate geometry data
  inputs.GeometryOutput = GeometryFunction(inputs);

% Compute Empty weight and empty weight fraction
  EmptyWeightOutput     = EmptyWeightFunction(inputs);  
  
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
  TOGW      = EmptyWeightOutput.We + inputs.PayloadInputs.w_payload + Wbatt;  
  
% Compute convergence criteria & set-up for next iteration   
  diff      = abs(TOGW_temp - TOGW);
  TOGW_temp = TOGW;                  
  TOGW      = 0; 
end

% EmptyWeightOutput
TOGW = TOGW_temp;                  % Aircraft takeoff gross weight [lbs]
EWF  = EmptyWeightOutput.We/TOGW;  % Empty weight fraction

%% Aggregate results
FinalOutput             = inputs;
FinalOutput.EmptyWeight = EmptyWeightOutput;
FinalOutput.TOGW        = TOGW;
FinalOutput.Wbatt       = Wbatt;
FinalOutput.Power       = inputs.Sizing.Power;
end