function OP = massestrom_all(phi0, qmr, h1, h4)

% Det input der skal findes sættes til nan/NaN

syms Phi q_mR h_1 h_4

inputs = [phi0, qmr, h1, h4];
symbols = [Phi q_mR h_1 h_4];


var = isnan(inputs);
ind = find(var==1);

% Formlen der skal løses
eq = q_mR*(h_1 - h_4) + Phi == 0

% Displayer bare den variabel der løses for
disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))


OP = vpa(abs(subs(sol,symbols,inputs)),4);

% der herunder er bare til opstilling af resultat i tabel

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Phi ";"Massestrøm";inputname(3);inputname(4)];
units = ["W";"kg/s";"J/kg";"J/kg"];

disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))

end
