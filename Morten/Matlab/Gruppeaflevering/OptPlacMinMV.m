function [OptPl, OptMV] = OptPlacMinMV(tr,dst)
pl = 1:length(dst);   % PL MED AFHÆNGIG LÆNGDE

pl_perms = perms(pl);

N = factorial(length(pl));

MV = zeros(1, N);
ctr = 1;

for k = 1:length(pl_perms)

    perm = pl_perms(k, :);

    MV(ctr) = Maalfkt(perm, tr, dst);

    ctr = ctr + 1;

end

[M, I] = min(MV);
OptPl = pl_perms(I, :);
OptMV = M;
end