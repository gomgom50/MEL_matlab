function resultat = driftomr(x,y)
a1 = 0.1637; b1 = 0.237; c0 = -0.01425;
s0 = -0.01113; x0 = 2.164; y0 = 0.2185;
xmin = 1; xmax = 4; ymin = 0.03;
ymax1 = @(x) a1*(x-x0)^4 + b1*(x-x0)^3 + c0*(x-x0)^2 + s0*(x-x0) + y0;
ymax2 = @(x) c0*(x-x0)^2 + s0*(x-x0) + y0;
if <UDFYLD>
 <UDFYLD FLERE LINJER>
end