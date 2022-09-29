function skro = Skrofortandet(type)
if type == "Skråfortandet"
    N_hjul = input("Antal tandhjul: ");
    N1 = input("N1 = ");
    N2 = input("N2 = ");
    N3 = input("N3 = ");
    mn = input("Modul = ");
    mt = input("Tangentialmodul = ");
    C = input("Centerakseafstand = ");
    d1 = input("Delecirkeldiameter 1 = ");
    d2 = input("Delecirkeldiameter 2 = ");
    d3 = input("Delecirkeldiameter 3 = ");

    db1 = input("Grundcirkeldiameter 1 = ");
    db2 = input("Grundcirkeldiameter 2 = ");

    phi_n = input("Indgrebsvinkel i grader = ");
    psi = input("Skråvinkel i grader = ");
    
    phi_t = input("Tangentialindgrebsvinkel i grader = ");
    

    F = input("Tandbredde = ");

    Ns = [N1 N2 N3];
    ds = [d1 d2 d3];
end

i = 0;
while i < 3
    i = i+1;
    
    % Tangentialmodul
    if isempty(mt) && ~isempty(mn) && ~isempty(psi)
        mt = mn/cosd(psi)

    elseif isempty(mn) && ~isempty(mt) && ~isempty(psi)
        mn = mt * cosd(psi)
    
    elseif isempty(psi) && ~isempty(mt) && ~isempty(mn)
        psi = acos(mn/mt)
    end

    % Tangentialindgrebsvinkel
    if isempty(phi_t) && ~isempty(phi_n) && ~isempty(psi)
        phi_t = atand(tand(phi_n)/cosd(psi))

    elseif isempty(phi_n) && ~isempty(phi_t) && ~isempty(psi)
        eq = phi_t == atand(tand(phi_n)/cosd(psi));
        phi_n = solve(eq, phi_n)

    elseif isempty(psi) && ~isempty(phi_t) && ~isempty(phi_n)
        eq = phi_t == atand(tand(phi_n)/cosd(psi));
        psi = solve(eq, psi)
    end
    
    %%% HERTIL %%%

    % Udregninger af delecirkeldiameter
    if isempty(d1) && ~isempty(N1) && ~isempty(mn)
        d1 = N1 * mn

    elseif isempty(d2) && ~isempty(N2) && ~isempty(mn)
        d2 = N2 * mn

    elseif isempty(d3) && ~isempty(N3) && ~isempty(mn)
        d3 = N3 * mn

    end

    if isempty(N1) && ~isempty(d1) && ~isempty(mn)
        N1 = d1/mn

    elseif isempty(N2) && ~isempty(d2) && ~isempty(mn)
        N2 = d2/mn

    elseif isempty(N3) && ~isempty(d3) && ~isempty(mn)
        N3 = d3/mn

    elseif isempty(mn)
        mn = ds./Ns
    end

    % Centerakseafstand
    if isempty(C)
        C = (d1 + d2)/2

    elseif ~isempty(C) && ~isempty(d1) && isempty(d2)
        syms d2
        eq = C == (d1 + d2)/2;
        d1 = solve(eq, d2)

    elseif ~isempty(C) && ~isempty(d2) && isempty(d1)
        syms d1
        eq = C == (d1 + d2)/2;
        d1 = solve(eq, d1)


    end

    % Grundcirkeldiameter

    if isempty(db1) && ~isempty(d1) && ~isempty(phi_n)
        db1 = d1 * cosd(phi_n)

    elseif isempty(db2) && ~isempty(d2) && ~isempty(phi_n)
        db2 = d2 * cosd(phi_n)

    elseif isempty(phi_n) && ~isempty(db1) && ~isempty(d1)
        phi_n = acosd(db1/d1)

    elseif isempty(phi_n) && ~isempty(db2) && ~isempty(d2)
        phi_n = acosd(db2/d2)

    elseif isempty(d1) && ~isempty(db1) && ~isempty(phi_n)
        d1 = db1/cosd(phi_n)

    elseif isempty(d2) && ~isempty(db2) && ~isempty(phi_n)
        d2 = db2/cosd(phi_n)

    end
    

    
    
end
end