
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
function FinalOutput = SizingIterations(inputs)

%% Start Aircraft Sizing Iterations
TOGW_temp = 911000;        % guess of takeoff gross weight [lbs] 
tolerance = 0.1;           % sizing tolerance [lbs]
diff      = tolerance+1;   % initial tolerance gap [lbs]

while diff > tolerance
  inputs.Sizing.Thrust     = TOGW_temp*inputs.PerformanceInputs.TW;  % compute total thrust (based on T/W)
  inputs.Sizing.TOGW_temp  = TOGW_temp;                              % store initial gross weight
  W0                       = TOGW_temp;                              % initial gross weight for current iteration
  inputs.Sizing.W0         = W0;
  %% Begin estimation of weight components (empty, fuel, and total weights)

  % Generate internal layout data
  inputs.LayoutOutput   = LayoutFunction(inputs);

  % Generate geometry data
  inputs.GeometryOutput = GeometryFunction(inputs); 
  % Compute Empty weight and empty weight fraction
  EmptyWeightOutput     = EmptyWeightFunction(inputs);  
  
  %%
  % Warm-up and Takeoff segment fuel weight fraction
  WarmupTakeoffOutput = WarmupTakeoffFunction(inputs);
  f_to                = WarmupTakeoffOutput.f_to;   % warm-up and takeoff fuel weight fraction
  W1                  = TOGW_temp*f_to;             % aircraft weight after warm-up and takeoff [lbs]
  % Climb segment fuel weight fraction
  ClimbOutput         = ClimbFunction(inputs);
  f_cl                = ClimbOutput.f_cl;           % climb fuel weight fraction
  W2                  = W1*f_cl;                    % aircraft weight after climb segment [lbs]
  % Cruise segment fuel weight fraction
  CruiseOutput        = CruiseFunction(inputs,W2);
  f_cr                = CruiseOutput.f_cr;          % cruise fuel weight fraction
  W3                  = W2*f_cr;                    % aircraft weight after cruise segment [lbs]
  % Loiter segment fuel weight fraction
  LoiterOutput        = LoiterFunction(inputs,W3);
  f_lt                = LoiterOutput.f_lt;          % loiter fuel weight segment
  W4                  = W3*f_lt;                    % aircraft weight after loiter segment [lbs]
  % Landing and taxi fuel weight fraction
  LandingTaxiOutput   = LandingTaxiFunction(inputs);
  f_lnd               = LandingTaxiOutput.f_lnd;    % landing and taxi fuel weight segment
  W5                  = W4*f_lnd;                   % aircraft weight after landing & taxi segment [lbs]

  %% Compute new weights based on results of current iteration  
  % Total fuel weight fraction (including trapped fuel of 5%)

  FWF       = 1.01*(1- f_to*f_cl*f_cr*f_lt*f_lnd);  % Fuel weight fraction 
  Wfuel     = FWF*TOGW_temp;                        % Total fuel weight [lbs] (Overestimates - used scaling factor)
  
  % Aircraft Takeoff Gross Weight Weight (TOGW) [lbs]: Wempty+Wpayload+Wfuel  
  TOGW      = EmptyWeightOutput.We + inputs.PayloadInputs.w_payload + Wfuel;  
  
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
FinalOutput.Wfuel       = Wfuel;
FinalOutput.Thrust       = inputs.Sizing.Thrust;
end