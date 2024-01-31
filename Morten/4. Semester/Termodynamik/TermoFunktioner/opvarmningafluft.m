function luft_opvarm_nedkol = opvarmningafluft(qml, h1, h2, type, hr_or_s)

if hr_or_s == "hr"
    faktor = 3600;
    fakunit = "kg/hr";
else
    faktor = 1;
    fakunit = "kg/s";
end


if type == "opvarm"
    disp("Ved opvarmning benyttes energibalancen fra formel 7.39")
    displayFormula("Phi_12 = q_mL * (h_2 - h_1)")
    disp("---------------------------------------------------------")

    luft_opvarm_nedkol = qml * (h2 - h1)/faktor;




elseif type == "nedkol"


    disp("Ved opvarmning benyttes energibalancen fra formel 7.39 ")
    displayFormula("Phi_12 = q_mL * (h_1 - h_2)")
    disp("---------------------------------------------------------")

    luft_opvarm_nedkol = qml * (h1 - h2)/faktor;

end

if luft_opvarm_nedkol > 1000
    disp("Varmestrømmen er fundet til " + luft_opvarm_nedkol/1000 + " kW")
else
    disp("Varmestrømmen er fundet til " + luft_opvarm_nedkol + " W")
end

disp("---------------------------------------------------------")


vars = [luft_opvarm_nedkol;h1;h2;qml];
names = ["Varmestrøm";inputname(2);inputname(3);"Tør luft qm"];
units = ["W";"J/kg";"J/kg";fakunit];

disp(table(names,vars,units, VariableNames=["Navn","Størrelse","Enhed"]))

disp("---------------------------------------------------------")


end