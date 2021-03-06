%% Fuction that computes Induced drag coefficient

function [Cdi,CL] = InducedDragFunction(inputs,Wi)

%% Inputs
  Sw = inputs.GeometryOutput.Sw; % Planform wing area [ft^2] converted to [m^2]
  AR = inputs.GeometryInputs.AR; % Wing Aspect ratio
  e0 = inputs.Aero.e0;           % Oswald Efficiency Factor
  V  = inputs.Aero.V;            % Velocity [knots] converted to [m/s]
  h  = inputs.Aero.h;            % Altitude [ft] coverted to [m]
%%

% % Units conversion [knots -> ft/sec]
% 
%   v = V*1.68781;
  
% Atmosphere at loiter altitude (speed of sound, viscosity, density)
  [a,rho,p,t] = AtmosphereFunction(h);

% Dynamic pressure
  q = 0.5*rho*V^2;  % [N/m^2] or [Pa]

% Lift Coefficient for flight conditions
  CL = Wi*9.81/q/Sw;

% Induced Drag Coefficient 
  Cdi = CL^2./(pi*AR*e0);    
  
end
  