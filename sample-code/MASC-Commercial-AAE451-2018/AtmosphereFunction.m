% FUNCTION THAT COMPUTES SPEED OF SOUND, DENSITY, VISCOSITY, AT ALTITUDE h
  function [a,mu,rho] = AtmosphereFunction(h)
  
  Ts = 518.69;                % temperature (absolute) at sea-level [deg. R]
  Ps = 2116.2;                % pressure at sea-level [lb/ft^2]
  R= 1716;                    % gas-constant
  Th = -0.00356;              % temperature gradient [deg/ft]
  rhos = 0.00237691267925741; % sea-level air density [slug/ft^3]
  g = 32.2;                   % gravitational constant
  Pt = 472.7;

  if h < 36152
      T = Ts + Th*(h-0);
      P = Ps * (T/Ts)^(-g/(Th*R));
      rho = P/(R*T);
      mu = 0.3170 * (T^1.5) * (734.7/(T + 216)) * (10^(-10)); 
      a = (1.4*R*T)^.5;
  else
      T = Ts + (Th * 36152);
      P = Pt * exp((-g/(R*T))*(h-36152));
      rho = P/(R*T);
      mu = 0.3170 * (T^1.5) * (734.7/(T + 216)) * (10^(-10)); 
      a = (1.4*R*T)^.5;
  end