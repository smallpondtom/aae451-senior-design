% Function that computes Warm-up and Takeoff fuel weight fraction

function output = WarmupTakeoffFunction(inputs)
% Historical warm-up and takeoff fuel weight fraction (Raymer Ch.3, Table 3.2)
% RAYMER VALUE STATES 0.970. CROSSLEY B757 DATA (14MIN IDLE PW + 1MIN TO PW)
% RESULTS IN 0.997. EITHER ARE ESTIMATES, CHOOSE WHICH IS ACCEPTABLE FOR
% YOUR DESIGN. RAYMER / CROSSLEY / AVG(RAYMER,CROSSLEY)

% "inputs" not used here

output.f_to = 0.997;
end