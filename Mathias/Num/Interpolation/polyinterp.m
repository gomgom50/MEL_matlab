function yint = polyinterp(x,y,xx)
% polyinterp: Polynomial interpolation
% yint = polyinterp(x,y,xx): Uses an (n-1)-order
% polynomial based on n data points (x, y)
% to determine a value of the dependent variable (yint)
% at a given value of the independent variable, xx.
% input:
% x = vector with values of the independent variable
% y = vector with corresponding values of the
% dependent variable
% xx = value of independent variable at which
% interpolation is calculated
% output:
% yint = interpolated value of dependent variable
n = length(x);
if length(y)~=n, error('x and y must be same length'); end

p = polyfit(x, y, n-1);

yint = polyval(p,xx)

% Add lines that implement polynomial interpolation
% using polyfit and polyval.
end