function myu = sutherland_visc_calc(T, gas)
%% SUTHERLAND_VISC_CALC Sutherland's Viscosity Formula
%% Theory
% Sutherland's Viscosity Formula is a approximation of the viscosity depending 
% on the temperature of a certain gas.
% 
% $$\mu = \mu_{ref}(\frac{T}{T_{ref}})^{1.5}(\frac{T_{ref} + C}{T + C})$$
% 
% here, $T_{\textrm{ref}\;} =288\ldotp 15\;K=\;{15}^o \;C\;$ and $\mu_{\textrm{ref}} 
% =1\ldotp 789\times {10}^{-5} \;\;\;\;\textrm{Pa}-s$
% 
% and $C$ is the Sutherland Constant which is specific for each gas.
    if gas == "air"
        C = 120;
    elseif gas == "NH3"
        C = 370;
    elseif gas == "CO2"
        C = 240;
    elseif gas == "CO"
        C = 118;
    elseif gas == "H2"
        C = 72;
    elseif gas == "N2"
        C = 111;
    elseif gas == "O2"
        C = 127;
    elseif gas == "SO2"
        C = 416;
    else 
        disp("Error. Choose an appropriate gas.")
    end
    % Calculation
    T_ref = 288.15;  % [K]
    myu_ref = 1.789 * 10^(-5);  % [Pa-s]
    myu = myu_ref * (T / T_ref)^(1.5) * (T_ref + C) / (T + C);  % Dynamic Viscosity of gas [kg / (m * s)]
end