function dryairflow = DryAirMassflow(qm_luft, x_fugt, unit)
%CP = py.importlib.import_module("CoolProp.CoolProp");

% hvor qmluft er den totale massestrøm af luft
% x er fugtighedsratioen 8 kg/kg. Enten fra CP eller plot
% unit er den enhed massestrømmen af luft er givet i (string eks kg/s whatever)

disp("Formel 7.29 bruges til at finde massestrømmen af tør luft")
displayFormula("qm_dry = qm_air * (1/(1+x))")
disp("---------------------------------------------------------")


dryairflow = qm_luft * 1/(1+x_fugt);

disp("")
disp("Massestrømmen af tør luft er fundet til " + dryairflow + " " + unit)

%CP.HAPropsSI("W","R",0.6,"T",273.15+30,"P",101325)

end