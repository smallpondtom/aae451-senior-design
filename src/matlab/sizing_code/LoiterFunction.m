% This function performs fuel weight estimation for loiter % 
% It assumes CONSTANT ALTITUDE and MACH NUMBER for cruise. %
% Hence, L/D is assumed to be constant (for given altitude %
% and mach number.                                         %
% See Raymer Ch.3 equations 3.7 and 3.8                    %
% Outputs:                                                 %
%   Loiter fuel weight fraction                            %
%   Loiter fuel weight                                     %    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output, inputs] = LoiterFunction(inputs,Wi)

    %% Inputs for loiter fuel computations
    time   = inputs.MissionInputs.loiter_time;           % Loiter time [hours] converted to [s]
    SFCl  = inputs.PropulsionInputs.SFCl;                % specific fuel consumption - loiter [1/hr] converted to [1/s]
    
    %% Additional inputs needed for cruise segment analysis
    inputs.Aero.V = inputs.PerformanceInputs.Vlt;   % Loiter velocity [knots] converted to [m/s]
    inputs.Aero.h = inputs.PerformanceInputs.hlt;   % Loiter altitude [ft] converted to [m]
    
    %% Parasite drag computation

    % --->(REQUIRE MODIFICATION) TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % FUNCTIONS "ParasiteDragFunction" and "OswaldEfficiency" also
    % used in the file "CruiseFunction.m" must be modified

    inputs.Aero.Cdo = ParasiteDragFunction(inputs, inputs.Aero.h); % Parasite Drag Coefficient, Cdo
    inputs.Aero.loiter.Cdo = inputs.Aero.Cdo;
    inputs.Aero.e0  = OswaldEfficiency(inputs);     % Oswald Efficiency Factor, e0
    inputs.Aero.loiter.e0 = inputs.Aero.e0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)

   
    %% loiter fuel computation  
    [Cdi,CL]    = InducedDragFunction(inputs,Wi);   % induced drag and lift coefficients 
    CD          = inputs.Aero.loiter.Cdo.Cdo + Cdi; % total drag coefficient
    CD = CD;
    LDrat       = CL/CD;                            % lift-to-drag ratio during cruise
    fl          = exp(-time*(SFCl)/(LDrat));        % loiter fuel weight fraction
    Wf          = Wi*fl;                            % final aircraft weight after loiter segment
    output.f_lt = Wf/Wi;                            % loiter fuel-weight ratio (for entire segment)
    output.fuel = Wi-Wf;                            % total loiter fuel [lbs] converted to [kg]
    
    % remove field 
    inputs.Aero = rmfield(inputs.Aero, 'Cdo');
    inputs.Aero = rmfield(inputs.Aero, 'e0');
end




    
