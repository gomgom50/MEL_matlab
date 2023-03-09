function U_tot = Ophobningsloven(EQ, vars, varValues, varUssikerheder)
%Udregner ophobningsloven for en given equation
% Input:
% EQ = Equation som skal laves ophobning om
% vars = array med var navne (symvar(EQ))
% varValues = Values af variablerne i samme rækkefølge som vars
% varUssikerheder = ussikerhederne i samme rækkefølge som vars og
% varValues.
% Output:
% U_tot = den samlede ophobning (der er taget kvadarat af den) 
ds = jacobian(EQ);
ds_num = subs(ds, vars, varValues);
for j = 1:length(ds)
    final(j) = (ds_num(j) * varUssikerheder(j))^2;
end
U_tot = sqrt(sum(final)); 
end