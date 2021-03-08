% *********************************************
% BasicConstants_Cessna182
%
% *********************************************
% BasicConstants - Identifies, describes, and assigns all of the 
%                  the most basic variables for analyzing the control
%                  and stability of a generic aircraft.
% *********************************************     
%
% A&AE 421 Fall 2001 - Purdue University
% 
% Note: This code is provided for a first order approximation of the dynamic 
%       analysis of an airplane and is not intended for final designs.
%
% Equations/Figures can be found in :
% 
% (Ref.1) Roskam, Jan. "Airplane Flight Dynamics and Automatic Flight
%         Controls"
%         Published by DARcorporation
%         120 E. Ninth St., Suite 2
%         Lawarence, KS 66044
%         Third Printing, 2001.
%
% (Ref.2) Roskam, Jan. "Methods for Estimating Satbility and
%         Control Derivatives of Conventional Subsonic Airplanes"
%         Published by the Author 
%         519 Boulder 
%         Laurance, Kansas 66044
%         Third Printing, 1997.
%  
% (Ref.3) Roskam, Jan. "Airplane Design: Part IV: Preliminary Calculation
%         of Aerodynamic, Thrust and Power Characteristics"
%         Published by Roskam Aviation and Engineering Corporation
%         Rt4, Box 274
%         Ottawa, Kansas 66067
%         Second Printing, 1990.
%

aircraft='Cessna182, cruise configuration';

