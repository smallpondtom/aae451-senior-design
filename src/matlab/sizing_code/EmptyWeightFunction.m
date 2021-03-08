%This function estimates the empty of the aircraft, following the same     % 
%approach used in the excel "simple" and "initial" sizing sheets.          %
%Recommended to perform an empty weight build-up by estimating the weight  % 
% of all the aircraft component (groups).                                  %
% See Raymer Ch.15 Eq. 15.25 - 15.45 for alternative ways to compute       %
% component weights                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --->(MODIFICATION COMPLETED 2/16/2021) TOMO
%  ---(WAITING FOR REVIEW)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
    WE MUST COME UP WITH A We/Wo function using Curve Fitting for existing 
    aircrafts that are similar to ours.
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% <---(END)

function output = EmptyWeightFunction(inputs)

    AR        = inputs.GeometryInputs.AR;               % wing aspect ratio
    TW        = inputs.PerformanceInputs.TW;            % thrust-to-weight ratio [N/N]
    WS        = inputs.PerformanceInputs.WS;            % wing loading [kg/m^2]
    Vmax      = 1.07*inputs.PerformanceInputs.V;        % Vmax = 7% higher than cruise speed [m/s] 
    W_dg      = inputs.Sizing.TOGW_temp;                % Design gross weight [kg]			


    % Empty weight [kg]
    % Equation created by our own curve fitting 
    % see file "wer_curve_fit.ipynb" in /src/python
    
    % Coefficients from the curve fit
    %original numbers
%     a = -0.93406157;
%     b = 3;
%     c = -0.07269635;
%     d = 0.00401527;
%     e = -0.09722277;
%     f = 0.0290933;
%     g = -0.05112156;
%     copy1
%     a = 0.00812223;
%     b = 2.99999975;
%     c = -0.19810052;
%     d = -0.05997703;
%     e = 0.03556749;
%     f = 0.12704642;
%     g = -0.06972984;
%     copy2
    a = -0.49109324;
    b = 2.99999998;
    c = 0.28234368;
    d = 0.47475339;
    e = -0.04233889;
    f = -0.18632609;
    g = -0.6257303;

    % Empty weight fraction We / Wo
    output.fe = a + b*W_dg^c * AR^d * TW^e * WS^f * Vmax^g;  
    % Empty weight
    output.We = output.fe*inputs.Sizing.TOGW_temp; 

end
