function OP = VarmeovergangsModstand_alpha(R0, alpha, Areal)

% Det input der skal findes sættes til nan

syms R_0 alpha_iy A

inputs = [R0, alpha, Areal];
symbols = [R_0 alpha_iy A];


var = isnan(inputs);
ind = find(var==1);

disp("Energiligningen opstilles:")
eq = R_0 == 1/(alpha_iy*A)

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")

if OP < 0.01 && ind == 1
    inputs(ind) = OP*1000;
    units = ["K/kW";"W/m2*K";"m2"];
else
    inputs(ind) = OP;
    units = ["K/W";"W/m2*K";"m2"];
end

names = ["Modstand";"Varmeovergangstal";"Areal"];


disp(table(names,round(inputs,5)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
