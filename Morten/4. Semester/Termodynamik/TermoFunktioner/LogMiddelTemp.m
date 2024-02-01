function OP = LogMiddelTemp(TM, t1max, t2max, t1min, t2min)

% nan for den ukendte variabel

syms T_M t_1max t_2max t_1min t_2min

inputs = [TM, t1max, t2max, t1min, t2min];
symbols = [T_M t_1max t_2max t_1min t_2min];


var = isnan(inputs);
ind = find(var==1);


disp("Formel for den logaritmiske middeltemperatur opstilles:")
eq = T_M == ((t_1max - t_2max) - (t_1min - t_2min))/(log(((t_1max - t_2max))/(t_1min - t_2min)))

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")


OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Logaritmisk middeltemp. ";"Temp 1 max";"Temp 2 max";"Temp 1 min";"Temp 2 min"];
units = ["C";"C";"C";"C";"C"];

disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))



end