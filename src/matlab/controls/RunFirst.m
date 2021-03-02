% *********************************************
% RunFirst - Runs each of the stability derivitives functions
% and sets up the array called constant that is used by other
% MATLAB programs to perform various dynamic analysis.
%
% *********************************************     
%
% A&AE 421 Fall 2001 - Purdue University
% 
% Note: This code is provided for a first order approximation of the dynamic 
%       stability and control derivatives of an airplane.
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
clear all
close all

format short g
% The next script gather data needed for the stability and 
% control derivative computations.
%BasicConstants_BoilerXP % Use this script to model the Boiler Xpress aircraft
BasicConstants_Cessna182 % Use this script to model the Cessna 182 aircraft
%BasicConstants_YourCraft % Write this script in the same format as above
%   to model your aircraft.

DerivedConstants  % This script computes some intermediate constants used below


% The 57 "constant" computed below are used by four dynamic and control
% software programs. Specifically, Simulink scripts FlatEarth.mdl and E_Earth.mdl
% use the first 547 "constant". These MATLAB programs perform 6-degree-of-freedom 
% aircraft simulation over a flat earth or an elliptical earth.
% Two other programs do simplified dynamic modeling (compute transfer functions)
% for the longitudinal or lateral-directional degrees of freedom.  They use all
% 67 of the "constant" defined below.
% These programs are called LatSC.m or LongSC.m. Examples of these programs are called 
% CessnaLongSC.m and CessnaLatSC.m. This software can be found at the 
% following web site.
%
% http://roger.ecn.purdue.edu/~andrisan/Courses/AAE421_S2001/Docs_Out/DC_Software/index.html
%
% Mass related inputs
constant(1)=W;      % W, Weight, pounds (lbf)
constant(2)=32.17405;  % g, Acceleration of gravity, ft/(sec*sec)
constant(3)=constant(1)/constant(2); % mass, slugs
constant(4)=Ixx;    % Ixx, slug*ft*ft
constant(5)=Iyy;   % Iyy, slug*ft*ft
constant(6)=Izz;   % Izz, slug*ft*ft
constant(7)=Ixz;     % Ixz, slug*ft*ft
constant(8)=eta_p;    % propeller efficiency, eta, nondimensional
constant(9)=0; % unassigned

% Derived constants from the inertia data
constant(10)=constant(4)*constant(6)-constant(7)*constant(7);  %gamma
constant(11)=((constant(5)-constant(6))*constant(6)-constant(7)*constant(7))/constant(10);% c1
constant(12)=(constant(4)-constant(5)+constant(6))*constant(7)/constant(10);% c2
constant(13)= constant(6)/constant(10);% c3 
constant(14)= constant(7)/constant(10);% c4 
constant(15)=(constant(6)-constant(4))/constant(5);% c5 
constant(16)= constant(7)/constant(5);% c6
constant(17)= 1/constant(5);% c7
constant(18)=  (constant(4)*(constant(4)-constant(5))+constant(7)*constant(7))/constant(10);% c8 
constant(19)=  constant(4)/constant(10);% c9 

% aircraft geometry
constant(20)=S_w;    % S, wing area, ft^2
constant(21)=c_w;    % cbar, mean geometric chord, ft
constant(22)=b_w;     % b, wing span, ft
constant(23)=0;      % phiT, thrust inclination angle, RADIANS
constant(24)=0;      % dT, thrust offset distance, ft

% Nondimensional Aerodynamic stability and control derivatives

% Drag Polar CD=k(CLstatic-CLdm)^2 + CDm
constant(25)=Cd_0;   % CDm, CD for minimum drag
constant(26)=k; % k
constant(27)=0;      % CLdm, CL at the minimum drag point

