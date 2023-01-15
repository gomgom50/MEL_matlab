function [J,f] = Jogf(X)
x = X(1); y = X(2);
f = [4*x - 5*y - y^2 + x*y + 10 
    6*x + y - 15];
J = [y + 4, x-2*y-5
    6, 1];