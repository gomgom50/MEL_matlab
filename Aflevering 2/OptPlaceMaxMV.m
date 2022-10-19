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
    OptPl = mut(k,:)
end

