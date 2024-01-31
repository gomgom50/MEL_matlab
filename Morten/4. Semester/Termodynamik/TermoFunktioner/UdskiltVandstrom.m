function UdV = UdskiltVandstrom(UdskildtVand, qml, x1, x2)




syms q_ml x_1 x_2 Udskildt_Vand

inputs = [UdskildtVand, qml, x1, x2];
symbols = [Udskildt_Vand q_ml x_1 x_2];


var = isnan(inputs);
ind = find(var==1);

disp("Formel 7.41 bruges til at finde den udskilte vandstrøm")
eq = Udskildt_Vand == q_ml * (x_1 - x_2);

disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")




UdV = vpa(abs(subs(sol,symbols,inputs)),4);



disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = UdV;


names = ["Udskildt vandstrøm";"Tør luft massestrøm";inputname(3);inputname(4)];
units = ["kg/hr";"kg/hr";"kg/kg";"kg/kg"];

disp(table(names,round(inputs,4)',units,VariableNames=["Variabel","Størrelse","Enhed"]))







% 
% 
% 
% disp("Formel 7.41 bruges til at finde den udskilte vandstrøm")
% displayFormula("q_mv = q_mL * (x_1 - x_2)")
% disp("---------------------------------------------------------")
% 
% 
% UdV = qml * (x1 - x2);
% 
% disp("")
% disp("Den udskilte vandstrøm er fundet til " + UdV + " " + unit)
% 
% disp("---------------------------------------------------------")
% names = ["Udskilt vandstrøm";"Tør luft qm";inputname(2);inputname(3)];
% vars = [UdV;qml;x1;x2];
% units = ["kg/hr";"kg/hr";"kg/kg";"kg/kg"];
% 
% 
% disp(table(names,vars,units,VariableNames=["Navn","Størrelse","Enhed"]))
% 
% disp("---------------------------------------------------------")
end