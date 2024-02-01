function d = massemidtdist(m,r)
n = length(m);
M = sum(m);
delta = 360/n;
sum_mx = 0;
sum_my = 0;
for i = 1:n
  theta = (i-1)*delta;
  x = r * cosd(theta);
  y = r * sind(theta);
  sum_mx = sum_mx + m(i) * x ;
  sum_my = sum_my + m(i) * y ;
end
xc = sum_mx/M;
yc = sum_my/M;
d = sqrt(xc^2 + yc^2);

