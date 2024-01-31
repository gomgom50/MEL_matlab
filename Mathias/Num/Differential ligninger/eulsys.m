function [t,Y] = eulsys(dYdt,tspan,Y0,h)
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
Y(1,:) = Y0;
for i = 1:n-1
  Y(i+1,:) = Y(i,:) + dYdt(t(i),Y(i,:))*h;
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