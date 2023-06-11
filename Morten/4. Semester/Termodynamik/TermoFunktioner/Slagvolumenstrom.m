function OP = Slagvolumenstrom(eta_volumen, qv1, qvs)

% Det input der skal findes sættes til nan

syms eta_V q_v1 q_vs

inputs = [eta_volumen, qv1, qvs];
symbols = [eta_V q_v1 q_vs];


var = isnan(inputs);
ind = find(var==1);

disp("Formlen for slagvolumenstrømmen")
eq = eta_V == q_v1/q_vs

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Volumetrisk virkningsgrad";"Indsuget volumenstrøm";"Slagvolumenstrøm"];
units = ["-";"m3/s";"m3/s"];

disp(table(names,round(inputs,4)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
