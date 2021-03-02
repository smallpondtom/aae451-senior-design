disp(' ')
disp(' ')
disp('*** This code is written for MATLAB 5.2 ***')
disp(' ')
echo on
%
% Longitudinal Airplane Stability and Control Analysis
%
% Ref: Airplane Flight Dynamics and Automatic Flight Controls
%      Part 1, 1994
%      by Jan Roskam
%
% See Data input format of Appendix B
% Sample data for Cessna 182, cruise configuration, pages 480-482.
echo off

RunDerivs;

disp(aircraft)

% Reference Geometry
S=constant(20)		    % Wing area, ft*ft
cbar=constant(21)		% wing mean geometric chord, ft
span=constant(22)		% Wing span, ft
%
% Steady State (Trim) Flight Condition
h=constant(59);		    % Altitude, ft
U1=constant(58)		    % True airspeed, ft/sec
rho=0.00237691267925741*(1-6.87558563248308e-06*h)^(4.25591641274834) %slug/ft3, troposphere
qbar=.5*rho*U1*U1       % Dynamic pressure, lbf/ft^2
Xcg=constant(57)		% X-location of center of gravity, fraction of cbar
alpha1=constant(60)	    % Trim angle of attack, degree
gamma1=0                % Trim flight path angle, degree (This is usually so. Check it!)
%
% Mass data
W=constant(1)		% Weight, pounds (lbf)
Ixxb=constant(4)	% X-direction moment of inertia, slug*ft*ft
Iyyb=constant(5)	% Y-direction moment of inertia, slug*ft*ft
Izzb=constant(6)	% Z-direction moment of inertia, slug*ft*ft
Ixzb=constant(7)	% XZ-direction product of inertia, slug*ft*ft
%
% Steady State Coefficients
[xIC,uIC,CL1,CD1,Cm1,alpha1]=QuickTrim(U1,h,constant);
% alpha1 is the trim alpha in degrees
alpha1rad=alpha1*pi/180;% alpha1rad is the trim alpha in radians
%CL1= Lift coefficient, nondimensional
%CD1= Drag coefficient, nondimensional
CTx1=CD1;	% Thrust coefficient, nondimensional, check this!
            % Cm1 Aerodynamic Pitching Moment coefficient, nondimensional
CmT1=Cm1;	% Thrust Pitching Moment coefficient, nondimensional
%
%Longitudinal Coefficients and Stability Derivatives

CL0=constant(28);
CLu=constant(61);
CLalpha=constant(29);	% Lift curve slope
CLalphadot=constant(31);
CLq=constant(32);
CDm=constant(25);       % CDm, CD for minimum drag
k=constant(26);         % k
CLdm=constant(27);      % CLdm, CL at the minimum drag point
CDalpha=k*2*(CL0+CLalpha*alpha1rad-CLdm)*CLalpha;
CD0=CDm+k*(CL0+CLalpha*alpha1rad-CLdm)^2-CDalpha*alpha1rad;
CDu=constant(62);
CTxu=constant(63);

CM0=constant(45); 
Cmu=constant(64);
Cmalpha=constant(46);	% Static longitudianl stabiity derivative
Cmalphadot=constant(48);% Lag of downwash stability derivative
Cmq=constant(49);		% Swish effect in pitch 
CmTu=constant(65);
CmTalpha=constant(66);

%Longitudinal Control Derivatives
CDdeltae=constant(67);	% Drag from elevator  
CLdeltae=constant(30);	% Lift from elevator
Cmdeltae=constant(47);	% Pitching moment from elevator

% Miscellaneous inputs
g=32.17;		% Acceleration of gravity, ft/sec*sec
gamma1=0		% Steady state flight path angle, deg, see figure page 66
%				  angle between horizontal and Xs axis (Wind at trim)
%
% Computation of Dimensional Stability and Control Derivatives
%
% Preliminary calculations
% Stability axis inertia data, see page 346, eqn 5.94
Iyys=Iyyb;	% These are the same since that rotation is angle alpha1 
%				about the Y-axis
mass=W/g	% mass, slugs
theta1=gamma1+alpha1;	% Steady state 
d2r=pi/180;
r2d=180/pi;
gamma1rad=gamma1*d2r;

