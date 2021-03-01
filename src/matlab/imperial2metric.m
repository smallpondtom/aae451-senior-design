function x = imperial2metric(val, unit)
%{ 
    This file converts imperial units to metric 
    input << 
    val : value to convert 
    unit : the unit (in imperial) of the given value
    
    output >> 
    x : the converted value 
    u : the metric unit 
%}

    % Array of possible imperial unit input 
    possible_units = ["lb","lbf","ft","in","hp","ft^2","ft^3","ft/s","nmi","lb/ft^2","knot","slug/ft^3", "lb/lbf-hr"];

    % Assertion for input validation 
    assert(any(possible_units(:) == unit), 'The only possible imperial units are lb, ft, in, hp, ft^2, ft^3, ft/s, nmi, lb/ft^2, knot, slug/ft^3,lb/lbf-hr');
    idx = find(possible_units == unit);  % the corresponding index in the possible_units array for the unit input

    if idx == 1
        % convert lb to kg
        x = 0.453592 * val;
    elseif idx == 2
        % convert lbf to N 
        x = 4.44822 * val;
    elseif idx == 3
        % convert ft to m
        x = 0.3048 * val;
    elseif idx == 4
        % convert in to m
        x = 0.0254 * val;
    elseif idx == 5
        % convert hp to W or J/s
        x = 745.7 * val;
    elseif idx == 6
        % convert ft^2 to m^2
        x = 0.092903 * val;
    elseif idx == 7
        % Convert ft^3 to m^3
        x = 0.0283168 * val;
    elseif idx == 8
        % convert ft/s to m/s 
        x = 0.3048 * val;
    elseif idx == 9
        % convert nmi to m
        x = 1852 * val;
    elseif idx == 10
        % convert lb/ft^2 to kg/m^2
        x = 4.88242764 * val;
    elseif idx == 11
        % convert knot to m/s
        x = 0.514444 * val;
    elseif idx == 12
        % convert slug/ft^3 to kg/m^3
        x = 515.379 * val;
    else
        % convert lb/lbf-hr to kg/N-s
        x = 0.453592 / 4.44822 / 3600 * val;
    end
end