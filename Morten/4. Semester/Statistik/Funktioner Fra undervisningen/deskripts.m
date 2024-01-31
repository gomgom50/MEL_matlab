function deskriptorer = deskripts(data, datanavn)
% Dataen skal være ordnet i rækker


sz = size(data);

iter = sz(1);

for i = 1:iter
    mids(i) = mean(data(i, :));
    vars(i) = var(data(i, :));
    stds(i) = std(data(i, :));
    ns(i) = length(data(i,:));

end

disp(table(datanavn', mids', vars', stds', ns', 'VariableNames',["Datanavn","Middelværdi","Varians","Standardafvigelse", "Målepunkter"]))

end