adelf = 0;           % Two dimensional lift effectiveness parameter Ref.(2), Equ(8.7)
alpha = 0;           % Angle of attack [deg]
alpha_0 = -.2;	    	% Airfoil zero-lift AOA [deg]
AR_h = 3.93;         % Aspect ratio of the horizontal tail
AR_w = 7.45;         % Aspect ratio of the wing
b_f = 20;            % Span of the flap [ft]
b_ = 11.33;     		% Span of the horizontal tail [ft]
b_h_oe = 5.8333;     % Elevator outboard position [ft]
b_h_ie = 0.5;     	% Elevator inboard position [ft]
b_w = 36;            % Span of the wing [ft]
b_v = 5;             % Vertical tail span measured from fuselage centerline [ft]
b_v_or = 4.95;       % Outboard position of rudder [ft]
b_v_ir = 0.0;        % Inboard position of rudder [ft]
c_a = 1.0;           % Chord of aileron [ft]
C_bar_D_o = .0270;   % Parasite drag
Cd_0 = 0.027;        % Drag coefficient at zero lift (parasite drag)
c_e = 2.70;	         % Elevator flap chord [ft]
cf = 1.2;            % Length of the wing flap [ft]
c_h = 6.3;           % Mean aerodynamic chord of the horizontal tail [ft]
CL = 0.307;          % Lift coefficient (3-D)
CL_hb=.307;          % Lift coefficient of the horzontal tail/body
CL_wb=.307; 	      % Lift coefficient of the wing/body
Cl_alpha_h  = 2*pi;	% 2-D Lift curve slope of wing
Cl_alpha_v	= 2*pi;  % 2-D Lift curve slope of vertical tail
Cl_alpha = 6;        % Two-dimensional lift curve slope
Cl_alpha_w=Cl_alpha; % Two-dimensional lift curve slope
Cm_0_r = -.2;        % Zero lift pitching moment coefficient of the wing root
Cm_o_t = -.2;        % Zero lift pitching moment coefficient of the wing tip
c_r = 1.52;          % Chord of the rudder [ft]
c_w = 4.9;           % Mean aerodynamic chord of the wing [ft]
c_v = 3.8;           % Mean aerodynamic chord of the vertical tail [ft]
D_p = 4;			   	% Diamter of propeller [ft]
d = 4.5;					% Average diameter of the fuselage [ft]
delf = 0;            % Streamwise flap deflection [deg] 
delta_e = 0;	   	% Elevator deflection [deg]
delta_f = 0;         % Streamwise flap deflection [deg]
delta_r = 0;         % Rudder deflection [deg]
dihedral = 0;        % Geometric dihedral angle of the wing [deg]
dihedral_h = 0;      % Geometric dihedral angle of the horizontal tail [deg]
e = 0.9;             % Oswald efficiency factor
epsilon_t = -.421;	% Horizontal tail twist angle [deg]
epsilon_0_h=epsilon_t;% Horizontal tail twist angle [deg]
eta_h = 0.85;	      % Ratio of dynamic pressure at the tail to that of the free stream 
eta_ia = .06;        % Percent span position of inboard edge of aileron
eta_oa = 1.0;        % Percent span position of outboard edge of aileron
eta_p = 0.70;			% Propeller Efficiency
eta_v = 1;				% Ratio of the dynmaic pressure at the vertical tail to that of the freestream
Gamma = 2*pi/180;    % This is the geometric dihedral angle, positive for dihedral, negative for anhedral [rad]
h1_fuse =4;          % Heighth of the fuselage at 1/4 of the its length 
h2_fuse =3;          % Heighth of the fuselage at 3/4 of the its length 
h_h = 1.7;           % Height from chord plane of wing to chord plane of horizontal tail [ft] - Fig 3.7, Ref. 2
hmax_fuse = 5;       % Maximum heighth of the fuselage [ft]  
Ixx = 948;
Iyy = 1346;
Izz = 1967;
Ixz = 0;
i_h = 2;             % Horiz tail incidence angle [deg]  
i_w	= -.2;			% Wing incidence angle [deg]  
k = 0.0554;				% k
Lambda=0;            % Wing sweep angle [deg]
Lambda_c4=0;         % Sweep angle at the quarter-chord of the wing [deg]      
Lambda_c2=0;         % Sweep angle at the half-chord of the wing [deg]
Lambda_c2_v = 0.35;  % Sweep angle at the half-chord of the vertical tail [deg]
Lambda_c4_v = 0.35;  % Sweep angle at the quarter-chord of the vertical tail [deg]
Lambda_c2_h = 0;     % Sweep angle at the half-chord of the horizontal tail [deg]
Lambda_c4_h = 0;     % Sweep angle at the quarter-chord of the vertical tail [deg]
lambda = 0.75;       % Taper ratio of the wing
lambda_h = 0.75;  	% Horizontal tail taper ratio
lambda_v	= 0.5;      % Vertical tail taper ratio
lambda_w = lambda;   % Taper ratio of the wing
l_b = 25;	         % This is the total length of the fuselage [ft]
l_f =12;             % The horizontal length of the fuselage [ft]  (*******)
l_h = 12;            % Distance from c/4 of wing to c/4 of horizontal tail [ft] 
l_v = 13;    			% Horizontal distance from the aircraft CG to the vertical tail aero center [ft]
M = 0.2;             % Mach number
q_bar = 1; 				% Dynamic pressure ratio (free stream)
q_bar_h = 1;         % Dynamic pressure ratio at the tail
Rl_f=10^6;           % Fuselage Reynold's number
rho = 0.00204;			% Air density at 5000ft [slugs/ft^3]
S_b_s =60;           % Body side area [ft^2]
S_b = S_b_s;         % Body side area [ft^2] 
S_h	= 48;				% Area of the horizontal tail [ft^2]
S_h_slip	= 8;	   	% Area of horiz. tail that is covered in prop-wash - See fig.(8.64) Ref.(3) [ft^2]
S_o = 6;	            % Take X1/l_b and plug into: .378+.527*(X1/l_b)=(Xo/l_b), S_o is the fuselage x-sectional area at Xo. (ft^2) Ref.(2), Fig. 7.2  
S_w = 174;           % Aera of the wing [ft^2]
S_v = 25;   			% Surface area of vertical tail [ft^2]
T = 0;					% Temperature [F]
tc_w = .10;         	% Thickness to chord ratio of the wing 
tc_h = 0.10;     	   % Thickness to chord ratio of horizontal tail
theta = 0;           % This is the wing twist in degrees, negative for washout [deg]
theta_h = 0;         % Horizontal tail twist between the root and tip stations, negative for washout [deg]
two_r_one = 2;       % Fuselage depth in region of vertical tail [ft] Ref.(2), Figure 7.5
U = 129.73;				% Free Stream Velocity [knots]
U1  = 220.1;			% Cruise flight speed [ft/s]
W = 2650;            % Weight of Airplane [lbf]
wingloc = 1;         % If the aircraft is a highwing: (wingloc=1), low-wing: (wingloc=0) 
wmax_fuse = 5;       % Maximum fuselage width [ft]
X1 = 12.5;	         % Distance from the front of the fuselage where the x-sectional area decrease (dS_x/dx) is greatest (most negative) [ft] - Ref.(2), Fig. 7.2  
x_AC_vh =1;          % X distance from LE of vertical tail to AC of horizontal tail [ft]
Xh = 18;             % Distance from airplane cg to the horizontal tail ac [ft] 
x_m = 5;             % Center of gravity location from the leading edge [ft]
x_over_c_v = .5;     % X distance from leading edge of vertical fin mean chord to horizontal aero center [ft] 
Xref = 6;            % Arbitrary reference point located on the airplane's axis of symmetry. 
							% Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]
Xw = 0.2;            % Distance from the airplane cg to wing ac (positive aftward) [ft]
Z_h = -2.5;      		% Negative of the hoizontal distance from the fuselage centerline to the horizontal tail aero center (negative number) - Ref.(2), Fig. 7.6
Z_v = .5; 				% Vertical distance from the aircraft CG to the vertical tail aero center - Ref.(2), Fig. 7.18
Z_w = 2;					% This is the vertical distance from the wing root c/4 to the fuselage centerline, positive downward - Ref.(2), Equ(7.5)
Z_w1 = -.5;	         % Distance from body centerline to c/4 of wing root chord, positive for c/4 point below body centerline (ft) - Ref.(2), Fig. 7.1  



