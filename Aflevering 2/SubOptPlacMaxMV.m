function [SubOptPl,SubOptMV] = SubOptPlacMaxMV(Tr,Dst,Pl0)
% SubOptPlacMaxMV - Returnerer den rute der afgiver den højeste numeriske
% værdi baseret på Maalfunktionen (MaalFkt) ved suboptimal placering.
% Kald: SubOptPlacMaxMV(Tr,Dst,Pl0)
% Input:
% Pl = Placeringen af lokationer.
% Tr = Numeriske værdier tilskrevet placering.
% Dst = Afstanden mellem placeringer.
% Output:
% SubOptPlacMaxMV(Tr,Dst,Pl0) - Numerisk værdi & array "rute".
    
    % Stedholdere for den tidligere bedste numeriske værdi og den mulige 
    % opkommende bedste numeriske værdi.
    max = MaalFkt(Pl0, Tr, Dst);
    oldMax = MaalFkt(Pl0, Tr, Dst);

    % Variable & Stedholder for bedste rute.
    bedsteMatrix = Pl0;

    % 
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