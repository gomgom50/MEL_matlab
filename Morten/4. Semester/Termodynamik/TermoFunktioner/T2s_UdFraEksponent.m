function OP = T2s_UdFraEksponent(T2s, T1, p1, p2, kap)

% Det input der skal findes sættes til nan

syms T_is T_im1 p_im1 p_i kappa

inputs = [T2s, T1, p1, p2, kap];
symbols = [T_is T_im1 p_im1 p_i kappa];


var = isnan(inputs);
ind = find(var==1);


disp("Energiligningen opstilles:")
eq = T_is == T_im1*(p_i/p_im1)^((kappa - 1)/kappa)

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")

OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Isentropisk temp. " + inputname(1);inputname(2);inputname(3);inputname(4);"Isentrop eksponent"];
units = ["K";"K";"Pa";"Pa";"-"];

disp(table(names,round(inputs,1)',units,VariableNames=["Variabel","Størrelse","Enhed"]))


end