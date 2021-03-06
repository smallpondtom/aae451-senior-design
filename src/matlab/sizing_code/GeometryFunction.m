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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
function [output] = GeometryFunction(inputs)

    %% INPUTS
    Wt          = inputs.Sizing.TOGW_temp;                 % Takeoff gross weight [lbs] converted to [kg]
    WingLoading = inputs.PerformanceInputs.WS;             % Wing loading [lbs/ft^2] converted to [kg/m^2]
    M           = inputs.PerformanceInputs.M;              % Cruise mach number
    num_eng     = inputs.PropulsionInputs.num_eng;         % Number of engines
    T_eng       = inputs.PerformanceInputs.TW * Wt;        % Engine Thrust

    AR          = inputs.GeometryInputs.AR;                % Wing aspect ratio
    AR_ht       = inputs.GeometryInputs.AR_ht;             % Horizontal tail aspect ratio
    AR_vt       = inputs.GeometryInputs.AR_vt;             % Vertical tail aspect ratio
    TR          = inputs.GeometryInputs.TR;                % Wing taper ratio
    TR_ht       = inputs.GeometryInputs.TR_ht;             % Horizontal tail taper ratio
    TR_vt       = inputs.GeometryInputs.TR_vt;             % Vertical tail taper ratio
    lf          = inputs.LayoutOutput.lf;                  % Fuselage length [ft] converted to [m]
    df          = inputs.LayoutOutput.df;                  % Fuselage diameter [ft] converted to [m]
    ln          = inputs.GeometryInputs.L_nacel;           % Nacelle length [m]
    dn          = inputs.GeometryInputs.D_nacel;           % Nacelle diameter [m]

    %%
    %% Wing geometry computations (See Raymer Ch.7 Eq. 7.5-7.8)
    Sw          = Wt/WingLoading;                          % Wing planform area [ft^2] converted to [m^2]
    b           = sqrt(AR*Sw);                             % Wing span [ft] converted to [m]
    MAC         = ((1+TR+(TR^2))/(1+TR)^2)*(Sw/b)*(4/3);   % Mean aerodynamic chord of wing [m]

    %  -->(MODIFIED) BY TOMO & DEREK
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % From Raymer Ch.7 Eq. 7.10 & 7.11
    
    TC          = inputs.GeometryInputs.thick2chord;       % Wing-thickness-to-chord ratio
    if TC < 0.05
        Swetwing    = 2.003*Sw;                            % Wing wetted area [ft^2] converted to [m^2]
    else
        Swetwing    = Sw * [1.977 + 0.52 * TC];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  <--(END)

    % Swetwing    = 2*Sw*1.02;                               % Wing wetted area [ft^2] <-- Original 

    %%
    %% Internal parameters (Based on Raymer Ch.6 Table 6.4 Jet transport Page 112)
    Cht         = 1.00;       % Horizontal-tail volume coefficient
    Cvt         = 0.09;       % Vertical-tail volume coefficient

    %% Fuselage wetted computations
    % need to be checked for source
    fr         = inputs.GeometryInputs.FinessRatio;       % fuselage finess ratio

    Swetfus_chk = pi*df*lf*(1-2/fr)^(2/3)*(1+1/fr^2);      % wetted area of fuselage [ft^2] converted to [m^2]
    
    Swetfus     = inputs.GeometryInputs.Swetfus;              % wetted area of fuselage[m^]

%     fr          = inputs.GeometryInputs.FinessRatio;       % fuselage finess ratio

    %Swetfus     = pi*df*lf*(1-2/fr)^(2/3)*(1+1/fr^2);      % wetted area of fuselage [ft^2] converted to [m^2]
%     Swetfus = 69.93; %[m^2] current model from openVSP
    % --->(REQUIRE MODIFICATION) DEREK
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Nacelle wetted computations
    
    Swetn       = pi * dn * ln;                            % nacelle wetted area [m^2]
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Tails geometry computations (Based on Raymer Ch.6 Eq. 6.28-6.29)

    % --->(REQUIRE MODIFICATION) TOMO 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    H_loc       = 0.45;                                    % Location of H-tail as a fraction of fuselage length
    V_loc       = 0.45;                                    % Location of V-tail as a fraction of fuselage length
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)

    Lht         = H_loc*lf;                                % H-tail moment arm [ft] converted to [m]
    Lvt         = V_loc*lf;                                % V-tail moment arm (for engines on wing) [ft] converted to [m]
    Sv          = Cvt*b*Sw/Lvt;                            % V-tail planform area [ft^2] converted to [m^2]
    Sh          = Cht*MAC*Sw/Lht;                          % H-tail planform area [ft^2] converted to [m^2]
    Sweth       = 2*Sh*1.02;                               % H-tail wetted area [ft^2] converted to [m^2]
    Swetv       = 2*Sv*1.02;                               % V-tail wetted area [ft^2] converted to [m^2]
    
    % --->(REQUIRE MODIFICATION) DEREK 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Horizontal tail mean chord calculation
    b_ht        = sqrt(AR_ht * Sh);                                     % Calculate horizontal tail span [m]
    MC_ht       = ((1+TR_ht+(TR_ht^2))/((1+TR_ht)^2))*(Sh/b_ht)*(4/3);  % Calculate horizontal tail mean chord length [m]

    %% Vertical tail mean chord calculation
    b_vt        = sqrt(AR_vt * Sv);                                     % Calculate vertical tail span [m]
    MC_vt       = ((1+TR_vt+(TR_vt^2))/((1+TR_vt)^2))*(Sv/b_vt)*(4/3);  % Calculate vertical tail mean chord length [m]
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)
    
    %% Engine geometry computations (based on Raymer EQs 10.1-10.2)

    % --->(REQUIRE MODIFICATION) TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Change the engines specifically for our design

    %Nonafterburning engines
    Le_actual = imperial2metric(287/12,'ft');		% GE-90 engine length   [ft] convert to [m]
    De_actual = imperial2metric(123/12,'ft');		% GE-90 engine diameter [ft] convert to [m]
    T_actual = imperial2metric(115300,'lb');		% GE-90 engine thrust @ takeoff [lb] convert to [kg]
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END)

    SF = T_actual/T_eng;	   						% engine scale factor (Actual Thrust/Req Thrust)
    le = Le_actual*(SF)^0.4;                        % engine length [ft] converted to [m]
    de = De_actual*(SF)^0.5;                        % engine diameter [ft] converted to [m]

    Sweteng     = pi*de*le*num_eng;                 % wetted area of engines [ft^2] converted to [m^2]

    %% Total wetted area computation
    Swet        = Swetwing+Swetfus+Swetv+Sweth+Sweteng+Swetn;    % total wetted area of aircraft [ft^2] converted to [m^2] (add 

    %% Function Outputs
    output.b       = b;
    output.MAC     = MAC;
    output.Sv      = Sv;
    output.Sh      = Sh;
    output.Sw      = Sw;
    output.Swetfus = Swetfus;
    output.Sweteng = Sweteng;
    output.Swetwing= Swetwing;
    output.Sweth   = Sweth;
    output.Swetv   = Swetv; 
    output.Swetn   = Swetn;
    output.Swet    = Swet;
    output.b_ht    = b_ht;
    output.b_vt    = b_vt;
    output.MC_ht   = MC_ht;
    output.MC_vt   = MC_vt;
    
    output.Swetfus_chk = Swetfus_chk;
    output.Wt      = Wt;
end


  
  
  