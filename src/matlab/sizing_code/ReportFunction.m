% Function that displays aircraft sizing results

function [] = ReportFunction(inputs)

    fprintf('%s%6.0f%s \n','Takeoff Gross Weight:  ',inputs.TOGW,' lbs')
    fprintf('%s%6.0f%s \n','Fuel Weight:           ',inputs.Wfuel,' lbs')
    fprintf('%s%6.0f%s \n','Payload Weight:        ',inputs.PayloadInputs.w_payload,' lbs')
    fprintf('%s%6.0f%s \n','Empty Weight:          ',inputs.EmptyWeight.We,' lbs')
    fprintf('%s%6.4f%s \n','Empty Weight Fraction: ',inputs.EmptyWeight.We/inputs.TOGW,' ')
    fprintf('%s%6.4f%s \n','Fuel Weight Fraction:  ',inputs.Wfuel/inputs.TOGW,' ')
    fprintf('%s \n','------------------------------------          ')
    % fprintf('%s \n','Empty Weight breakdown          ')
    % fprintf('%s \n','____________________________________          ')
    % fprintf('%s%6.0f%s \n','           Wing:        ',inputs.EmptyWeight.Wwing,' lbs')
    % fprintf('%s%6.0f%s \n','           Fuselage:    ',inputs.EmptyWeight.Wfus,' lbs')
    % fprintf('%s%6.0f%s \n','           Vtail:       ',inputs.EmptyWeight.WVtail,' lbs')
    % fprintf('%s%6.0f%s \n','           Htail:       ',inputs.EmptyWeight.WHtail,' lbs')
    % fprintf('%s%6.0f%s \n','           Engines:     ',inputs.EmptyWeight.Weng,' lbs')
    % fprintf('%s%6.0f%s \n','           Gear:        ',inputs.EmptyWeight.Wgear,' lbs')
    % fprintf('%s%6.0f%s \n','           Misc:        ',inputs.EmptyWeight.Wmisc,' lbs')
    % fprintf('%s \n','------------------------------------          ')
    % fprintf('%s \n','Costs          ')
    % fprintf('%s \n','____________________________________          ')
    % fprintf('%s%6.0f%s \n','Acquisition Cost:       $ ',inputs.AqCostOutput.AqCost,' ')
    % fprintf('%s%6.0f%s \n','Operating Cost (DOC+I): $   ',inputs.OpCostOutput.DOC_leg,' /leg')
    % fprintf('%s%6.0f%s \n','Operating Cost (DOC+I): $   ',inputs.OpCostOutput.DOC_BH,' /BH')

    % Save structure as JSON file 
    saveJSONfile(inputs, 'output.json')
end 