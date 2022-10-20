function MV = Maalfkt(pl, tr, dst)
k = length(pl);

x = zeros(1, k);
ctr = 1;

for i = 1:length(pl)-1
    for j = 2:length(pl)


        x(ctr) = dst(i, j) * tr(pl(i), pl(j));
        ctr = ctr+1;


    end



end

sum(x)
end