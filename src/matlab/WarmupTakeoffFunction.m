% Function that computes Warm-up and Takeoff fuel weight fraction

%{
    NO need to change this function (TOMO)
%}

function output = WarmupTakeoffFunction(inputs)
% Historical warm-up and takeoff fuel weight fraction (Raymer Ch.3, Table 3.2)
% "inputs" not used here

output.f_to = 0.970;   % maybe 0.997
end