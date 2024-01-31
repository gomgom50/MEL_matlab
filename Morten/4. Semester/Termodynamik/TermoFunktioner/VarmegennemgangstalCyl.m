function OP = VarmegennemgangstalCyl(U, di, dy, alphai, alphay, lambda_konv, UdvendigEllerIndvendig)

% nan for den ukendte variabel


if UdvendigEllerIndvendig == "udvendig" 
    syms U_u d_i d_y alpha_i alpha_y lambda

    symbols = [U_u d_i d_y alpha_i alpha_y lambda];

    eq = U_u == 1/((1/alpha_y + d_y/(2*lambda) * (log(d_y/d_i)) + 1/alpha_i * d_y/d_i))

elseif UdvendigEllerIndvendig == "indvendig" 
    syms U_i d_i d_y alpha_i alpha_y lambda

    symbols = [U_i d_i d_y alpha_i alpha_y lambda];

    eq = U_i == 1/((1/alpha_i + d_i/(2*lambda) * (log(d_y/d_i)) + 1/alpha_y * d_i/d_y))
else
    disp("Noget er galt")
end





inputs = [U, di, dy, alphai, alphay, lambda_konv];



var = isnan(inputs);
ind = find(var==1);


disp("---------------------------------------------------")

disp("Der løses for: " + string(symbols(ind)))

sol = solve(eq, symbols(ind))

disp("---------------------------------------------------")

units = ["W/m2*K";"m";"m";"W/m2*K";"W/m2*K";"W/m*K"];

OP = vpa(abs(subs(sol,symbols,inputs)),4);

disp("Størrelsen på " + string(symbols(ind)) + " er fundet til " + double(OP) + " " + units(ind))

disp("---------------------------------------------------")

disp("Resultat og brugte værdier ses i nedenstående skema")
inputs(ind) = OP;


names = ["Varmegennemgangstal U";"Indre diameter";"Ydre diameter";"Indvendig varmeovergangstal";"Udvendig varmeovergangstal";"Varmekonduktivitet"];
units = ["W/m2*K";"m";"m";"W/m2*K";"W/m2*K";"W/m*K"];

disp(table(names,round(inputs,4)',units,VariableNames=["Variabel","Størrelse","Enhed"]))



end