% This function estimates fuel weight  for cruise.         % 
% It assumes CONSTANT ALTITUDE and MACH NUMBER for cruise. %
% Hence, L/D is assumed to be constant (for given altitude %
% and mach number).                                        %
% See Raymer Ch.3 equations 3.5 and 3.6                    %
% Outputs:                                                 %
%   Cruise fuel weight fraction                            %
%   Cruise fuel weight                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [output, inputs] = CruiseFunction(inputs,Wo)

    %% Inputs for cruise fuel computations
    Range  = inputs.MissionInputs.R;                    % aircraft design range [nmi] converted to [m]
    SFCc  = inputs.PropulsionInputs.SFCc;               % specific fuel consumption -cruise [1/hr] converted to [1/s]
    
      %% Additional inputs needed for cruise segment analysis
    inputs.Aero.V = inputs.PerformanceInputs.V;        % cruise velocity [knots] converted to [m/s]
    inputs.Aero.h = inputs.PerformanceInputs.hc;       % cruise altitude [ft] converted to [m]
    
    %%
    %% Parasite drag computation

    % --->(MODIFICATION REQUIRED) TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    inputs.Aero.Cdo = ParasiteDragFunction(inputs, inputs.Aero.h);    % Parasite Drag Coefficient, Cdo
    inputs.Aero.cruise.Cdo = inputs.Aero.Cdo;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END) 

    % --->(MAY REQUIRE MODIFICATION) TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    inputs.Aero.e0  = OswaldEfficiency(inputs);        % Oswald Efficiency Factor, e0
    inputs.Aero.cruise.e0 = inputs.Aero.e0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END) 


  

    %% Cruise fuel computation  
    V     = inputs.Aero.V;                           % cruise velocity [knots] converted to [m/s]
    Wf    = Wo;                                      % initialize aircraft weight for cruise computation [lbs] converted to [kg]
    segs  = 9;                                       % number of cruise segments
    Range_seg = round(Range/segs);                   % length of each cruise segment [nmi] converted to [m]

    for i = 1:segs
        Wi = Wf                                            % weight at beginning of cruise segment
        [Cdi,CL]    = InducedDragFunction(inputs,Wi)       % induced drag and lift coefficients

        %<**Compressibility Drag is ignored>
        CD          = inputs.Aero.cruise.Cdo.Cdo + Cdi                % total drag coefficient 

        LDrat       = CL/CD                                % lift-to-drag ratio during segment
        fc          = exp(-Range_seg*SFCc/LDrat/V)          % cruise fuel fraction
        Wf          = Wi*fc;                                % final aircraft weight after cruise [lbs] converted to [kg]
    end
    output.f_cr     = Wf/Wo;                              % cruise fuel-weight ratio (for entire mission)
    output.fuel     = (Wo-Wf);                            % total cruise fuel [lbs] converted to [kg]
    
    % remove field 
    inputs.Aero = rmfield(inputs.Aero, 'Cdo');
end
  
  
