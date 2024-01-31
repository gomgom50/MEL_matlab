function op = TrykSkema(hs, cs, tabs, trykhs,dens)

% Alt skal være i arrays, fra start til slut i systemet
% hs er højder
% cs er hastigheder
% tabs er energitab (i meter)
% trykhs er trykhøjder. Der kendes den første og sidste oftest, det klarer
% scriptet


% forhåbentlig sker resten smertefrit herinde

disp("Energiregnskabet for trykforholdene, der fremgår nedenunder, er regnet ud" + ...
    "fra energiniveauet og trykkene i systemet. Følgende formler er brugt:")


disp("---------------------------------------------------")
disp("Fluidhastigheder (hvor i enten er sug eller tryk for pumpen):")
displayFormula("c_i = q_v/(pi/4*d_i^2)")


disp("---------------------------------------------------")
disp("Hastighedshøjder (hvor i enten er sug eller tryk for pumpen):")
displayFormula("Hh_i = c_i^2/(2*g)")

disp("---------------------------------------------------")
disp("Trykhøjder:")
displayFormula("pH_i = p/(rho*g)")

disp("---------------------------------------------------")
disp("Energiniveauer (hvor i er pkt 1,2... n i systemet):")
displayFormula("H_i = p_i/(rho*g) + c_i^2/(2*g) + z_i")

disp("---------------------------------------------------")
disp("Energiniveauer for tab i systemet:")
displayFormula("H_(i+1) = H_i - H_tab")

disp("---------------------------------------------------")
disp("Trykhøjder for pumpen:")
displayFormula("p_i/(rho*g) = H_i - c_i^2/(2*g)-z_i")
displayFormula("p_i = (H_i - c_i^2/(2*g)-z_i)*(rho*g)")

disp("---------------------------------------------------")

grav = 9.82;

eneq = @(p, c, zf) p + c^2/(2*grav) + zf;

tab_nan = isnan(tabs);


EN(1) = eneq(trykhs(1), cs(1), hs(1));
if tab_nan(1) == 0
    EN(2) = EN(1) - tabs(1);
else
    EN(2) = eneq(trykhs(2), cs(2), hs(2));
end

if tab_nan(1) == 0
    EN(3) = EN(2) - tabs(2);
else
    EN(3) = eneq(trykhs(2), cs(3), hs(3));
end

EN(4) = eneq(trykhs(2), cs(4), hs(4));




% Tryk og trykhøjder
Pps(1) = trykhs(1)*dens*grav/1e5;
Pps(2) = (EN(2) - cs(2)^2/(2*grav) - hs(2))*dens*grav/1e5;
Pps(3) = (EN(3) - cs(3)^2/(2*grav) - hs(3))*dens*grav/1e5;
Pps(4) = trykhs(2)*dens*grav/1e5;

Pps_meter = [trykhs(1), Pps(2)/(dens*grav)*1e5, Pps(3)/(dens*grav)*1e5, trykhs(2)];


% Hastighedshøjder
Hhs(1) = 0;
Hhs(2) = cs(2)^2/(2*grav);
Hhs(3) = cs(3)^2/(2*grav);
Hhs(4) = EN(4) - hs(4);

% Energitab
Etab(1) = 0;
Etab(2) = EN(2)-EN(1);
Etab(3) = EN(3)-EN(2);
Etab(4) = EN(4)-EN(3);


op = [Pps_meter;Hhs;hs;EN;Etab;cs;Pps];

names = ["Trykhøjde","Hastighedshøjde","Højde, z","Energiniveau","Energitab","Hastighed","Tryk"];
units = ["m","m","m","m","m","m/s","bar"];
varnames = ["Deskriptor","Punkt 1","Punkt 2","Punkt 3","Punkt 4","Enhed"];

disp(table(names', vpa(op(:,1),3), vpa(op(:,2),3),vpa(op(:,3),3),vpa(op(:,4),3), units', VariableNames=varnames))






end