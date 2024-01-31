function OP = GennemGangsLigning_ror(phi, U_val, du, Lror, LogTM)

% Det input der skal findes sættes til nan

syms Phi U d_u L T_M

inputs = [phi, U_val, du, Lror, LogTM];
symbols = [Phi U d_u L T_M];


var = isnan(inputs);
ind = find(var==1);

if ind == 4
    disp("Da det er rørlængden der skal findes, isoleres L, som indgår i formlen for arealet:")
    displayFormula("A = pi*d_u*L")
else
end
disp("---------------------------------------------------")

disp("Gennemgangsligningen 9.73 opstilles:")
eq = Phi == U*pi*d_u*L*T_M

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")

OP = vpa(abs(subs(sol,symbols,inputs)),4);
units = ["W";"W/m2*K";"m";"m";"C"];

disp("Størrelsen på " + string(symbols(ind)) + " er fundet til " + double(OP) + " " + units(ind))

disp("---------------------------------------------------")


disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Phi ";"Varmegennemgangstal U";"Rørdiameter";"Rørlængde";"Logaritmisk middeltemperatur"];


disp(table(names,round(inputs,2)',units,VariableNames=["Variabel","Størrelse","Enhed"]))


end