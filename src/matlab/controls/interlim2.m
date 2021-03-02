function [VI] = interlim3(X,Y,V,XI,YI)

% *********************************************
% interlim3 - 	3-D Interpolate with checking 
% 		(and modification) of limits
% *********************************************     
%
% A&AE 421 Fall 2001
% Matthew Wysel
%
%   INTERP2 2-D interpolation (table lookup).
%    ZI = INTERP2(X,Y,Z,XI,YI) interpolates to find ZI, the values of the
%    underlying 2-D function Z at the points in matrices XI and YI.
%    Matrices X and Y specify the points at which the data Z is given. 
%    FOR MORE HELP SEE interp3.m
%
% In addition to performing 2-D interpolation, this function file 
% checks that each XI and YI is within the range of X and Y
% respectively. If it is, then the value is passed without 
% alteration, if not then it sets the outlying value to the 
% maximum allowable value and returns a warning to the screen.
%
% For example, if XI = 15 and length(X) = 10 then XI would be 
% set to 10 and a warning would be sent to the screen
%
% See also INTERP2 - MATLABs generic 2-D interpolation.

% Start of an attempt at making the variables matrix compadable
%[m,n] = size(XI)
%for i:M for j:n
%	if XI(i,j) > X(i,j)
%   	XI(i,j) = X(i,j);
%   	warning([num2str(XI(i,j)),' converted to ',num2str(X)
%   end
%end end

if XI > max(X)
 	warning([num2str(XI),' exceeded interpolation limits'])
 	warning([num2str(XI),' was converted to ',num2str(max(X))])
  	XI = max(X);
 elseif XI < min(X)   
 	warning([num2str(XI),' exceeded interpolation limits'])
 	warning([num2str(XI),' was converted to ',num2str(min(X))])
   XI = min(X);
end

if YI > max(Y)
 	warning([num2str(YI),' exceeded interpolation limits'])
 	warning([num2str(YI),' was converted to ',num2str(max(Y))])
  	YI = max(Y);
 elseif YI < min(Y)   
 	warning([num2str(YI),' exceeded interpolation limits'])
 	warning([num2str(YI),' was converted to ',num2str(min(Y))])
   YI = min(Y);
end

VI = interp2(X,Y,V,XI,YI);

return