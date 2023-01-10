function [J,f] = jacobifunk(X)
x = X(1); y = X(2);
f = [12.0+313*y-1466*y^2+7.69*x-126*x*y+878*x*y^2-2.42*x^2+34.1*x^2*y-213*x^2*y^2-34
     <UDFYLD>];
J = [<UDFYLD>, <UDFYLD>
     <UDFYLD>, <UDFYLD>];