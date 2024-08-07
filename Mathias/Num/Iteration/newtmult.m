function [x,f,ea,iter] = newtmult(func,x0,es,maxit)
% newtmult: Newton-Raphson root zeroes nonlinear systems
%   [x,f,ea,iter]=newtmult(func,x0,es,maxit):
%     uses the Newton-Raphson method to find the roots of
%     a system of nonlinear equations
% input:
%   func = name of function that returns f and J
%   Indsættes som fx @jacobifunk
%   x0 = initial guess OBS -- i form af vektor [x; y]
%   es = desired percent relative error (default = 0.0001%)
%   maxit = maximum allowable iterations (default = 50)
% output:
%   x = vector of roots
%   f = vector of functions evaluated at roots
%   ea = approximate percent relative error (%)
%   iter = number of iterations
if nargin<2, error('at least 2 input arguments required'), end
if nargin<3 || isempty(es), es = 0.0001; end
if nargin<4 || isempty(maxit), maxit = 50; end
iter = 0;
x = x0;
while 1
  [J,f] = func(x);
  dx = J\f;
  x = x-dx;
  iter = iter + 1;
  ea = 100*max(abs(dx./x));
  if iter>=maxit || ea<=es, break, end
end