function [SubMV, SubOptPl] = SubOptPlacMaxMV(P10, tr, dst)
max = Maalfkt(P10, tr, dst);

matrix = P10;


for i = 1:length(P10)
    for j = 1:length(P10)
    

        matnew = matrix;

        pos1 = matrix(i);
        pos2 = matrix(j);

        matnew(i) = pos2;
        matnew(j) = pos1;

        MV = Maalfkt(matnew, tr, dst)

        if MV > max
            max = MV
            matrix = matnew
        end

    end
end

SubMV = max;
SubOptPl = matrix;
end