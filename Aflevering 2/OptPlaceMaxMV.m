function [OptPl,OptMV] = OptPlacmaxMV(Tr,Dst)
% OptPlaceMaxMV - Returnerer den optimale rute samt tilsvarende numerisk 
% værdi anskrevet denne rute på baggrund af input dataene.
% Kald: Opt = OptPlaceMinMV(Tr,Dst);
% Input:
% Tr = Numeriske værdier tilskrevet placering
% Dst = Afstanden mellem placeringer
% Output:
% Opt = 
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

