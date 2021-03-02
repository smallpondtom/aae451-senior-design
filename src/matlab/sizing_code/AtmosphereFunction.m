% Function that computes the speed of sound, air density, pressure, and
% temperature for a certain altitude in metric

function [a,rho,p,T] = AtmosphereFunction(h)
    % http://fisicaatmo.at.fcen.uba.ar/practicas/ISAweb.pdf
    % https://www.engineeringtoolbox.com/elevation-speed-sound-air-d_1534.html
    p0   = 101325;
    rho0 = 1.225;
    T0   = 288.15;
    a0   = 340.294;
    g0   = 9.80665;
    R    = 287.04;
    
    p11 = 22632;
    T11 = 216.65;
    h11 = 11000;
    
    if h < 11000  % troposphere
        T = T0 - 6.5*h/1000;
        p = p0*(1 - 0.0065*h/T0)^5.2561;
    elseif h < 25000  % lower stratosphere
        T = T11;
        p = p11*exp(-g0*(h - h11)/(R*T11));
    else
        error('invalid altitude: ' + num2str(h));
    end
    rho = p/(R*T);
    gamma = 1.4;
    a = sqrt(gamma*R*T);    % Speed of Sound Calculation
end