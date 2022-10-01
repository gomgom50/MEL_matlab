function skro = skrofortandet(type, last)
if type == "skråfortandet"
    N_hjul = input("Antal tandhjul: ");
    N1 = input("N1 = ");
    N2 = input("N2 = ");
    N3 = input("N3 = ");
    N4 = input("N4 = ");

    mn1 = input("Modul 1 = ");
    mn2 = input("Modul 2 = ");

    mt1 = input("Tangentialmodul 1 = ");
    mt2 = input("Tangentialmodul 2 = ");

    F = input("Tandbredde = ");

    phi_n = input("Indgrebsvinkel i grader = ");
    psi = input("Skråvinkel i grader = ");
    phi_t = input("Tangentialindgrebsvinkel i grader = ");
    
    C = input("Centerakseafstand = ");
    d1 = input("Delecirkeldiameter 1 = ");
    d2 = input("Delecirkeldiameter 2 = ");
    d3 = input("Delecirkeldiameter 3 = ");
    d4 = input("Delecirkeldiameter 4 = ");

    db1 = input("Grundcirkeldiameter 1 = ");
    db2 = input("Grundcirkeldiameter 2 = ");
    db3 = input("Grundcirkeldiameter 3 = ");
    db4 = input("Grundcirkeldiameter 4 = ");
    
    da1 = input("Tandtopdiameter 1 = ");
    da2 = input("tandtopdiameter 2 = ");
    da3 = input("Tandtopdiameter 3 = ");
    da4 = input("tandtopdiameter 4 = ");
    

    Ns = [N1 N2 N3];
    ds = [d1 d2 d3];
end

