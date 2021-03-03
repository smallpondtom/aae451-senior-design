% Function that computes fuselage dimensions and number of crew members% 
% based on the number of passengers.                                   %
% Changes may be required based on the specific aircraft being studied.%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = LayoutFunction(inputs)

    %% Inputs
    pax = inputs.MissionInputs.pax;

    %% Aircraft layout inputs (mid-size passenger transport)
    crewnum          = 2;    % crew members (pilots)

    %% Aircraft fuselage dimensions & flight crew 

    % Fuselage Finess Ratio, lambda_fd
    lambda_f =inputs.GeometryInputs.FinessRatio;    % fuselage finess ratio

    % diameter of fuselage [ft] -> [m]
    % df = imperial2metric(20,'ft');                % aircraft fuselage diameter [ft] convert to [m]
    df = inputs.GeometryInputs.df;                % aircraft fuselage diameter [ft] convert to [m]
      
    % length of fuselage [ft] -> [m]  
    lf = lambda_f*df;								% aircraft fuselage length [ft] convert to [m]

    % number of crew members (not including pilots) 
    flcrewnum   = 8;  % number of flight crew 

    %number of crew members (pilots and flight attendants)
    crew = crewnum + flcrewnum;  

    %% Output compilation
    output.df     = df;
    output.lf     = lf;
    output.crew   = crew;
    output.pilots = crewnum;
    output.flcrew = flcrewnum;

end


        
        