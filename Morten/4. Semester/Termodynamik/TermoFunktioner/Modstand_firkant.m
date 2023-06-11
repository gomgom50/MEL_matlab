function OP = Modstand_firkant(Ri, Areal, tykkelse, varmeKonduktivitet)

% Det input der skal findes sættes til nan

syms R_i A delta lambda

inputs = [Ri, Areal, tykkelse, varmeKonduktivitet];
symbols = [R_i A delta lambda];


var = isnan(inputs);
ind = find(var==1);

disp("Formlen for varmeovergangsmodstand bruges:")
eq = R_i == delta/(lambda*A)

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


if OP < 0.01 && ind == 1
    inputs(ind) = OP*1000;
    units = ["K/kW";"m2";"m";"W/m*K"];
else
    inputs(ind) = OP;
    units = ["K/W";"m2";"m";"W/m*K"];
end




names = ["Modstand";"Varmetab";"Fluid temperatur";"Væg temperatur"];


disp(table(names,round(inputs,5)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
