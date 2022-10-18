
KommPot = xlsread('Data, pladser og personer.xlsx', ...
 '11 pladser-personer','B14:L24');
PersRel = xlsread('Data, pladser og personer.xlsx', ...
 '11 pladser-personer','B29:L39');


OptPlacmaxMV(KommPot,PersRel)

function [OptPl,OptMV] = OptPlacmaxMV(Tr,Dst)
    mut = perms(1:size(Tr, 1));
    arr = [];
    arr2 = [];
    for i = 1:size(mut, 1)
        mut(i,:);
        arr(end+1) = MaalFkt(mut(i,:),Tr,Dst);
    end
    OptMV = max(arr)
    k = find(arr==max(arr))
%     for i = 1:length(k)
%         k(i)
%         mut(k(i),:)
%         arr2(end+1) = mut(k(i),:);
%     end
    OptPl = mut(k,:)
    
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
