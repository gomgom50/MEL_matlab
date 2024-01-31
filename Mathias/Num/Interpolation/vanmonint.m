function yint = vanmonint(x,y,xx)
% vanmonint: Polynomial interpolation based on a
% Vandermonde coefficient matrix
% yint = vanmonint(x,y,xx): Uses an (n-1)-order
% interpolating polynomial based on n data points (x, y)
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
% Build the Vandermonde coefficient matrix, A
A = vanmonmat(x);
% Next lines solves a matrix equation to find the polynomial coefficients
b = y(:); % The (:) ensures that y be becomes a column vector
p = A\b; % Solve for polynomial coefficients
% Next lines calculate the value of the polynomial in xx
yint = 0;
for i = 1:n % i indicates a numbering of the n terms in the polynomial
 yint = yint + p(i) * xx^(n-i); %p(i)*xx^(n-i)
end
end