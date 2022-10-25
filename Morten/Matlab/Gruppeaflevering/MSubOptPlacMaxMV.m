function [MSubPL, MSubMV] = MSubOptPlacMaxMV(tr, dst, M)

PLs = [];
MVs = [];

for i = 1:M

    P10 = randperm(length(tr));

    [SubOptMV, SubOptPl] = SubOptPlacMaxMV(P10, tr, dst);
    
    PLs(end+1, :) = SubOptPl;
    MVs(end+1) = SubOptMV;
    
    

end

[M, I] = max(MVs);

index = I
MSubMV = M;
MSubPL = PLs(I, :);


end