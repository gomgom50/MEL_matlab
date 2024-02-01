function OP = BernuillisLigning_UdenFriktion(p1,p2,c1,c2,z1,z2,dens)

% For ukendt variable: NaN



syms p_1 p_2 c_1 c_2 z_1 z_2 rho g

inputs = [p1, p2,   c1, c2,z1,z2,dens];
symbols = [p_1 p_2 c_1 c_2 z_1 z_2 rho g];

grav = 9.82;

var = isnan(inputs);
ind = find(var==1);


disp("Energiligning 4.20:")
eq = p_2/rho + c_2^2/2 + g*z_2 == p_1/rho + c_1^2/2 + g*z_1

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")



inputs(ind) = [];
inputs(end+1) = grav;
symbols(ind) = [];

OP = vpa(subs(sol,symbols,inputs),5)



end