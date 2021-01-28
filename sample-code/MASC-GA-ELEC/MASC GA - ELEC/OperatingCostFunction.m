
%% Function that estimates aircraft Direct Operating Cost + Interest (DOC+I)
% Based on the work of Liebeck et al. NASA CR-195443 (1995)
% This is applicable only for transport and commercial passenger aircraft
% Need to be modified for General Aviation aircraft and other studies
% Parithi Govindaraju - January 2015

function output = OperatingCostFunction(SizingOutputs,AqCostInputs,EconMissionOutput)

%% Inputs
Wto          = SizingOutputs.TOGW ;                    % aircraft maximum takeoff gross weight [lbs]
We           = SizingOutputs.EmptyWeight.We;           % aircraft empty weight [lbs]
Weng         = SizingOutputs.EmptyWeight.Weng;         % engine weight [lbs]
Thrust       = SizingOutputs.Thrust;                   % aircraft total thrust [lbs]
Wtom         = EconMissionOutput.Wto;                  % aircraft takeoff gross weight for mission [lbs]
Wf           = EconMissionOutput.Wfuel;                % mission fuel weight required for leg [lbs]

V            = SizingOutputs.PerformanceInputs.V;      % cruise velocity [knots]
AqC          = AqCostInputs.AqCost;                    % aircraft acquisition cost [$]
Ceng         = AqCostInputs.EngCost;                   % engine cost [$]
num_engines  = SizingOutputs.PropulsionInputs.num_eng; % number of engines
route        = SizingOutputs.EconMission.range;        % economic mission length [nmi]

crewnum      = SizingOutputs.LayoutOutput.pilots; 
flcrewnum    = SizingOutputs.LayoutOutput.flcrew;
%% Function Parameters
leg_num = 3;                   % number of legs per day
day_num = 365;                 % number of operating days per year
turnarnd = 1;                  % turnaround time per leg [hours]

fuelprc  = 4.04/6.7;           % price of fuel per lbs (6.7 lbs/gal)
lr       = 25;                 % labor rate = 25 dollars/hr (for total aircraft maintenance)
hr       = 60;                 % dollars per hour paid to flight attandents
residual = 0.1;                % residual value of aircraft (percentage acquisition price)
Period   = 15;                 % depreciation period [years]
IR       = 0.08;               % interest rate
AS       = 0.06;               % airframe spares
ES       = 0.23;               % engine spares
  
%% Computations required for DOC+I methodology
legtime  = route/V + turnarnd; % time it takes to travel route 1 (one direction only): (6076/3600)= 1.69
numlegs  = day_num*leg_num;    % number of legs per year

BH = numlegs*legtime;          % block hours [hours/year]
FV = AqC*residual;             % future value of aircraft [$]
PV = AqC;                      % present value of aircraft (aircraft cost) [$]
w_frame = We - Weng;           % airframe weight (minus engines and payload) [lbs]
ACf = AqC-Ceng*num_engines;    % aircraft cost - engine cost [$]

%% Direct Operating Cost + Interest  - Liebeck et al. NASA CR-195443 (1995)
% flight crew cost per leg
  flcrew  = legtime*crewnum*(440 + 0.532*(Wto/1000));
% cabin crew cost per leg
  cabcrew = legtime*flcrewnum*hr;
% maintenance hours per leg
  MHT = (1.26 + 1.774*(w_frame/100000) - 0.1071*(w_frame/100000)^2)*legtime +...
    (1.614 + 0.7227*(w_frame/100000) + 0.1024*(w_frame/100000)^2);
% airframe labor cost per leg
  ALC = MHT*lr;
% material cost per leg (airframe maintenance materials)
  MCT = (12.39 + 29.8*(w_frame/100000) + 0.1806*(w_frame/100000)^2)*legtime +...
    (15.2 + 97.33*(w_frame/100000) - 2.862*(w_frame/100000)^2);
% airframe material cost per leg
  AMC = MCT;
% aircraft burden per leg
  AB = 2*ALC;
% TOTAL AIRFRAME MAINTENANCE COST per leg
  TAMC = ALC + AMC + AB;
% maintenance hours per leg; engine
  MHTe = (0.645 + (0.05*(Thrust/num_engines)/10000))*(0.566 + 0.434/legtime)*legtime*num_engines;
% engine labor cost per leg
  ELC = MHTe*lr;
% material cost per leg; engine
  MCTe = (25 + 18*(Thrust/num_engines)/10000)*(0.62 + 0.38/legtime)*legtime*num_engines;
% engine material cost per leg
  EMC = MCTe;
% engine burden per leg
  EB = num_engines*ELC;
% TOTAL ENGINE MAINTENANCE COST per leg
  TEMC = ELC + EMC + EB;
% landing fee
  LF = 1.5*((Wtom - Wf)/1000);
% depreciation per leg
  Dep = (((1-residual)*(AqC/Period) + AS*(ACf/Period) + ES*((Ceng*num_engines)/Period)))/numlegs;
% insurance per leg
  Ins = 0.0035*AqC/numlegs;
% interest per leg
  Int = (((IR*(FV + PV*((1+IR^(2*Period))/(-1+(1+IR)^(2*Period)))))))/numlegs;
  
% fuel per trip
  fuel = fuelprc*Wf;
% DIRECT OPERATING COST per leg
  DOC = flcrew + cabcrew + TAMC + TEMC + Dep + Ins + Int + LF;
  DOCtot = DOC + fuel*numlegs;
% DIRECT OPERATING COST (per leg)
%DOC_trip = DOC/numtrips + fuel;
  DOC_leg = DOCtot/numlegs;
% DIRECT OPERATING COST (per block hr)
  DOC_BH = DOCtot/BH;
  
%% Outputs
output.DOC_leg = DOC_leg;
output.DOC_BH  = DOC_BH;
