function [SubOptPl,SubOptMV] = SubOptPlacMaxMV(Tr,Dst,Pl0)
    max = MaalFkt(Pl0, Tr, Dst);
    oldMax = MaalFkt(Pl0, Tr, Dst);
    bedsteMatrix = Pl0;
    while 1
        for j = 1:length(Tr)
            for i = 1:length(Tr)
                mutMatrix = bedsteMatrix;
                pos1 = bedsteMatrix(j);
                pos2 = bedsteMatrix(i);
                mutMatrix(i) = pos1;
                mutMatrix(j) = pos2;
                if MaalFkt(mutMatrix, Tr, Dst) > max
                    max = MaalFkt(mutMatrix, Tr, Dst);
                    bedsteMatrix = mutMatrix;
                end
            end
        end
        if oldMax < max
            SubOptMV = max
            SubOptPl = bedsteMatrix
            break
        end
    end
end