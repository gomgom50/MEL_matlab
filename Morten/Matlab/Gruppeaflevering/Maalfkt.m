function MV = Maalfkt(pl, tr, dst)
k = length(pl);

x = 0;

for i = 1:length(pl)-1
    for j = i+1:length(pl)


        x = x + dst(i, j) * tr(pl(i), pl(j));


    end
end

MV = x;
end