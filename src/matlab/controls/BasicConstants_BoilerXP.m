% *********************************************
% BasicConstants_BoilerXP 
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
% (Ref.1) Textbook
%
% (Ref.2) Roskam, Jan. "Methods for Estimating Satbility and
%         Control Derivatives of Conventional Subsonic Airplanes"
%         Published by the Author 
%         519 Boulder 
%         Laurance, Kansas, 66044
%         Third Printing, 1997.
%  
% (Ref.3) Other Roskam Book
%

aircraft='BoilerXpress, cruise configuration';

adelf = 0;             % Two dimensional lift effectiveness parameter
alpha = 0;           % Angle of attack [deg]
alpha_0 = -0.1396;;	    	% Airfoil zero-lift AOA [deg]
b_f = 0;            % Span of the flap [ft]
b_h = 3;     		% Span of the horizontal tail [ft]
b_h_oe = 1.17;     % Elevator outboard position [ft]
b_h_ie = 0;     	% Elevator inboard position [ft]
b_w = 11.25;            % Span of the wing [ft]
b_v = 2;             % Vertical tail span measured from fuselage centerline [ft]
b_v_or = 1.41666;
b_v_ir = 1.375;
c_a = .208;           % Chord of aileron [ft]
C_bar_D_o = .00270;   % Parasite drag
Cd_0 = 0.0027;        % Drag coefficient at zero lift (parasite drag)
c_e = 2.70;	         % Elevator flap chord [ft]
cf = 0;            % This is the length of the wing flap [ft]
c_h = 0.7333;           % Mean aerodynamic chord of the horizontal tail [ft]
CL = 0.8589;          % Lift coefficient (3-D)
CL_hb=0.8589;          % Lift coefficient of the horzontal tail/body
CL_wb=0.8589; 	      % Lift coefficient of the wing/body
Cl_alpha_h  = 3.72;	% 2-D Lift curve slope of wing
Cl_alpha_v	= 2*pi;  % 2-D Lift curve slope of vertical tail
Cl_alpha = 5.44;        % Two-dimensional lift curve slope
Cl_alpha_w = Cl_alpha;
Cm_0_r = -0.2;
Cm_o_t = -0.2;
c_r=.5;
c_w = 1.33;            % Mean aerodynamic chord of the wing [ft]
c_v = .792;           % Mean aerodynamic chord of the vertical tail [ft]
D_p = .833;			   	% Diamter of propeller [ft]
d = 1.25;					% Average diameter of the fuselage [ft]
delf = 0;            % Streamwise flap deflection [deg] 
delta_e = 0;	   	% Elevator deflection [deg]
delta_f = 0;         % This is the streamwise flap deflection [deg]
delta_r = 0;         % Rudder deflection [deg]
dihedral = 0;        % This is the geometric dihedral angle of the wing (deg)
dihedral_h = 0;
e = 0.75;             % Oswald efficiency factor
epsilon_t = 0;	% Horizontal tail twist angle [deg]
epsilon_0_h = epsilon_t;
eta_h = 0.85;	      % Ratio of dynamic pressure at the tail to that of the free stream  (from report)
eta_ia = .415;        % Percent span position of inboard edge of aileron
eta_oa = .948;        % Percent span position of outboard edge of aileron
eta_p = 0.70;			% Propeller Efficiency
eta_v = 1;				% Ratio of the dynmaic pressure at the vertical tail to that of the freestream
Gamma = .035;     % This is the geometric dihedral angle, positive for dihedral, negative for anhedral [rad]
h1_fuse =.5;          % Body height of the fuselage at 1/4 of the length
h2_fuse =.5;          % Body height of the fuselage at 3/4 of the length
h_h = .01;           % Height from chord plane of wing to chord plane of horizontal tail [ft]
hmax_fuse = .5;       % Maximum body height of the fuselage [ft]
Ixx = 2.2176;
Iyy = 18.757;
Izz = 20.751;
Ixz = 1.1805;
i_h = -0.1047;             % Horiz tail incidence angle [deg]
i_w	= 0.0524;				% Wing incidence angle [deg]
k = 0.0554;				%
Lambda=0;            % Wing sweep angle [deg]
Lambda_c4=0;
Lambda_c2=0;
Lambda_c2_v = 45;
Lambda_c4_v = 45;
Lambda_c2_h = 0;
Lambda_c4_h = 0;
lambda = .69;
lambda_h = 0;  	% Horizontal tail taper ratio
lambda_v	= 0.44;      % Vertical tail taper ratio
lambda_w = lambda;
l_b = 3;	         % This is the total length of the fuselage [ft]
l_f =.333;             % The horizontal length of the fuselage [ft]
l_h = 3.54;            % Distance from c/4 of wing to c/4 of horizontal tail [ft] p3.11
l_v = 3.83;    			% the horizontal distance from the aircraft CG to the vertical tail aero center
M=.02;
q_bar = 1; 				% Dynamic pressure ratio (free stream)
q_bar_h = 1;         % Dynamic pressure ratio at the tail
Rl_f=2.29^6;           % Fuselage Reynold's number
rho = 0.00204;			% Air density at 5000ft [slugs/ft^3]
S_b_s =1.5;           % Body side area
S_b = S_b_s;
S_h	= 1.92;				% Area of the horizontal tail [ft^2]
S_h_slip	= .96;	   	% Area of horiz. tail that is covered in prop-wash - see fig.(8.64) Ref.(3) [ft^2]
S_o = .135;	            % Take X1/l_b and plug into: .378+.527*(X1/l_b)=(Xo/l_b), S_o is the fuselage x-sectional area at Xo. (ft^2) %%fig 7.2
S_w = 28.08;            % Aera of the wing [ft^2]
S_v = 1.58;   			% Surface area of vertical tail
T = 0;                % Temperature [F]
tc_w=.1;
tc_h = 0.16;     	   % Thickness to chord ratio of horizontal tail
theta = 0;           % This is the wing twist in degrees, negative for washout [deg]
theta_h = 0;          % Horizontal tail twist between the root and tip stations, negative for washout [deg]
two_r_one = .01;       % fuselage depth in region of vertical tail
U = 16.59;				% Free Stream Velocity [knots]
U1  = 28;			% Cruise flight speed [ft/s]
W = 10.5;            % Weight of Airplane [lbf]
wingloc = 0;         % If the aircraft is a highwing: (wingloc=1), low-wing: (wingloc=0)
wmax_fuse = .333;       % Maximum body width [ft]
X1 = 1.16;	         % This is the distance from the front of the fuselage where the x-sectional area decrease (dS_x/dx) is greatest (most negative). (ft)
x_AC_vh =.17;
Xh = 3.875;             % Distance from airplane cg to the horizontal tail ac [ft] 
x_m = .42;               % Center of gravity location from the leading edge [ft]
x_over_c_v = .01;     % Horizontal distance from leading edge of vertical fin mean chord to horizontal aero center
Xref = 0;            % Arbitrary reference point located on the airplane's axis of symmetry.
							% Measured as positive aft, starting from the leading edge of the mean aero. chord. [ft]
Xw = 0.21;            % Distance from the airplane cg to wing ac (positive aftward) [ft]
Z_h = -.25;      		% the negative of the hoizontal distance from the fuselage centerline to the horizontal tail aero center (negative number)
Z_v = .5; 				% the vertical distance from the aircraft CG to the vertical tail aero center
Z_w = .21;					% This is the vertical distance from the wing root c/4 to the fuselage centerline, positive downward
Z_w1 = .21;	         % Distance from body centerline to c/4 of wing root chord, positive for c/4 point below body centerline (ft) %%fig 7.1 





