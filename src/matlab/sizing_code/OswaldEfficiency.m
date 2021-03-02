% Function that estimates the Oswald Efficiency Factor
% Simplest approach presented in Raymer Ch.12 Section 12.6.
% Recommended to modify for more accuracy between different designs.
function e0 = OswaldEfficiency(inputs)

    %% Inputs
    TR     = inputs.GeometryInputs.TR;               % wing taper ratio
    df     = inputs.LayoutOutput.df;                 % fuselage diameter [ft] converted to [m]
    AR     = inputs.GeometryInputs.AR;               % wing aspect  ratio
    Lambda = inputs.GeometryInputs.WingSweep*pi/180; % wing sweep [rad]
    b      = inputs.GeometryOutput.b;                % wing span [ft] converted to [m]
    Cdo    = inputs.Aero.Cdo.Cdo;                        % Parasite drag coefficient
    %%
    %%

    % --->(MODIFICATION COMPLETE)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Use equation from Shevell Fig. 11.8

    e0 = 0.9912 - 0.02*100*Cdo - 0.0804*AR/12 + 0.0026*(100*Cdo)^2 ...
        - 0.0831*100*Cdo*AR/12 + 0.0432*(AR/12)^2;
    
    % If there is sweep in the wing
    if Lambda ~= 0
        Z = 0.9912 + (-0.0375 - 0.0528*AR/12 - 0.0198*AR/12)*(Lambda)^2;
        e0 = Z * e0;
    end 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)
end
