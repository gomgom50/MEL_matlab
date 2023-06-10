function OP = massestrom_all(phi0, qmr, h1, h4)

% Det input der skal findes sættes til nan

syms Phi q_mR h_1 h_4

inputs = [phi0, qmr, h1, h4];
symbols = [Phi q_mR h_1 h_4];


var = isnan(inputs);
ind = find(var==1);

disp("Energiligningen opstilles:")
eq = q_mR*(h_1 - h_4) + Phi == 0

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Phi ";"Massestrøm";inputname(3);inputname(4)];
units = ["W";"kg/s";"J/kg";"J/kg"];

disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
