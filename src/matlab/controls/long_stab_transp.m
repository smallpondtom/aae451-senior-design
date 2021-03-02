%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Longitudinal stability control dynamics code for a general jet transporter.
% It calculates the state derivative vector xd from the state vector x and 
% control vector u; the formal argument "time" is unused.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xd]= transp(time,x,u)
    % Medium-sized transport aircraft, longitudinal dynamics.
    %
    S=2170.0; CBAR=17.5; MASS=5.0E3; IYY= 4.1E6;
    TSTAT=6.0E4; DTDV =−38.0; ZE = 2.0; CDCLS= .042;
    CLA = .085; CMA =−.022; CMDE =−.016; % per degree
    CMQ =−16.0; CMADOT= −6.0; CLADOT= 0.0; % per radian
    RTOD = 57.29578; GD=32.17;
    THTL =u(1);
    ELEV =u(2);
    XCG = u(3);
    LAND = u(4);
    VT = x(1); % TAS in fps
    ALPHA= RTOD*x(2); % A.O.A.
    THETA= x(3); % PITCH ATTITUDE
    Q = x(4); % PITCH RATE
    H = x(5); % ALTITUDE
    %
    [MACH,QBAR]= ADC(VT,H);
    QS = QBAR*S;
    SALP= sin (x(2)); CALP= cos(x(2));
    GAM = THETA − x(2); SGAM= sin (GAM); CGAM= cos(GAM);
    if LAND == 0 % CLEAN
        CLO= .20; CDO= .016;
        CM0= .05; DCDG= 0.0; DCMG= 0.0;
    elseif LAND == 1 % LANDING FLAPS & GEAR
        CLO= 1.0; CDO= .08;
        CMO= −.20; DCDG= .02; DCMG= −.05;
    else
        disp(‘Landing Gear & Flaps ?’)
    end
    THR= (TSTAT+VT*DTDV) * max(THTL,0); % THRUST
    CL=CLO+CLA*ALPHA; % NONDIM. LIFT
    CM=DCMG+CMO+CMA*ALPHA+CMDE*ELEV+CL* (XCG-.25); % MOMENT
    CD=DCDG+CDO+CDCLS*CL*CL; % DRAG POLAR
    %
    % STATE EQUATIONS NEXT
    xd(1) = (THR*CALP-QS*CD)/MASS - GD*SGAM;
    xd(2)=(-THR*SALP-QS*CL+MASS*(VT*Q+GD*CGAM))/(MASS*VT+QS*CLADOT);
    Xd(3) = Q;
    D = .5*CBAR*(CMQ*Q+CMADOT*xd(2))/VT; % PITCH DAMPING
    Xd(4) = (QS*CBAR*(CM + D) + THR*ZE)/IYY; % Q-DOT
    Xd(5) = VT*SGAM; % VERTICAL SPEED
    Xd(6) = VT*CGAM; % HORIZNTL. SPEED
end
