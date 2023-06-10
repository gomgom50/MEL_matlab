function OP = Kompressor_Koling_isentrop(qmr, h1, h2s, Pa, eta_isentrop)

% Det input der skal findes sættes til nan

syms q_mR h_1 h_2s eta_is P_a

Pis = qmr*(h2s-h1);

inputs = [qmr, h1, h2s, Pa, eta_isentrop];
symbols = [q_mR h_1 h_2s P_a, eta_is];


var = isnan(inputs);
ind = find(var==1);

disp("Energiligningen opstilles:")
eq = q_mR*(h_2s - h_1)/P_a == eta_is

disp("---------------------------------------------------")
disp("Hvor P_is er:")
displayFormula("P_is = q_mR*(h_2s - h_1)")
disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(subs(sol,symbols,inputs),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;

inputs = [Pis, inputs];

names = ["Phi isentrop";"Massestrøm";inputname(2);inputname(3);inputname(4);"Isentrop virkningsgrad"];
units = ["W";"kg/s";"J/kg*K";"J/kg*K";"W";"-"];

disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end