function OP = IsentropEksponent(cp, R)

% Det input der skal findes sættes til nan
% cp er den specifikke varmekapacitet
% R er gaskonstanten



disp("Formlen for den isentrope eksponent bruges:")
displayFormula("kappa = c_p/(c_p-R_i)")

OP = cp/(cp-R);


disp("Isentropeksponenten er fundet til " + OP)



end