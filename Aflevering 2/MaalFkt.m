function MV = MaalFkt(Pl,Tr,Dst)
    sum = 0;
    for i = 1:length(Pl)
        for j = i:length(Tr)
            sum = Dst(i,j) .* Tr(Pl(i), Pl(j)) + sum;
        end
    end
    MV = sum;
end
