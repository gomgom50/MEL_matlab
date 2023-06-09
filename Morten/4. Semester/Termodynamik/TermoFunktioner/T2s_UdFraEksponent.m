function OP = T2s_UdFraEksponent(T2s, T1, p1, p2, kap)

% Det input der skal findes sættes til nan

syms T_2s T_1 p_1 p_2 kappa

inputs = [T2s, T1, p1, p2, kap];
symbols = [T_2s T_1 p_1 p_2 kappa];


var = isnan(inputs);
ind = find(var==1);


disp("Energiligningen opstilles:")
eq = T_2s == T_1*(p_2/p_1)^((kappa - 1)/kappa)

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")

OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Isentropisk temp. T2s";"Temperatur 1";"Tryk 1";"Tryk 2";"Isentrop eksponent"];
units = ["K";"K";"Pa";"Pa";"-"];

disp(table(names,round(inputs,1)',units,VariableNames=["Variabel","Størrelse","Enhed"]))


end