i = 0;
while i < 4
    i = i+1;
    
    % Tangentialmodul
    if isempty(mt1) && ~isempty(mn1) && ~isempty(psi)
        disp("Tangentialmodul 1")
        mt1 = mn1/cosd(psi)

    elseif isempty(mn1) && ~isempty(mt1) && ~isempty(psi)
        disp("Modul 1")
        mn1 = mt1 * cosd(psi)

    elseif isempty(mt2) && ~isempty(mn2) && ~isempty(psi)
        disp("Tangentialmodul 2")
        mt2 = mn2/cosd(psi)

    elseif isempty(mn2) && ~isempty(mt2) && ~isempty(psi)
        disp("Modul 2")
        mn2 = mt2 * cosd(psi)
    
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
    if isempty(d1) && ~isempty(N1) && ~isempty(mt1)
        disp("Delecirkeldiameter 1")
        d1 = N1 * mt1

    elseif isempty(d2) && ~isempty(N2) && ~isempty(mt1)
        disp("Delecirkeldiameter 2")
        d2 = N2 * mt1

    elseif isempty(d3) && ~isempty(N3) && ~isempty(mt2)
        disp("Delecirkeldiameter 3")
        d3 = N3 * mt2

    elseif isempty(d4) && ~isempty(N4) && ~isempty(mt2)
        disp("Delecirkeldiameter 4")
        d4 = N4 * mt2

    end

    if isempty(N1) && ~isempty(d1) && ~isempty(mt1)
        disp("N1 Tandantal")
        N1 = d1/mt1

    elseif isempty(N2) && ~isempty(d2) && ~isempty(mt1)
        disp("N2 Tandantal")
        N2 = d2/mt1

    elseif isempty(N3) && ~isempty(d3) && ~isempty(mt2)
        disp("N3 Tandantal")
        N3 = d3/mt2

    elseif isempty(N4) && ~isempty(d4) && ~isempty(mt2)
        disp("N4 Tandantal")
        N4 = d4/mt2

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

    elseif isempty(db3) && ~isempty(d3) && ~isempty(phi_t)
        disp("Grundcirkeldiameter 3")
        db3 = d3 * cosd(phi_t)

    elseif isempty(db4) && ~isempty(d4) && ~isempty(phi_t)
        disp("Grundcirkeldiameter 4")
        db4 = d4 * cosd(phi_t)

    elseif isempty(phi_t) && ~isempty(db1) && ~isempty(d1)
        disp("Tangentialindgrebsvinkel")
        phi_t = acosd(db1/d1)

    elseif isempty(phi_t) && ~isempty(db2) && ~isempty(d2)
        disp("Tangentialindgrebsvinkel")
        phi_t = acosd(db2/d2)

    elseif isempty(phi_t) && ~isempty(db3) && ~isempty(d3)
        disp("Tangentialindgrebsvinkel")
        phi_t = acosd(db3/d3)

    elseif isempty(phi_t) && ~isempty(db4) && ~isempty(d4)
        disp("Tangentialindgrebsvinkel")
        phi_t = acosd(db4/d4)

    elseif isempty(d1) && ~isempty(db1) && ~isempty(phi_t)
        disp("Delecirkeldiameter 1")
        d1 = db1/cosd(phi_t)

    elseif isempty(d2) && ~isempty(db2) && ~isempty(phi_t)
        disp("Delecirkeldiameter 2")
        d2 = db2/cosd(phi_t)

    elseif isempty(d3) && ~isempty(db3) && ~isempty(phi_t)
        disp("Delecirkeldiameter 3")
        d3 = db3/cosd(phi_t)

    elseif isempty(d4) && ~isempty(db4) && ~isempty(phi_t)
        disp("Delecirkeldiameter 4")
        d4 = db4/cosd(phi_t)

    end
    
    % Tandtopdiameter

    if isempty(da1) && ~isempty(d1) && ~isempty(mn1)
        disp("Tandtopdiameter 1")
        da1 = d1 + 2*mn1

    elseif isempty(da2) && ~isempty(d2) && ~isempty(mn1)
        disp("Tandtopdiameter 2")
        da2 = d2 + 2*mn1

    elseif isempty(d1) && ~isempty(da1) && ~isempty(mn1)
        disp("Delecirkeldiameter 1")
        d1 = da1 - 2*mn1

    elseif isempty(d2) && ~isempty(da2) && ~isempty(mn1)
        disp("Delecirkeldiameter 2")
        d2 = da2 - 2*mn1
    
    elseif isempty(mn1) && ~isempty(da1) && ~isempty(d1)
        disp("Modul 1")
        mn1 = (da1 - d1)/2

    elseif isempty(mn1) && ~isempty(da2) && ~isempty(d2)
        disp("Modul 1")
        mn1 = (da2 - d2)/2

    elseif isempty(da3) && ~isempty(d3) && ~isempty(mn2)
        disp("Tandtopdiameter 3")
        da3 = d3 + 2*mn2

    elseif isempty(da4) && ~isempty(d4) && ~isempty(mn2)
        disp("Tandtopdiameter 4")
        da4 = d4 + 2*mn2

    elseif isempty(d3) && ~isempty(da3) && ~isempty(mn2)
        disp("Delecirkeldiameter 3")
        d3 = da3 - 2*mn2

    elseif isempty(d4) && ~isempty(da4) && ~isempty(mn3)
        disp("Delecirkeldiameter 4")
        d4 = da4 - 2*mn2
    
    elseif isempty(mn2) && ~isempty(da3) && ~isempty(d3)
        disp("Modul 1")
        mn2 = (da3 - d3)/2

    elseif isempty(mn2) && ~isempty(da4) && ~isempty(d4)
        disp("Modul 1")
        mn2 = (da4 - d4)/2

    end
    
    % Indgrebsgrad

    if ~isempty(da1) && ~isempty(da2) && ~isempty(db1) && ~isempty(db2)  && ~isempty(d1) && ~isempty(d2)  && ~isempty(mt1)  && ~isempty(phi_t) && ~isempty(psi) && ~isempty(mn1) && ~isempty(F)
        disp("mT = Totalindgrebsgrad 1")
        mC = (0.5*(sqrt(da1^2 - db1^2) + sqrt(da2^2 - db2^2))-((d1+d2)/2)*sind(phi_t))/(pi*mt1*cosd(phi_t))
        
        mF = F*sind(psi)/(pi * mn1)
        
        mT = mC + mF

    end

    if ~isempty(da3) && ~isempty(da4) && ~isempty(db3) && ~isempty(db4)  && ~isempty(d3) && ~isempty(d4)  && ~isempty(mt2)  && ~isempty(phi_t) && ~isempty(psi) && ~isempty(mn2) && ~isempty(F)
        disp("mT = Totalindgrebsgrad 2")
        mC = (0.5*(sqrt(da3^2 - db3^2) + sqrt(da4^2 - db4^2))-((d3+d4)/2)*sind(phi_t))/(pi*mt2*cosd(phi_t))
        
        mF = F*sind(psi)/(pi * mn2)
        
        mT = mC + mF

    end

    
end
end