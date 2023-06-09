function UdV = UdskiltVandstrom(qml, x1, x2, unit)
disp("Formel 7.41 bruges til at finde den udskilte vandstrøm")
displayFormula("q_mv = q_mL * (x_1 - x_2)")
disp("---------------------------------------------------------")


UdV = qml * (x1 - x2);

disp("")
disp("Den udskilte vandstrøm er fundet til " + UdV + " " + unit)

disp("---------------------------------------------------------")
names = ["Udskilt vandstrøm";"Tør luft qm";inputname(2);inputname(3)];
vars = [UdV;qml;x1;x2];
units = ["kg/hr";"kg/hr";"kg/kg";"kg/kg"];


disp(table(names,vars,units,VariableNames=["Navn","Størrelse","Enhed"]))

disp("---------------------------------------------------------")
end