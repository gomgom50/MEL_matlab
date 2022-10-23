function [OptPl,OptMV] = OptPlacmaxMV(Tr,Dst)
% MaalFkt - Bestemmer den totale score af af funktionen ved at
% gange de to vekterorer sammen en indgang af gangen 
% for alle rækker i og kolonner j
% Kald: MV = MaalFkt(Pl,Tr,Dst)
% Input:
% Pl = Placeringen af lokationer
% Tr = 
% Dst = 
% Output:
% MV = antal i Ton Km
    mut = perms(1:size(Tr, 1));
    arr = [];
    arr2 = [];
    for i = 1:size(mut, 1)
%         mut(i,:);
        arr(end+1) = MaalFkt(mut(i,:),Tr,Dst);
    end
    OptMV = max(arr)
    k = find(arr==max(arr));
    OptPl = mut(k,:)
end

