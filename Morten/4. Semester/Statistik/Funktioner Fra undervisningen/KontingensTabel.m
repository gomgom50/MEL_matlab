function KT = KontingensTabel(InputData)
% Inputdata skal være i formatet [Data1;Data2;Data3...]
% Altså det skal være ordnet i rækker, Data1(1, :) Data2(1, :)...


rowsum = sum(InputData,2);
colsum = sum(InputData,1);

total = sum(colsum);

rows = size(rowsum,1);
cols = size(colsum,2);

rowfreq = rowsum/total;
colfreq = colsum/total;

E = zeros(rows, cols);

% Her i loopet udregnes kontingenstabellens værdier
for i = 1:rows
    for j = 1:cols
        E(i,j) = total*rowfreq(i)*colfreq(j);
    end
end


% bare datanavne
names = ["Intakt forventet","Defekt forventet"];
for k = 1:rows
    datanames(k,1) = names(k);

end


disp(table(datanames, E, 'VariableNames',["Data navn", "Maskine A | Maskine B | Maskine C"]))




KT = E;


end
