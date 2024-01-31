function [t,y] = rk4(dydt,tspan,y0,h)
% rk4: fourth-order Runge-Kutta for a first order ODE
%   [t,y] = rk4(dydt,tspan,y0,h): solves a first order
%           ODE with fourth-order Runge-Kutta method
% input:
%   dydt = name of the function that evaluates dy/dt
%          as a function of (t,y) 
%   tspan = [ti, tf]: initial and final times
%   y0 = initial value of dependent variable
%   h = step size
% output:
%   t = vector of time values
%   y = vector of solution for the dependent variable
ti = tspan(1);  % Initial time
tf = tspan(2);  % Final time
t = (ti:h:tf)'; % Vector of times
n = length(t);
y(1) = y0;
for i = 1:n-1
  k1 = dydt(t(i),y(i));
  tmid1 = t(i) + h/2;
  ymid1 = y(i) + k1*h/2;
  k2 = dydt(tmid1,ymid1);
  tmid2 = t(i) + h/2;
  ymid2 = y(i) + k2*h/2;
  k3 = dydt(tmid2,ymid2);
  tend = t(i) + h;
  yend = y(i) + k3*h;
  k4 = dydt(tend,yend);
  phi = (k1 + 2*k2 + 2*k3 + k4)/6;
  y(i+1) = y(i) + phi*h;
end
y = y'; % Transpose y to change from row to column vector