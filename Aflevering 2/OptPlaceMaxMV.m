function [OptPl,OptMV] = OptPlacmaxMV(Tr,Dst)
% OptPlaceMaxMV - Angiver en matrice, der kan finde den optimale placering
% på baggrund af en given vektor samt målfunktionsværdi.
% Kald: MV = MaalFkt(Pl,Tr,Dst)
% Input:
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

