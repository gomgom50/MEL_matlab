function [t,Y, X] = eulsys(dYdt,dXdt, tspan,Y0, X0,h)
% eulsys: Euler solver for a system of ODEs
%   [t,Y] = eulsys(dYdt,tspan,Y0,h): uses Euler's
%     method to solve a system of first order 
%     differential equations.
% input:
%   dYdt = a function of (t,Y), where t is the independent
%     variable (scalar) and Y is a row vector of the 
%     dependent variables. The function should return a
%     row vector of derivatives of the independent
%     variables as given by the differential equations.
%   tspan = [ti, tf] where ti and tf = initial and
%     final values of independent variable
%   Y0 = initial value of dependent variables (row
%     vector)
%   h = step size
% output:
%   t = vector with values of the independent variable
%   Y = matrix with solution values of the dependent
%     variables. Each column represents one dependent 
%     variable
ti = tspan(1);
tf = tspan(2);
t = (ti:h:tf)';
n = length(t);
X(1,:) = X0;
Y(1,:) = Y0;
for i = 1:n-1
  X(i+1,:) = X(i,:) + dXdt(t(i),X(i,:))*h;
  Y(i+1,:) = Y(i,:) + dYdt(t(i),Y(i,:))*h;
end