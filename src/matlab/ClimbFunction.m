% Function that computes landing and taxi fuel weight fraction

%{
    NO NEED to change this function (TOMO)
%}

function output = ClimbFunction(inputs)
% Historical climb fuel weight fraction (Raymer Ch.3, Table 3.2)
% "inputs" not used here

output.f_cl = 0.985; % Remaining Fuel Weight / Beginning Fuel Weight at Climb Phase
end