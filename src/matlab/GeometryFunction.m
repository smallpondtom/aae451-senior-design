%% This function analyzes the aircraft geometry %%%
% Outputs:                                        %
%   Wing span                                     %
%   Mean Aerodynamic Chord (MAC)                  %
%   Wing planform area                            %
%   H-tail planform area                          %
%   V-tail planform area                          %
%   Wing wetted area                              %
%   H-tail wetted area                            %
%   V-tail wetted area                            %
%   Fuselage wetted area                          %
%   Engine wetted area                            %
%   Aircraft wetted area                          %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
function [output] = GeometryFunction(inputs)

    %% INPUTS
    Wt          = inputs.Sizing.TOGW_temp;                 % Takeoff gross weight [lbs]
    WingLoading = inputs.PerformanceInputs.WS;             % Wing loading [lbs/ft^2]
    M           = inputs.PerformanceInputs.M;              % Cruise mach number
    num_eng     = inputs.PropulsionInputs.num_eng;         % Number of engines
    T_eng       = inputs.PerformanceInputs.TW * Wt;        % Engine Thrust

    AR          = inputs.GeometryInputs.AR;                % Wing aspect ratio
    TR          = inputs.GeometryInputs.TR;                % Wing taper ratio
    lf          = inputs.LayoutOutput.lf;                  % Fuselage length [ft]
    df          = inputs.LayoutOutput.df;                  % Fuselage diameter [ft]


    %%
    %% Wing geometry computations (See Raymer Ch.7 Eq. 7.5-7.8)
    Sw          = Wt/WingLoading;                          % Wing planform area [ft^2]
    b           = sqrt(AR*Sw);                             % Wing span [ft]
    MAC         = ((1+TR+(TR^2))/(1+TR)^2)*(Sw/b)*(4/3);   % Mean aerodynamic chord of wing

    %  -->(MODIFIED) BY TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % From Raymer Ch.7 Eq. 7.10 & 7.11
    TC          = inputs.GeometryInputs.thick2chord;
    if TC < 0.05
        Swetwing    = 2.003*Sw;                            % Wing wetted area [ft^2]
    else
        Swetwing    = Sw * [1.977 + 0.52 * TC];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  <--(END)

    Swetwing    = 2*Sw*1.02;                               % Wing wetted area [ft^2] <-- Original 

    %%
    %% Internal parameters (Based on Raymer Ch.6 Table 6.4 Jet transport Page 112)
    Cht         = 1.00;       % Horizontal-tail volume coefficient
    Cvt         = 0.09;       % Vertical-tail volume coefficient

    %% Fuselage wetted computations
    % need to be checked for source
    fr          = inputs.GeometryInputs.FinessRatio;       % fuselage finess ratio
    Swetfus     = pi*df*lf*(1-2/fr)^(2/3)*(1+1/fr^2);      % wetted area of fuselage [ft^2]

    %% Tails geometry computations (Based on Raymer Ch.6 Eq. 6.28-6.29)

    % --->(REQUIRE MODIFICATION) TOMO 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    H_loc       = 0.45;                                    % Location of H-tail as a fraction of fuselage length
    V_loc       = 0.45;                                    % Location of V-tail as a fraction of fuselage length
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)

    Lht         = H_loc*lf;                                % H-tail moment arm [ft]
    Lvt         = V_loc*lf;                                % V-tail moment arm (for engines on wing) [ft]
    Sv          = Cvt*b*Sw/Lvt;                            % V-tail surface area [ft^2]
    Sh          = Cht*MAC*Sw/Lht;                          % H-tail surface area [ft^2]
    Sweth       = 2*Sh*1.02;                               % H-tail wetted area [ft^2]
    Swetv       = 2*Sv*1.02;                               % V-tail wetted area [ft^2]

    %% Engine geometry computations (based on Raymer EQs 10.1-10.2)

    % --->(REQUIRE MODIFICATION) TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Change the engines specifically for our design

    %Nonafterburning engines
    Le_actual = 287/12;								% GE-90 engine length   [ft]
    De_actual = 123/12;								% GE-90 engine diameter [ft]
    T_actual = 115300;							    % GE-90 engine thrust @ takeoff [lb]
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)

    SF = T_actual/T_eng;	   						% engine scale factor (Actual Thrust/Req Thrust)
    le = Le_actual*(SF)^0.4;                        % engine length [ft]
    de = De_actual*(SF)^0.5;                        % engine diameter [ft]

    Sweteng     = pi*de*le*num_eng;                 % wetted area of engines [ft^2]

    %% Total wetted area computation
    Swet        = Swetwing+Swetfus+Swetv+Sweth+Sweteng;    % total wetted area of aircraft [ft^2]

    %% Function Outputs
    output.b       = b;
    output.MAC     = MAC;
    output.Sv      = Sv;
    output.Sh      = Sh;
    output.Sw      = Sw;
    output.Swetfus = Swetfus;
    output.Sweteng = Sweteng;
    output.Swet    = Swet;
end


  
  
  