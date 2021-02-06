function consts = const_gen() 
% This is a constant generation file with all the necessary constants for 
% aircraft conceptual design 
%{
    input << 
    none

    output >>
    consts : constant structure 
%}

% Constant of Gravitation 
G = 6.67259e-11;  % N-m^2/kg^2

% Universal gas constant 
R = 287.05;  % J/kg-K

% Gravitational acceleration 
g = 9.80665;  % m/s^2