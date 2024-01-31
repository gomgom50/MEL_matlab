function [t,y] = eulode(dydt,tspan,y0,h)
% eulode: Euler ODE solver
%   [t,y] = eulode(dydt,tspan,y0,h):
%           uses Euler's method to integrate an ODE
% input:
%   dydt = name of the M-file that evaluates the ODE
%   tspan = [ti, tf] where ti and tf = initial and
%   final values of independent variable
%   y0 = initial value of dependent variable
%   h = step size
% output:
%   t = vector of independent variable
%   y = vector of solution for dependent variable
if nargin<4,error('at least 4 input arguments required'),end
ti = tspan(1);tf = tspan(2);
if ~(tf>ti),error('upper limit must be greater than lower'),end
t = (ti:h:tf)'; 
n = length(t);
% if necessary, add an additional value of t
% so that range goes from t = ti to tf
if t(n)<tf
  t(n+1) = tf;
  n = n+1;
end
y = y0*ones(n,1); %preallocate y to improve efficiency
for i = 1:n-1 %implement Euler's method
  y(i+1) = y(i) + dydt(t(i),y(i))*(t(i+1)-t(i));
end

% eksemple på couplede

% A_b = 1.85; %m^2
% A_u = 0.002; %m^2
% g = 9.81; %m/s^2
% h_0 = 2.1; %m
% t_start = 0;
% t_I = A_b / A_u * sqrt(2 * h_0 / g);
% 
% dYdt = @(t,Y) A_u / A_b * (sqrt(2 * g) * (sqrt(h_0) - sqrt(Y(1))) - g * A_u / A_b * t); 
% Y0 = h_0; 
% tidsinterval = [t_start t_I]; 
% h = 60; 
% [t,Y] = eulode(dYdt,tidsinterval,Y0,h); 
% % x = Y(1) 
% 
% 
% disp(table(t,Y,'VariableNames',{'t, (s)','x, (m)'}))

