function dfdx = numdiff(f,x)
% numdiff - Numerisk differentiation
% Kald: dfdx = numdiff(f,x)
% Input:
% f = funktion hvis differentialkvotient skal findes
% x = værdi af x for hvilken differentialkvotienten skal findes
% Output:
% dfdx = differentialkvotient
h = 10^-3;
dfdx = (f(x + h) - f(x))/h; 
end