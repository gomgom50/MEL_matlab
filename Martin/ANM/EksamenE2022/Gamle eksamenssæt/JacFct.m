function [J,f] = JacFct(X) 
x = X(1); y = X(2); z = X(3); 
f = [(y^2)*exp(-x*z) - 1 
     x + y + z - 1 
     x*(y^2) - 4*z + (x^3)*z - 2]; 
J = [-(y^2)*z*exp(-x*z), 2*y*exp(-x*z), -x*(y^2)*exp(-x*z)
    1.0, 1.0, 1.0
    3*z*(x^2)+y^2, 2*x*y, (x^3)-4];
end