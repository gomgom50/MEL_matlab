function skro = skrofortandet(type, last)
if type == "skråfortandet"
    N_hjul = input("Antal tandhjul: ");
    N1 = input("N1 = ");
    N2 = input("N2 = ");
    N3 = input("N3 = ");
    mn = input("Modul = ");
    mt = input("Tangentialmodul = ");
    F = input("Tandbredde = ");

    phi_n = input("Indgrebsvinkel i grader = ");
    psi = input("Skråvinkel i grader = ");
    phi_t = input("Tangentialindgrebsvinkel i grader = ");
    
    C = input("Centerakseafstand = ");
    d1 = input("Delecirkeldiameter 1 = ");
    d2 = input("Delecirkeldiameter 2 = ");
    d3 = input("Delecirkeldiameter 3 = ");

    db1 = input("Grundcirkeldiameter 1 = ");
    db2 = input("Grundcirkeldiameter 2 = ");
    
    da1 = input("Tandtopdiameter 1 = ");
    da2 = input("tandtopdiameter 2 = ");
    

    Ns = [N1 N2 N3];
    ds = [d1 d2 d3];
end

i = 0;
while i < 3
    i = i+1;
    
    % Tangentialmodul
    if isempty(mt) && ~isempty(mn) && ~isempty(psi)
        disp("Tangentialmodul")
        mt = mn/cosd(psi)

    elseif isempty(mn) && ~isempty(mt) && ~isempty(psi)
        disp("Modul")
        mn = mt * cosd(psi)
    
    elseif isempty(psi) && ~isempty(mt) && ~isempty(mn)
        disp("Skråvinkel")
        psi = acos(mn/mt)
    end

    % Tangentialindgrebsvinkel
    if isempty(phi_t) && ~isempty(phi_n) && ~isempty(psi)
        disp("Tangentialindgrebsvinkel")
        phi_t = atand(tand(phi_n)/cosd(psi))

    elseif isempty(phi_n) && ~isempty(phi_t) && ~isempty(psi)
        disp("Indgrebsvinkel")
        eq = phi_t == atand(tand(phi_n)/cosd(psi));
        phi_n = solve(eq, phi_n)

    elseif isempty(psi) && ~isempty(phi_t) && ~isempty(phi_n)
        disp("Skråvinkel")
        eq = phi_t == atand(tand(phi_n)/cosd(psi));
        psi = solve(eq, psi)
    end
    
    %%% HERTIL %%%

    % Udregninger af delecirkeldiameter
    if isempty(d1) && ~isempty(N1) && ~isempty(mt)
        disp("Delecirkeldiameter 1")
        d1 = N1 * mt

    elseif isempty(d2) && ~isempty(N2) && ~isempty(mt)
        disp("Delecirkeldiameter 2")
        d2 = N2 * mt

    elseif isempty(d3) && ~isempty(N3) && ~isempty(mt)
        disp("Delecirkeldiameter 3")
        d3 = N3 * mt

    end

    if isempty(N1) && ~isempty(d1) && ~isempty(mt)
        disp("N1 Tandantal")
        N1 = d1/mt

    elseif isempty(N2) && ~isempty(d2) && ~isempty(mt)
        disp("N2 Tandantal")
        N2 = d2/mt

    elseif isempty(N3) && ~isempty(d3) && ~isempty(mt)
        disp("N3 Tandantal")
        N3 = d3/mt

    end

    % Centerakseafstand
    if isempty(C)
        disp("Centerakseafstand")
        C = (d1 + d2)/2

    elseif ~isempty(C) && ~isempty(d1) && isempty(d2)
        disp("Delecirkeldiameter 2")
        syms d2
        eq = C == (d1 + d2)/2;
        d1 = solve(eq, d2)

    elseif ~isempty(C) && ~isempty(d2) && isempty(d1)
        disp("Delecirkeldiameter 1")
        syms d1
        eq = C == (d1 + d2)/2;
        d1 = solve(eq, d1)


    end

    % Grundcirkeldiameter

    if isempty(db1) && ~isempty(d1) && ~isempty(phi_t)
        disp("Grundcirkeldiameter 1")
        db1 = d1 * cosd(phi_t)

    elseif isempty(db2) && ~isempty(d2) && ~isempty(phi_t)
        disp("Grundcirkeldiameter 2")
        db2 = d2 * cosd(phi_t)

    elseif isempty(phi_t) && ~isempty(db1) && ~isempty(d1)
        disp("Tangentialindgrebsvinkel")
        phi_t = acosd(db1/d1)

    elseif isempty(phi_t) && ~isempty(db2) && ~isempty(d2)
        disp("Tangentialindgrebsvinkel")
        phi_t = acosd(db2/d2)

    elseif isempty(d1) && ~isempty(db1) && ~isempty(phi_t)
        disp("Delecirkeldiameter 1")
        d1 = db1/cosd(phi_t)

    elseif isempty(d2) && ~isempty(db2) && ~isempty(phi_t)
        disp("Delecirkeldiameter 2")
        d2 = db2/cosd(phi_t)

    end
    
    % Tandtopdiameter

    if isempty(da1) && ~isempty(d1) && ~isempty(mn)
        disp("Tandtopdiameter 1")
        da1 = d1 + 2*mn

    elseif isempty(da2) && ~isempty(d2) && ~isempty(mn)
        disp("Tandtopdiameter 2")
        da2 = d2 + 2*mn

    elseif isempty(d1) && ~isempty(da1) && ~isempty(mn)
        disp("Delecirkeldiameter 1")
        d1 = da1 - 2*mn

    elseif isempty(d2) && ~isempty(da2) && ~isempty(mn)
        disp("Delecirkeldiameter 2")
        d2 = da2 - 2*mn
    
    elseif isempty(mn) && ~isempty(da1) && ~isempty(d1)
        disp("Modul")
        mn = (da1 - d1)/2

    elseif isempty(mn) && ~isempty(da2) && ~isempty(d2)
        disp("Modul")
        mn = (da2 - d2)/2
    end
    
    % Indgrebsgrad

    if ~isempty(da1) && ~isempty(da2) && ~isempty(db1) && ~isempty(db2)  && ~isempty(d1) && ~isempty(d2)  && ~isempty(mt)  && ~isempty(phi_t) && ~isempty(psi) && ~isempty(mn) && ~isempty(F)
        disp("mT = Totalindgrebsgrad")
        mC = (0.5*(sqrt(da1^2 - db1^2) + sqrt(da2^2 - db2^2))-((d1+d2)/2)*sind(phi_t))/(pi*mt*cosd(phi_t))
        
        mF = F*sind(psi)/(pi * mn)
        
        mT = mC + mF

    end

    
end
end