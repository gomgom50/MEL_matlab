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

% Pmidl = 185; 
% Pmax = 214; 
% Lmax = 125; 
% a = 1.2; 
% k = 1.3; 
% d = 0.03; 
% S0 = 24; 
% B0 = 66; 
% 
%                       Herunder 2 ligniner indsættes
% dYdt = @(t,Y) [a*(Pmidl - Pmax + k*Y(2)), Lmax*exp(-d*Y(2)) - Y(1)]; 
% Y0 = [S0 B0]; 
% tidsinterval = [0 5]; 
% h = 0.25; 
% [t,Y] = eulsys(dYdt,tidsinterval,Y0,h); 
% S = Y(:,1); 
% B = Y(:,2); 
% 
% disp(table(t,S,B,'VariableNames',{'t, uger','S, enh./uge','B, enh.'}))
