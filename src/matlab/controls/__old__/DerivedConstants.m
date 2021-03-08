% ******************************************************************
% DerivedConstants - Identifies, describes, and assigns all of the 
%                  the basic derived constants used for analyzing the 
%                  control and stability of a generic aircraft.
% ******************************************************************     
%
% A&AE 421 Fall 2001
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

AR_v = b_v^2/S_v;                 % Aspect Ratio of Horizontal Tail (NEED CHECK)


AR_h = b_h^2/S_h;					    % Aspect Ratio of Horizontal Tail
AR_w = b_w^2/S_w;                 % Aspect Ratio of Horizontal Tail
B=sqrt(1-M^2*(cos(Lambda_c4))^2); % Compressibility correction factor
beta = sqrt(1-M^2);               % Compressibility correction factor
Beta = beta;                      % Compressibility correction factor
ca_cw = c_a/c_w;                  % Ratio of aileron chord to wing chord
Cd = Cd_0 + (CL^2/(pi*AR_w*e));   % Drag Coefficient
ce_ch = c_e/c_h;				     	 % Elevator flap chord 
cr_cv			= c_r/c_v;            % Rudder flap chord 
eta_ie = b_h_ie/(b_h/2);	  	    % Percent span position of inboard edge of elevator
eta_ir		= b_v_ir/b_v;         % Percent span position of inboard edge of rudder
eta_oe = b_h_oe/(b_h/2);		    % Percent span position of outboard edge of elevator
eta_or		= b_v_or/b_v;         % Percent span position of outboard edge of rudder
kappa=Cl_alpha/(2*pi);            % Ratio of 2D lift coefficient to 2pi for the wing
kappa_h = Cl_alpha_h/(2*pi);	    % Ratio of 2D lift coefficient to 2pi for the horiz. tail
kappa_v		= Cl_alpha_v/(2*pi);  % Ratio of 2D lift coefficient to 2pi for the vert. tail
V_h = (Xh*S_h)/(c_h*S_w);         % Horizontal Tail Volume Coefficient
