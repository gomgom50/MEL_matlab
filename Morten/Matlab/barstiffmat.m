function K = barstiffmat(L, A, E)
    k = E.*A./L;

    [K] = [k, -k; -k, k];

end