% See page 319
Xu=-qbar*S*(CDu+2*CD1)/(mass*U1)	% 1/sec
XTu=qbar*S*(CTxu+2*CTx1)/(mass*U1)	% 1/sec
Xalpha=-qbar*S*(CDalpha-CL1)/mass	% ft/sec*sec
Xdeltae=-qbar*S*CDdeltae/mass		% ft/sec*sec
%
Zu=-qbar*S*(CLu+2*CL1)/(mass*U1)	% 1/sec
Zalpha=-qbar*S*(CLalpha+CD1)/mass	% ft/sec*sec
Zalphadot=-qbar*S*cbar*CLalphadot/(2*mass*U1)	% ft/sec
Zq=-qbar*S*cbar*CLq/(2*mass*U1)		% ft/sec
Zdeltae=-qbar*S*CLdeltae/mass		% ft/sec*sec
%
Mu=qbar*S*cbar*(Cmu+2*Cm1)/(Iyys*U1)	% 1/ft/sec
MTu=qbar*S*cbar*(CmTu+2*CmT1)/(Iyys*U1)	% 1/ft/sec
Malpha=qbar*S*cbar*Cmalpha/Iyys			% 1/sec*sec
MTalpha=qbar*S*cbar*CmTalpha/Iyys		% 1/sec*sec
Malphadot=qbar*S*cbar*cbar*Cmalphadot/(2*Iyys*U1)	% 1/sec
Mq=qbar*S*cbar*cbar*Cmq/(2*Iyys*U1)		% 1/sec
Mdeltae=qbar*S*cbar*Cmdeltae/Iyys		% 1/sec*sec

%
% Computation of Primed Dimensional Stability and Control Derivatives
%	
XuP=Xu+XTu;
XalphaP=Xalpha;
XthetaP=-g*cos(gamma1rad);
XdeltaeP=Xdeltae;
%
ZuP=Zu/(U1-Zalphadot);
ZalphaP=Zalpha/(U1-Zalphadot);
ZqP=(Zq+U1)/(U1-Zalphadot);
ZthetaP=-g*sin(gamma1rad)/(U1-Zalphadot);
ZdeltaeP=Zdeltae/(U1-Zalphadot);
%
MuP=Mu+MTu+Malphadot*Zu/(U1-Zalphadot)
MalphaP=Malpha+MTalpha+Malphadot*Zalpha/(U1-Zalphadot)
MqP=Mq+Malphadot*(Zq+U1)/(U1-Zalphadot)
MthetaP=-Malphadot*g*sin(gamma1rad)/(U1-Zalphadot)
MdeltaeP=Mdeltae+Malphadot*Zdeltae/(U1-Zalphadot)
%
% Assemble the A and B matrices
% X=[u(ft/sec) alpha(rad) q(rad/sec) theta(rad)]'
%
A=[XuP XalphaP   0 XthetaP;
   ZuP ZalphaP ZqP ZthetaP;
   MuP MalphaP MqP MthetaP;
     0       0   1       0];
B=[XdeltaeP ZdeltaeP MdeltaeP 0]';
C=[1  0     0   0;
   0  r2d   0   0;
   0  0    r2d  0;
   0  0     0  r2d];
D=[0 0 0 0]';
%
% Analyze the linear equations of motion
%
sys=ss(A,B,C,D);
set(sys,'statename',{'u(f/s)' 'alpha(r)' 'q(r/s)' 'theta(r)'})
set(sys,'inputname','deltae(r)')
set(sys,'outputname',{'u(f/s)' 'alpha(d)' 'q(d/s)' 'theta(d)'})
sys
[Wn,Z,Poles]=damp(sys)
tfsys=tf(sys)
zpksys=zpk(sys)


% Generate time histories
echo off
t=0:.1:5;					% time scale to expose short period mode
u=d2r*ones(length(t),1);	% deltae step of one degree
y=lsim(sys,u,t);
figure(1)
subplot(4,1,1)
plot(t,y(:,1))
xlabel('time(sec)')
ylabel('u(ft/sec)')
ts=['Step elevator response, ',aircraft];
title(ts)
subplot(4,1,2)
plot(t,y(:,2))
xlabel('time(sec)')
ylabel('alpha(deg)')
text(2,-.5,'Note highly damped short period mode')
subplot(4,1,3)
plot(t,y(:,3))
xlabel('time(sec)')
ylabel('q(deg/sec)')
text(2,-1.3,'Note highly damped short period mode')
subplot(4,1,4)
plot(t,y(:,4))
xlabel('time(sec)')
ylabel('theta(deg)')

t=0:1:200;					% time scale to expose short period mode
u=d2r*ones(length(t),1);	% deltae step of one degree
y=lsim(sys,u,t);
figure(2)
subplot(4,1,1)
plot(t,y(:,1))
xlabel('time(sec)')
ylabel('u(ft/sec)')
ts=['Step elevator response, ',aircraft];
title(ts)
text(40,10,'Note lightly damped phugoid mode')
subplot(4,1,2)
plot(t,y(:,2))
xlabel('time(sec)')
ylabel('alpha(deg)')
subplot(4,1,3)
plot(t,y(:,3))
xlabel('time(sec)')
ylabel('q(deg/sec)')
subplot(4,1,4)
plot(t,y(:,4))
xlabel('time(sec)')
ylabel('theta(deg)')
text(40,1.0,'Note lightly damped phugoid mode')
