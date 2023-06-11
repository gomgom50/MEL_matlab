function OP = Isentrop_Virkningsgrad(eta_isentrop, Th1, Th2, Th2s, TempEllerEntalpi, KompEllerTurbine)

% TempEllerEnthalpi skal være en string af enten "entalpi" eller "temp" ale
% efter hvad input er



if TempEllerEntalpi == "temp"
    syms eta_S T_1 T_2 T_2s
    symbols = [eta_S T_1 T_2 T_2s];

    disp("Følgende formel er brugt")
    disp("---------------------------------------------------")
    if KompEllerTurbine == "komp"
        displayFormula("(T_2s - T_1)/(T_2 - T_1) = eta_S")
        eq = (T_2s - T_1)/(T_2 - T_1) == eta_S;
    elseif KompEllerTurbine == "turbine"
        displayFormula("(T_2 - T_1)/(T_2s - T_1) = eta_S")
        eq = (T_2 - T_1)/(T_2s - T_1) == eta_S;
    end
    disp("---------------------------------------------------")

    names = ["Isentrop virkningsgrad";inputname(2);inputname(3);inputname(4)];
    units = ["-";"K";"K";"K"];

elseif TempEllerEntalpi == "entalpi"
    syms eta_S h_1 h_2 h_2s
    symbols = [eta_S h_1 h_2 h_2s];

    disp("Følgende formel er brugt")
    disp("---------------------------------------------------")
    if KompEllerTurbine == "komp"
        displayFormula("eta_S = (h_2s - h_1)/(h_2 - h_1)")
        eq = eta_S == (h_2s - h_1)/(h_2 - h_1);
    elseif KompEllerTurbine == "turbine"
        displayFormula("eta_S = (h_2 - h_1)/(h_2s - h_1)")
        eq = eta_S == (h_2 - h_1)/(h_2s - h_1);
    end
    disp("---------------------------------------------------")

    names = ["Isentrop virkningsgrad";inputname(2);inputname(3);inputname(4)];
    units = ["-";"J/kg";"J/kg";"J/kg"];
else
    disp("Tjek inputs og grammatik")
end
inputs = [eta_isentrop, Th1, Th2, Th2s];


var = isnan(inputs);
ind = find(var==1);



disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")


var = isnan(inputs);
ind = find(var==1);

% Output
OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))


end