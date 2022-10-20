function MV = MaalFkt(Pl,Tr,Dst)
% MaalFkt - Bestemmer den totale ton afstand fra råvarelager til færdigvareLager
% Kald: MV = MaalFkt(Pl,Tr,Dst)
% Input:
% Pl = 
% Tr = 
% Dst = 
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
