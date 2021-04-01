%% Wing Config
x = [0 1.5];
y = [0 6.958];
c = [2.4 0.77];
coef_chord = polyfit(y, c, 1);
coef = polyfit(y, x, 1);

%% Fin Config
%x = [-0 1.5]; y = [0; 6.958]; % 
%c = [2.4 0.77];
%coef_chord = polyfit(y, c, 1); % Chord length function wrt y
%coef = polyfit(x,y,1); % Airfoil tip coord y function wrt x

%% Elevator Config
%x = [0, 1.5]; y = [0, 3.2]; c = [2, 1];
%coef_chord = polyfit(y, c, 1); % Chord length function wrt y
%coef = polyfit(x,y,1); % Airfoil tip coord y function wrt x
