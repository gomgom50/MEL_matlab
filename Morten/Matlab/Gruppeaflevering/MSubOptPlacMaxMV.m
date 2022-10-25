function [PL, MV] = MSubOptPlacMaxMV(tr, dst, M)


PL = [];
MV = [];

for i = 1:M

    P10 = randperm(length(tr));

    [SubMV, SubOptPl] = SubOptPlacMaxMV(P10, tr, dst);
    
    MV(end+1) = SubMV;
    PL(end+1, :) = SubOptPl;

end



PL = PL;
MV = MV;

end