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
    
    % --->(MODIFICATION REQUIRED) TOMO
    % We need to estimate the TOGW_temp using the method in Raymer Ch.15 
    % Page 404 for General Aviations to come up with a rough estimate of
    % our aircraft. However we CANNOT use the equations directly. We MUST
    % carefully calibrate the provided equations with idea of more closely
    % matching new aircraft since the Raymer database is only for old
    % aircraft.
    
    TOGW_temp = 911000;        % guess of takeoff gross weight [lbs] 
    
    % <---(END)
    
    
    % --->(MODIFIDE) TOMO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Global optimization to optimize the gross weight
    % Using the function "sizingObjFunc.m"
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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % <---(END OF MODIFICATION) 

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
