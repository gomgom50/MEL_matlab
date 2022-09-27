function dfdx = numdiff(f,x)
h = 0.001;
dfdx = (f(x+h) - f(x))/h;