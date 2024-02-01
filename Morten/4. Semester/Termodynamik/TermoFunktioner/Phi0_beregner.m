function phi0 = Phi0_beregner(qv, dens, cp, tf)




phi0 = qv*dens*cp*tf;

disp("Formlen for phi0 bruges")
displayFormula("Phi_0 = q_v * rho * c_p * t_f")
disp("---------------------------------------------------------")
if phi0 > 1000
    disp("Resultatet er fundet til " + phi0/1000 + " kW")
    inputs = [phi0/1000,qv, dens, cp, tf];
    units = ["kW";"m3/s";"kg/m3";"J/kg*K";"K"];
else
    disp("Resultatet er fundet til " + phi0 + " W")
    inputs = [phi0,qv, dens, cp, tf];
    units = ["W";"m3/s";"kg/m3";"J/kg*K";"K"];
end
disp("---------------------------------------------------------")

% Tabel

names = ["Phi 0";"Volumenstrøm";"Densitet";"Spec. varmekapacitet";"Temp. forskel"];


disp(table(names,inputs',units,VariableNames=["Variabel","Størrelse","Enhed"]))




end