% Function that computes parasite drag coefficient.
% The approach used here is Based on Raymer Ch.12 and uses the Equivalent
% skin friction coefficient to estimate the parasite drag coefficient.
% Other methods that do a more accurate drag-build-up should replace the
% approach used here.

%{
    This function REQUIRES massive change using the info on Lecture Slide 
    "Topic 8: Drag Prediction" Slides 8 to 37

%}


function Cdo = ParasiteDragFunction(inputs)

% --->(REQUIRE MODIFICATION) TOMO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Equivalent skin friction coefficient (based on Raymer Ch.12 Table 12.3)
Cfe = 0.0026;    % Civil Transporter

% Parasite Drag coefficient
Cdo = Cfe*inputs.GeometryOutput.Swet/inputs.GeometryOutput.Sw; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% <---(END)

end