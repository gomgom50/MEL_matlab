function [OptPl,OptMV] = OptPlacMinMV(Tr,Dst)
    mut = perms(1:size(Tr, 1))
    arr = []
    for i = 1:size(mut, 1)
        disp(i)
        mut(i,:)
        arr(end+1) = MaalFkt(mut(i,:),Tr,Dst)
    end
    OptMV = min(arr)
    k = find(arr==min(arr))
    OptPl = mut(k,:)
end
