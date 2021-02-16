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
    lambda_f =inputs.GeometryInputs.FinessRatio;     % fuselage finess ratio

    % diameter of fuselage [ft]
    df = 20;                                       % aircraft fuselage diameter [ft]

    % length of fuselage [ft]  
    lf = lambda_f*df;								% aircraft fuselage length [ft]

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


        
        