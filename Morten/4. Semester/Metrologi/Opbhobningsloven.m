function U = Opbhobningsloven(func, symvars, vals, errors)
% Lortet skal være i rækkefølge



n = length(symvars);

var_list = vals;

for i = 1:n
    ds(i) = diff(func, symvars(i));
end

ds_vals = subs(ds, symvars, var_list);

for k = 1:n
    tot_u(k) = sqrt((ds_vals(k)*errors(k))^2);
end

U = sum(tot_u);

%vpa(unitConvert(sum(tot_u),u.W),3)

end