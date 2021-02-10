%% Function that sizes the aircraft for the given input parameters
% The approach follows Raymer Ch.6
% The design mission is assumed to be:
%
%              ______cruise_____
%             /                 \ descend
%            /                   \___
%           /climb                \_/ loiter
%          /                        \ 
%_________/                          \_____ 
%taxi & TO                          landing & taxi
%
% Note that no reserve segment is present here. 
% Additional mission segments can be added but this function must be
% changed to accomodate these.
%%
function FinalOutput = SizingIterations(inputs)

    %% Start Aircraft Sizing Iterations
    TOGW_temp = 911000;        % guess of takeoff gross weight [lbs] 

    % Global optimization to optimize the gross weight
    start = TOGW_temp;
    lb = 0; ub = TOGW_temp*10;
    A = []; b = [];
    Aeq = []; beq = [];
    options = optimoptions("patternsearch","MeshTolerance",1e-10,"FunctionTolerance",1e-10);
    objective = @(TOGW_temp) sizingObjFunc(TOGW_temp, inputs);
    [TOGW_temp, fval] = patternsearch(objective,start,A,b,Aeq,beq,lb,ub,options);

    % Display the final difference in TOGW(n+1) - TOGW(n)
    disp(fval);

    % Open and read the JSON file that was generated inside the sizingObjFunc 
    % because we need some of the values calculated inside that function file.
    % The JSON file will be read as a structure 
    temp_struct = readJSON2struct("temp.json");
    EmptyWeightOutput = temp_struct.EmptyWeightOutput;
    Wfuel = temp_struct.Wfuel;
    inputs = temp_struct.inputs;

    % EmptyWeightOutput
    TOGW = TOGW_temp;                  % Aircraft takeoff gross weight [lbs]
    EWF  = EmptyWeightOutput.We/TOGW;  % Empty weight fraction

    %% Aggregate results
    FinalOutput             = inputs;
    FinalOutput.EmptyWeight = EmptyWeightOutput;
    FinalOutput.TOGW        = TOGW;
    FinalOutput.Wfuel       = Wfuel;
    FinalOutput.Thrust       = inputs.Sizing.Thrust;
end
