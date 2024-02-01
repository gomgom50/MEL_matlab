function OP = VarmeovergangsModstand_temps(R0, phi_varme, temp_ydre, temp_indre)

% Det input der skal findes sættes til nan

syms R_0 Phi t_fl t_v

inputs = [R0, phi_varme, temp_ydre, temp_indre];
symbols = [R_0 Phi t_fl t_v];


var = isnan(inputs);
ind = find(var==1);

disp("Formlen for varmeovergangsmodstand bruges:")
eq = R_0 == (t_fl - t_v)/Phi

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


if OP < 0.1 && ind == 1
    inputs(ind) = OP*1000;
    units = ["K/kW";"W";"C";"C"];
else
    inputs(ind) = OP;
    units = ["K/W";"W";"C";"C"];
end





names = ["Modstand";"Varmetab";"Fluid temperatur";"Væg temperatur"];


disp(table(names,round(inputs,5)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
