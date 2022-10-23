function MV = MaalFkt(Pl,Tr,Dst)
% MaalFkt - Bestemmer den totale score af af funktionen ved at
% gange de to vekterorer sammen en indgang af gangen 
% for alle rækker i og kolonner j.
% Kald: MV = MaalFkt(Pl,Tr,Dst)
% Input:
% Pl = Placeringen af lokationer
% Tr = 
% Dst = Distance mellem 
% Output:
% MV = antal i Ton Km
    sum = 0;
    for i = 1:length(Pl) 
        for j = i:length(Tr)
            sum = Dst(i,j) .* Tr(Pl(i), Pl(j)) + sum;
        end
    end
    MV = sum;
end
