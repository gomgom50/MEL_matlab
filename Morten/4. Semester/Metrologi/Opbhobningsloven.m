function U = Opbhobningsloven(func, symvars, var_list, errors)
% Lortet skal være i rækkefølge



n = length(symvars);

ds = jacobian(func);

ds_vals = subs(ds, symvars, var_list);

for k = 1:n
    tot_u(k) = sqrt((ds_vals(k)*errors(k))^2);
end

U = sum(tot_u);

end