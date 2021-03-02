
%% Function that estimates aircraft acquisition cost
% This is applicable only for transport and commercial passenger aircraft
% Need to be modified for General Aviation aircraft and other studies
% Parithi Govindaraju - January 2015

function output = AcquisitionCostFunction(inputs)

%% Inputs
num_engines = inputs.PropulsionInputs.num_eng; % number of engines
Thrust      = inputs.Sizing.Thrust;            % total required thrust [lbs]  
V           = inputs.PerformanceInputs.V;      % aircraft design cruise velocity [kts]
Mmax        = inputs.PerformanceInputs.M;      % aircraft maximum Mach number
We          = inputs.EmptyWeight.We;           % aircraft empty weight [lbs]
pax         = inputs.MissionInputs.pax;        % number of passengers
%% Internal function parameters
Q      = 600;     % lesser of production quantity or number to be produced in 5 yrs
FTA    = 4;       % number of flight test aircraft (typically 2-6)
Tinlet = 2850;    % turbine inlet temperature (deg. R)
CIpax  = 2500;    % cost of interior [$ per seat]
Caviac = 4000000; % cost of avionics per aircraft [$/aircraft]  

Ree = 86;         % hourly rate for engineering [$/hour]
Rt  = 88;         % hourly rate for tooling [$/hour]
Rq  = 81;         % hourly rate for quality control [$/hour]
Rm  = 73;         % hourly rate for manufacturing [$/hour]

%% Computations
Neng = Q*num_engines;               % total engines: production quantity x # engines per aircraft
Tmax = Thrust/num_engines;          % engine maximum thrust (lbs)

He = 7.07*We^.777*V^.894*Q^.163;    % engineering hours
Ht = 8.71*We^.777*V^.696*Q^.263;    % tooling hours
Hm = 10.72*We^.82*V^.484*Q^.641;    % manufacturing hours
Hq = 0.133*Hm;                      % Quality Control hours

Cdd =66*We^.63*V^1.3;               % development support cost [$]
Cf = 1807.1*We^.325*V^.822*FTA^1.21;% flight test cost [$]
Cm = 16*We^.921*V^.621*Q^.799;      % manufacturing materials cost [$]
Ceng = (2251*(.043*Tmax+243.25*Mmax+.969*Tinlet-2228))*1.175; % engine production cost [$]
Cint = (pax*CIpax)*Q;                % total interior cost (for all Q aircraft) [$]
Cavi = Caviac*Q;                     % total avionics cost (for all Q aircraft) [$]

% Airframe production cost (for all Q aircraft) DAPCA IV
  ACi = (He*Ree + Ht*Rt + Hm*Rm + Hq*Rq + Cdd + Cf + Cm + Cavi + Cint)*0.9; 
% Aircraft production cost - DAPCA prediction adjusted (tends to overestimate by 10%)
  AC = ACi/Q + Ceng*num_engines;    

%% OUTPUT
output.AqCost  = AC;
output.EngCost = Ceng;
