function [YI] = interlim2(X,Y,XI)

% *********************************************
% interlim1 - 	1-D Interpolate with checking 
% 		(and modification) of limits
% *********************************************     
%
% A&AE 421 Fall 2001
% Matthew Wysel
% Jaret Matthews
%
%   INTERLIM1 1-D interpolation (table lookup).   
%   YI = INTERP1(X,Y,XI) interpolates to find YI, the values of
%   the underlying function Y at the points in the vector XI.
%   The vector X specifies the points at which the data Y is
%   given. If Y is a matrix, then the interpolation is performed
%   for each column of Y and YI will be length(XI)-by-size(Y,2).
%   Out of range values are returned as NaN. 
%    FOR MORE HELP SEE interp2.m
%
% In addition to performing 1-D interpolation, this function file 
% checks that each XI is within the range of X. If it is, then 
% the value is passed without alteration, if not then it sets the 
% outlying value to the maximum allowable value and returns a 
% warning to the screen.
%
% All arrays must be vectors (ie ndim(variable)=1)
%
% For example, if XI = 15 and length(X) = 10 then XI would be 
% set to 10 and a warning would be sent to the screen
%
% See also INTERP1 - MATLABs generic 1-D interpolation.

% Checking that X,Y are vectors
if ((size(X)>2)|((size(X,1)>1)&(size(X,2)>1)))
   warning on
   warning('Input variable must be a vector (ie ndims(variable)=1)')
   warning backtrace
   warning('See helpfile')
   warning off   
end

% Checking the limits
if XI > max(X)
   warning on
   warning([num2str(XI),' exceeded interpolation limits'])
   warning backtrace
   warning([num2str(XI),' was converted to ',num2str(max(X))])
   XI = max(X);
   warning off   
elseif XI < min(X)   
   warning on  
   warning([num2str(XI),' exceeded interpolation limits'])
   warning backtrace
   warning([num2str(XI),' was converted to ',num2str(min(X))])
   XI = min(X);
   warning off   
end

YI = interp1(X,Y,XI);

return