% Function that computes parasite drag coefficient.
% The approach used here is Based on Raymer Ch.12 and uses the Equivalent
% skin friction coefficient to estimate the parasite drag coefficient.
% Other methods that do a more accurate drag-build-up should replace the
% approach used here.

function Cdo = ParasiteDragFunction(inputs)
% Equivalent skin friction coefficient (based on Raymer Ch.12 Table 12.3)
Cfe = 0.0055;    % Light aircraft - SINGLE engine

% Parasite Drag coefficient
Cdo = Cfe*inputs.GeometryOutput.Swet/inputs.GeometryOutput.Sw; 

end