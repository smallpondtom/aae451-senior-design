%This function estimates the empty of the aircraft, following the same     % 
%approach used in the excel "simple" and "initial" sizing sheets.          %
%Recommended to perform an empty weight build-up by estimating the weight  % 
% of all the aircraft component (groups).                                  %
% See Raymer Ch.15 Eq. 15.25 - 15.45 for alternative ways to compute       %
% component weights                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = EmptyWeightFunction(inputs)

  AR        = inputs.GeometryInputs.AR;               % wing aspect ratio
  PW        = inputs.PerformanceInputs.PW;            % power-to-weight ratio [lb/hp]
  WS        = inputs.PerformanceInputs.WS;            % wing loading [lbs/ft^2]
  Vmax      = 1.05*inputs.PerformanceInputs.V;        % Vmax = 5% higher than cruise velocity [knots]  
  W_dg      = inputs.Sizing.TOGW_temp;                % Design gross weight [lb]			


% Empty weight [lbs]
%Raymer "GA - SINGLE ENGINE", Table 6.2
  output.We = (-0.25+1.18*W_dg^(-0.20)*AR^(0.08)*PW^(0.05)*WS^(-0.05)*Vmax^(0.27))*W_dg;  
% Empty weight fraction
  output.fe = output.We/inputs.Sizing.TOGW_temp; 

end
