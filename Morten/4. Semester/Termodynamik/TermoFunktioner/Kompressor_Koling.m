function OP = Kompressor_Koling(phik, qmr, h1, h2, Pa)

% Det input der skal findes sættes til nan

syms Phi_kt q_mR h_1 h_2 P_a

inputs = [phik, qmr, h1, h2, Pa];
symbols = [Phi_kt q_mR h_1 h_2 P_a];


var = isnan(inputs);
ind = find(var==1);

disp("Energiligningen opstilles:")
eq = q_mR*(h_1 - h_2) - Phi_kt + P_a == 0

disp("---------------------------------------------------")
disp("Hvor Pa er:")
displayFormula("P_a = eta_motor * P_el")
disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;

    

names = [inputname(1);"Massestrøm";inputname(3);inputname(4);inputname(5)];
units = ["W";"kg/s";"J/kg*K";"J/kg*K";"W"];

disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
