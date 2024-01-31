function yy = myspline(x,y,xx,type)
% myspline: various MATLAB splines combined in one function
% yy = myspline(x,y,xx,type): uses selected spline
% interpolation to find yy, the values of the underlying function
% y at the points in the vector xx. The vector x specifies the
% points at which the data y is given.
% input:
% x = vector with values of the independent variables
% y = vector with values of the dependent variables.
% If type = 'clamped', then length(y) must be 2
% greater than length(x), and y(1) and y(end) must
% contain the desired slopes of the spline ends.
% xx = vector of desired values of independent variable
% type = type of interpolation: 'not-a-knot', 'natural',
% 'clamped', 'pchip', 'nearest' og 'linear'.
% output:
% yy = interpolated values at xx
if strcmp(type,'not-a-knot') % Hvis type er lig med 'not-a-knot'
    yy = spline(x,y,xx);

elseif strcmp(type,'natural') % Hvis type er lig med 'natural'
    pp = csape(x,y,'second')
    yy = fnval(pp,xx)

elseif strcmp(type,'Clamped')
    yy = spline(x,y,xx)

elseif  strcmp(type,'pchip')
    yy = interp1(x,y,xx,'pchip')

end