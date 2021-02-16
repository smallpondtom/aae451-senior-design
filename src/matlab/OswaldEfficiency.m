% Function that estimates the Oswald Efficiency Factor
% Simplest approach presented in Raymer Ch.12 Section 12.6.
% Recommended to modify for more accuracy between different designs.
function e0 = OswaldEfficiency(inputs)

%% Inputs
TR     = inputs.GeometryInputs.TR;               % wing taper ratio
df     = inputs.LayoutOutput.df;                 % fuselage diameter [ft]
AR     = inputs.GeometryInputs.AR;               % wing aspect  ratio
Lambda = inputs.GeometryInputs.WingSweep*pi/180; % wing sweep [rad]
b      = inputs.GeometryOutput.b;                % wing span [ft]
Cdo    = inputs.Aero.Cdo;                        % Parasite drag coefficient
%%
%%

% --->(MAY REQUIRE MODIFICATION)

% Raymer Ch. 12 Eq. 12.49 Page 299
% For STRAIGHT wing 
% if we are going to use a swept wing we have to reference the equation
% from Raymer Ch. 12 12.50 on Page 299

e0 = 1.78*(1-0.045*AR^0.68)-0.64;

% <---(END)
end