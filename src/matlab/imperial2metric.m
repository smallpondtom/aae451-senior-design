function [x, u] = imperial2metric(val, unit)
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
    possible_units = ['lb','lbf','ft','in','hp','ft2','ft3','ft/s','nmi'];

    % Assertion for input validation 
    assert(any(possible_units(:) == unit), 'The only possible imperial units are lb, ft, in, hp, ft^2, ft^3, and ft/s.');
    idx = find(possible_units == unit);  % the corresponding index in the possible_units array for the unit input

    if idx == 1
        % convert lb to kg
        x = 0.453592 * val;
        u = 'kg';
    elseif idx == 2
        % convert lbf to N 
        x = 4.44822 * val;
        u = 'N';
    elseif idx == 3
        % convert ft to m
        x = 0.3048 * val;
        u = 'm';
    elseif idx == 4
        % convert in to m
        x = 0.0254 * val;
        u = 'm';
    elseif idx == 5
        % convert hp to W or J/s
        x = 745.7 * val;
        u = 'W';
    elseif idx == 6
        % convert ft^2 to m^2
        x = 0.092903 * val;
        u = 'm2';
    elseif idx == 7
        % Convert ft^3 to m^3
        x = 0.0283168 * val;
        u = 'm3';
    elseif idx == 8
        % convert ft/s to m/s 
        x = 0.3048 * val;
        u = 'm/s';
    else
        % convert nmi to m
        x = 1852 * val;
        u = 'm';
    end
end