function OP = Modstand_cylinder(Ri, r1,r2,Length, varmeKonduktivitet)

% Det input der skal findes sættes til nan

syms R_i r_1 r_2 L lambda

inputs = [Ri, r1,r2,Length, varmeKonduktivitet];
symbols = [R_i r_1 r_2 L lambda];


var = isnan(inputs);
ind = find(var==1);

disp("Formlen for varmeovergangsmodstand bruges:")
eq = R_i == log(r_2/r_1)/(lambda*2*pi*L)

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


if OP < 0.01 && ind == 1
    inputs(ind) = OP*1000;
    units = ["K/kW";"m";"m";"m";"W/m*K"];
else
    inputs(ind) = OP;
    units = ["K/W";"m";"m";"m";"W/m*K"];
end




names = ["Modstand";"Indre radius";"Ydre radius";"Rørlængde";"Varmekonduktivitet"];


disp(table(names,round(inputs,5)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