% Lift Force
constant(28)=CL_0(S_w,S_h,M,tc_w,alpha_0,epsilon_t,i_w,i_h,epsilon_0_h,AR_w,Lambda_c4,Lambda_c2,lambda_w,kappa,beta,b_w,d,AR_h,eta_h);  % CL0
constant(29)=CL_alpha(AR_w,AR_h,Lambda_c2,lambda_w,l_h,h_h,b_w,d,eta_h,S_h,S_w,kappa_h,Lambda_c2_h,beta,kappa);   % CLalpha
constant(30)=CL_de(S_w,S_h,AR_h,ce_ch,eta_oe,eta_ie,beta,kappa_h,lambda_h,Lambda_c2_h,tc_h,delta_e,Cl_alpha_h);   % CLdeltaE
constant(31)=CL_alpha_dot(l_h, h_h, b_w, lambda, AR_w, AR_h, Lambda_c4, Lambda_c4_h, beta, kappa, kappa_h, V_h, eta_h);    % CLalphadot
constant(32)=CL_q(Xw,b_w,c_w,c_h,AR_w,Lambda_c4,Lambda_c2,Lambda_c2_h,Xh,S_h,S_w,eta_h,AR_h,beta, V_h,b_h, kappa, kappa_h);    % CLQ
% Side Force
constant(33)=0;      % CY0
constant(34)=Cy_beta(two_r_one,eta_v,beta,AR_v,b_v,Z_h,x_over_c_v,lambda_v,S_v,S_w,Lambda_c4,Lambda_c4_v,Z_w,d,dihedral,wingloc,Z_w1,S_h,S_o); % CYbeta
constant(35)=Cy_da(S_w);      % CYdeltaA
constant(36)=Cy_dr(S_w,b_w,S_h,S_v,b_v,c_v,x_AC_vh,two_r_one,AR_v,l_v,Z_v,eta_or,eta_ir,cr_cv,beta,kappa_v,Lambda_c2_v,lambda_v,delta_r,alpha);  % CydeltaR
constant(37)=Cy_p(b_w,l_v,Z_v,alpha,two_r_one,eta_v,beta,AR_v,b_v,Z_h,x_over_c_v,lambda_v,S_v,S_w,Lambda_c4_v,Z_w,d,dihedral,wingloc,Z_w1,S_h,S_o); % Cy_p
constant(38)=Cy_r(alpha,two_r_one,eta_v,beta,AR_v,b_v,b_w,Z_h,x_over_c_v,lambda_v,S_v,S_w,Lambda_c4,Z_w,d,dihedral,wingloc,Z_w1,S_h,S_o,l_v,Z_v);  % CYR
% Rolling Moment
constant(39)=0;       % Cl0
constant(40)=Cl_beta(CL_wb,theta,theta_h,Lambda_c2, Lambda_c4,Lambda_c4_h,S_w,b_w,AR_w,AR_h,Z_v,alpha,l_v, M,two_r_one,eta_v,beta,AR_v,b_v,Z_h,x_over_c_v,lambda_v,S_v,Z_w,d,wingloc,Z_w1,S_h,S_o, dihedral,dihedral_h,Lambda_c2_h,l_b,b_h,CL_hb); % Clbeta
constant(41)=Cl_da(S_w,AR_w,ca_cw,eta_ia,eta_oa,beta,kappa,Lambda_c4,lambda_w,tc_w,Cl_alpha_w);   % CldeltaA
constant(42)=Cl_dr(S_w,b_w,S_h,S_v,b_v,c_v,x_AC_vh,two_r_one,AR_v,l_v,Z_v,eta_or,eta_ir,cr_cv,beta,kappa_v,Lambda_c2_v,lambda_v,delta_r,alpha);  % CldeltaR
constant(43)=Cl_p(b_h,b_w,Z_v,two_r_one,eta_v,AR_v,b_v,Z_h,x_over_c_v,lambda_v,S_v,S_w,Lambda_c4,Lambda_c4_h,Z_w,d,lambda_w,wingloc,Z_w1,S_h,S_o,beta,Cl_alpha,Cl_alpha_h,AR_w,lambda_h, AR_h);  % ClP
constant(44)=Cl_r(l_v,alpha,Z_v,S_h,S_v,x_over_c_v,b_v,Z_h,two_r_one,lambda_v,S_w,Z_w,d,AR_w,beta,Lambda_c4,c_w,Xw,AR_v,eta_v,b_w,cf,delta_f,theta,lambda_w,Gamma);  % ClR
% Pitching Moment
constant(45)=Cm_0(S_h_slip,S_w,S_h,M,tc_w,alpha_0,epsilon_t,i_w,i_h,epsilon_0_h,AR_w,Lambda_c4,lambda_w,beta,Cm_0_r,Cm_o_t,Lambda_c2_h,kappa_h,AR_h,Xw);   % CM0
constant(46)=Cm_alpha(AR_w,AR_h,Lambda_c2,lambda_w,l_h,h_h,b_w,c_w,d,eta_h,S_h,S_w,kappa_h,Lambda_c2_h,beta,kappa,Xw); % Cmalpha
constant(47)=Cm_de(S_w,S_h,AR_h,ce_ch,eta_oe,eta_ie,beta,kappa_h,lambda_h,Lambda_c2_h,tc_h,delta_e,Cl_alpha_h,V_h); % CMdeltaE
constant(48)=Cm_a_dot(l_h,h_h,b_w,lambda_w,AR_w,Lambda_c4,M,Cl_alpha,q_bar_h,q_bar,S_h,Xh,c_w,S_w);  % CMalphadot
constant(49)=Cm_q(Xw,b_w,c_w,c_h,AR_w,Lambda_c4,Lambda_c2,Xh,S_h,S_w,eta_h,AR_h,beta,V_h,b_h,Cl_alpha,B);  % CMQ
% Yawing Moment
constant(50)=0;         % CN0
constant(51)=Cn_beta(S_w,b_w,alpha,l_v,Z_v,l_f,S_b_s,Rl_f,x_m,h1_fuse,h2_fuse,hmax_fuse,wmax_fuse,two_r_one,eta_v,M,AR_v,b_v,Z_h,x_over_c_v,lambda_v,S_v,Z_w,d,Z_w1,S_h,Lambda_c4,Lambda_c2_v);  % CNbeta
constant(52)=Cn_da(S_w,AR_w,ca_cw,eta_ia,eta_oa,beta,kappa,Lambda_c4,lambda_w,tc_w,Cl_alpha_w,CL); % CNdeltaA
constant(53)=Cn_dr(S_w,b_w,S_h,S_v,b_v,c_v,x_AC_vh,two_r_one,AR_v,l_v,Z_v,eta_or,eta_ir,cr_cv,beta,kappa_v,Lambda_c2_v,lambda_v,delta_r,alpha); % CNdeltaR
constant(54)=Cn_p(c_w,B,theta,adelf,delf,b_w,l_v,b_h,Z_v,two_r_one,eta_v,AR_v,b_v,Z_h,x_over_c_v,lambda_v,S_v,S_w,Lambda_c4,Lambda_c2,Lambda_c4_h,Z_w,d,lambda_w,wingloc,Z_w1,S_h,S_o,beta,Cl_alpha,Cl_alpha_h,AR_w,lambda_h, AR_h, b_f,Xw,CL,Lambda_c4_v,alpha); % CNP
constant(55)=Cn_r(CL,C_bar_D_o,l_v,alpha,Z_v,S_h,S_v,x_over_c_v,b_v,Z_h,two_r_one,lambda_v,S_w,Z_w,d,AR_w,beta,Lambda_c4,c_w,Xw,AR_v,eta_v,b_w); % CNR
% Reference positions
constant(56)=.264;  % XbarRef, nondimensional
constant(57)=.264;  % XbarCG,  nondimensional

% Trim conditions. These may or not be used by subsequent programs. Small 
% variations in these trim flight conditions are OK.
constant(58)=U;     % trim speed, Vt, ft/sec
constant(59)=5000;  % Trim altitude, ft
constant(60)=0;     % Trim alpha, >>>DEGREES<<<This is not used by CessnaLongSC
% The constants below are used only by CessnaLongSC and CessnaLatSC
constant(61)=0;     % CLu=0
constant(62)=0;     % CDu=0
constant(63)=-.096; % CTxu
constant(64)=0;     % Cmu
constant(65)=0;     % CmTu
constant(66)=0;     % CmTalpha
constant(67)=0;     % CDdeltae




