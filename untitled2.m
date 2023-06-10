KommPot = xlsread('Data, pladser og personer.xlsx', ...
 '11 pladser-personer','B14:L24');
PersRel = xlsread('Data, pladser og personer.xlsx', ...
 '11 pladser-personer','B29:L39');


Pl =  [5 1 4 10 7 11 2 9 8 6 3];

SubOptPlacMaxMV(PersRel, KommPot, Pl);

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


function MV = MaalFkt(Pl,Tr,Dst)
    sum = 0;
    for i = 1:length(Pl)
        for j = i:length(Tr)
            sum = Dst(i,j) .* Tr(Pl(i), Pl(j)) + sum;
    end
end
    MV = sum;
end
