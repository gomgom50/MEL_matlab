function [OptPl,OptMV] = OptPlacmaxMV(Tr,Dst)
% OptPlaceMaxMV - Returnerer den optimale rute samt tilsvarende numerisk 
% værdi anskrevet denne rute på baggrund af input dataene.
% Kald: Opt = OptPlaceMinMV(Tr,Dst);
% Input:
% Tr = Numeriske værdier tilskrevet placering
% Dst = Afstanden mellem placeringer
% Output:
% Opt = Ruten der returnerer den største numeriske værdi.

    % Mut returnerer en ændring af routen baseret på størrelsen af matrice
    % inputtet fra Tr.
    mut = perms(1:size(Tr, 1));

    % Et tomt array oprettes som kan lagere værdier fra for-loop.
    arr = [];

    % Der tilføjes en tom plads, hvori dataen danner row & colum fra den 
    % tidligere oprettede Maalfunktion. end+1 gives som indeks til arrayet
    % da det ikke ønskes muligt at overskrive tidligere indeks.
    for i = 1:size(mut, 1)
        arr(end+1) = MaalFkt(mut(i,:),Tr,Dst);
    end

    % OptMV returnerer den største numeriske værdi fundet i arr.
    OptMV = max(arr)

    % k & OptPl finder den tilhørende rute til den største numeriske værdi.
    k = find(arr==max(arr));
    OptPl = mut(k,:)
end

