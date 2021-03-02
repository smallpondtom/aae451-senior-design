function [x,u,CL,CD,CM,alphadeg]=QuickTrim(Vt,Hp,constant)
% function [x,u,CL,CD,CT,CM,alphadeg]=QuickTrim(Vt,Hp,constant)
% Quick and dirty trim routine.
% constant is an array of aircraft specific sconstants.
% Vt and Hp are trim true airspeed (ft/sec) and pressure altutude (ft).
% x is the 12x1 state vector which is initialized in this routine.
% u is the 4x1 control vector which is also initialized by this routine.
% CL and CD are trim lift and drag coefficient. 
% alphadeg is the trim angle of attack in degrees.
% The trim condition is assumed to be straight line flight with
% wings level, constant attitude, 
% constant altitude, and nonaccelerating.
% It assumes CY0, Cl0, CN0 are all zero and an initial northerly heading.
% Flight in the troposphere is assumed.
% This is not the most general trim routine. It is a quick-trim routine.
% It also assumes that
% Xcg=xref and that dT=0 (thrust inclination angle) and that
% alpha is very small.

rho=0.00237691267925741*(1-6.87558563248308e-06*Hp)^(4.25591641274834); %slug/ft3, troposphere
qbar=.5*rho*Vt*Vt;     %lbf/ft^2
W=constant(1);
S=constant(20);
CL=W/(qbar*S);
CL0=     constant(28);
CLalpha= constant(29);
CLdeltaE=constant(30);
CM0=     constant(45);
CMalpha= constant(46);
CMdeltaE=constant(47);
T=[CLalpha,CLdeltaE;
   CMalpha,CMdeltaE];
Y=[CL-CL0;-CM0];
X=inv(T)*Y;
alpha=X(1);
alphadeg=alpha*57.3;
deltaE=X(2);
deltaEdeg=deltaE*57.3;
CDm= constant(25);
k=   constant(26);
CLdm=constant(27);
CD=CDm+k*(CL-CLdm)^2;
D=qbar*S*CD;
bhp=Vt*D/(550*.7);
x=[Vt*cos(alpha),0,Vt*sin(alpha),0,0,0,0,alpha,0,0,0,Hp]';
u=[deltaE,0,0,bhp]';
CM=0;  % There is no moment due to thrust to balance.

