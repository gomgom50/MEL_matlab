function U = Ophobningsloven(func, symvars, var_list, errors)
% Lortet skal være i rækkefølge



n = length(symvars);

ds = jacobian(func, symvars);


ds_vals = subs(ds, symvars, var_list);

for k = 1:n
    tot_u(k) = ds_vals(k)^2*errors(k)^2;
end

U = sqrt(sum(tot_u));

end