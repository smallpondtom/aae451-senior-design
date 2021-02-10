%This function estimates the empty of the aircraft, following the same     % 
%approach used in the excel "simple" and "initial" sizing sheets.          %
%Recommended to perform an empty weight build-up by estimating the weight  % 
% of all the aircraft component (groups).                                  %
% See Raymer Ch.15 Eq. 15.25 - 15.45 for alternative ways to compute       %
% component weights                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = EmptyWeightFunction(inputs)

    AR        = inputs.GeometryInputs.AR;               % wing aspect ratio
    TW        = inputs.PerformanceInputs.TW;            % thrust-to-weight ratio [lb/lb]
    WS        = inputs.PerformanceInputs.WS;            % wing loading [lbs/ft^2]
    Mmax      = 1.07*inputs.PerformanceInputs.M;        % Mmax = 5% higher than cruise mach 
    W_dg      = inputs.Sizing.TOGW_temp;                % Design gross weight [lb]			


    % Empty weight [lbs]
    % Raymer "jet transporter", Table 6.1
    % assumes fixed sweep
    output.We = (0.32+0.66*W_dg^(-0.13)*AR^(0.30)*TW^(0.06)*WS^(-0.05)*Mmax^(0.05))*W_dg;  
    % Empty weight fraction
    output.fe = output.We/inputs.Sizing.TOGW_temp; 

end
