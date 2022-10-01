function Alt = Ligefortandet(type, last)

% Inputs af kendte værdier
if type == "ligefortandet" && last == "nej"
    disp("Indtast alle de værdier der kendes")

    N_hjul = input("Antal tandhjul: ");
    N1 = input("N1 = ");
    N2 = input("N2 = ");
    N3 = input("N3 = ");
    N4 = input("N4 = ");

    mn = input("Modul = ");
    C = input("Centerakseafstand = ");

    d1 = input("Delecirkeldiameter 1 = ");
    d2 = input("Delecirkeldiameter 2 = ");
    d3 = input("Delecirkeldiameter 3 = ");
    d4 = input("Delecirkeldiameter 4 = ");

    db1 = input("Grundcirkeldiameter 1 = ");
    db2 = input("Grundcirkeldiameter 2 = ");

    da1 = input("Tandtopdiameter 1 = ");
    da2 = input("tandtopdiameter 2 = ");

    phi = input("Indgrebsvinkel i grader = ");

    Ns = [N1 N2 N3 N4];
    ds = [d1 d2 d3 d4];

elseif type == "ligefortandet" && last == "ja"
    N_hjul = input("Antal tandhjul: ");
    N1 = input("N1 = ");
    N2 = input("N2 = ");
    N3 = input("N3 = ");
    N4 = input("N4 = ");

    mn = input("Modul = ");

    F_f = input("Tandhjulsfaktor = ");

    F1 = input("Tandhjulsbredde 1 = ");
    F2 = input("Tandhjulsbredde 2 = ");
    F3 = input("Tandhjulsbredde 3 = ");
    F4 = input("Tandhjulsbredde 4 = ");

    T_last = input("Lastmoment = ");

    i1 = input("Udvekslingsforhold 1 = ");
    i2 = input("Udvekslingsforhold 2 = ");
    i3 = input("Udvekslingsforhold 3 = ");
    i4 = input("Udvekslingsforhold 4 = ");

    omega1 = input("Omdrejningshastighed 1 i rad/s = ");
    omega2 = input("Omdrejningshastighed 2 i rad/s = ");
    omega3 = input("Omdrejningshastighed 3 i rad/s = ");
    omega4 = input("Omdrejningshastighed 4 i rad/s = ");

    ad1 = input("Akseldiameter 1 = ");
    ad2 = input("Akseldiameter 2 = ");

    eta_tdr = input("Virkningsgrad tandovergang = ");
    eta_leje = input("Virkningsgrad leje = ");

    n_tdr = input("Antal tandovergange = ");
    n_lejer = input("Antal lejer = ");

    Qv = input("Kvalitetstal = ");
    R = input("Pålidelighedsfaktor = ");

    C = input("Centerakseafstand 1 = ");
    
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

    phi = input("Indgrebsvinkel i grader = ");

    Ns = [N1 N2 N3 N4];
    ds = [d1 d2 d3 d4];

end

i = 0;
while i < 3
    i = i+1;

    % Udregninger af delecirkeldiameter
    if isempty(d1) && ~isempty(N1) && ~isempty(mn)
        disp("Delecirkeldiameter 1")
        d1 = N1 * mn

    elseif isempty(d2) && ~isempty(N2) && ~isempty(mn)
        disp("Delecirkeldiameter 2")
        d2 = N2 * mn

    elseif isempty(d3) && ~isempty(N3) && ~isempty(mn)
        disp("Delecirkeldiameter 3")
        d3 = N3 * mn

    elseif isempty(d4) && ~isempty(N4) && ~isempty(mn)
        disp("Delecirkeldiameter 4")
        d4 = N4 * mn

    end

    if isempty(N1) && ~isempty(d1) && ~isempty(mn)
        disp("Pinion 1 Tandantal")
        N1 = d1/mn

    elseif isempty(N2) && ~isempty(d2) && ~isempty(mn)
        disp("Gear 1 Tandantal")
        N2 = d2/mn

    elseif isempty(N3) && ~isempty(d3) && ~isempty(mn)
        disp("Pinion 2 Tandantal")
        N3 = d3/mn

    elseif isempty(N4) && ~isempty(d4) && ~isempty(mn)
        disp("Gear 2 Tandantal")
        N4 = d4/mn

    elseif isempty(mn)
        disp("Modul")
        mn = ds./Ns
    end

    % Centerakseafstand
    if isempty(C) && ~isempty(d1) && ~isempty(d2)
        disp("Centerakseafstand for tandhjul 1 og 2")
        C1 = (d1 + d2)/2

    elseif isempty(C) && ~isempty(d3) && ~isempty(d4)
        disp("Centerakseafstand for tandhjul 3 og 4")
        C2 = (d3 + d4)/2

    elseif ~isempty(C) && ~isempty(d1) && isempty(d2)
        disp("Delecirkeldiameter 2")
        syms d2
        eq = C == (d1 + d2)/2;
        d2 = solve(eq, d2)

    elseif ~isempty(C) && ~isempty(d2) && isempty(d1)
        disp("Delecirkeldiameter 1")
        syms d1
        eq = C == (d1 + d2)/2;
        d1 = solve(eq, d1)


    end

    % Grundcirkeldiameter

    if isempty(db1) && ~isempty(d1) && ~isempty(phi)
        disp("Grundcirkeldiameter 1")
        db1 = d1 * cosd(phi)

    elseif isempty(db2) && ~isempty(d2) && ~isempty(phi)
        disp("Grundcirkeldiameter 2")
        db2 = d2 * cosd(phi)

    elseif isempty(phi) && ~isempty(db1) && ~isempty(d1)
        disp("Indgrebsvinkel")
        phi = acosd(db1/d1)

    elseif isempty(phi) && ~isempty(db2) && ~isempty(d2)
        disp("Indgrebsvinkel")
        phi = acosd(db2/d2)

    elseif isempty(d1) && ~isempty(db1) && ~isempty(phi)
        disp("Delecirkeldiameter 1")
        d1 = db1/cosd(phi)

    elseif isempty(d2) && ~isempty(db2) && ~isempty(phi)
        disp("Delecirkeldiameter 2")
        d2 = db2/cosd(phi)

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
    
    % Tandhjulsbredde
    
    if isempty(F1) && ~isempty(F_f) && ~isempty(mn)
        disp("Tandhjulsbredde 1")
        F1 = pi * F_f * mn + 2

    elseif isempty(F2) && ~isempty(F_f) && ~isempty(mn)
        disp("Tandhjulsbredde 2")
        F2 = pi * F_f * mn

    elseif isempty(F3) && ~isempty(F_f) && ~isempty(mn)
        disp("Tandhjulsbredde 3")
        F3 = pi * F_f * mn

    elseif isempty(F4) && ~isempty(F_f) && ~isempty(mn)
        disp("Tandhjulsbredde 4")
        F4 = pi * F_f * mn

    end

    % Udvekslingsforhold

    if isempty(i1) && ~isempty(N1) && ~isempty(N2)
        i1 = N2/N1

    elseif isempty(i2) && ~isempty(N3) && ~isempty(N4)
        i2 = N4/N3

    elseif isempty(N1) && ~isempty(i1) && ~isempty(N2)
        N1 = N2/i1

    elseif isempty(N2) && ~isempty(N1) && ~isempty(i1)
        N2 = i1 * N1

    elseif isempty(N3) && ~isempty(N4) && ~isempty(i2)
        N3 = N4/i2

    elseif isempty(N4) && ~isempty(N3) && ~isempty(i2)
        N4 = i2 * N3

    end

    if ~isempty(i1) && ~isempty(i2)
        disp("Total virkningsgrad")
        i_tot = i1 * i2

    % Vinkelhastigheder

    if isempty(omega1) && ~isempty(omega2) && ~isempty(i1)
        disp("Vinkelhastighed for pinion 1")
        omega1 = i1 * omega2

    elseif isempty(omega2) && ~isempty(omega1) && ~isempty(i1)
        disp("Vinkelhastighed for gear 1")
        omega2 = omega1/i1

    elseif isempty(omega3) && ~isempty(omega4) && ~isempty(i2)
        disp("Vinkelhastighed for pinion 2")
        omega3 = omega4 * i2

    elseif isempty(omega4) && ~isempty(omega3) && ~isempty(i2)
        disp("Vinkelhastighed for gear 2")
        omega4 = omega3/i2

end
end
%----------------------%
%        LASTER        %
%----------------------%

% Momenter for aksler
if ~isempty(T_last) && ~isempty(eta_leje) && ~isempty(eta_tdr)
    disp("Moment for aksel 1")
    Tp = T_last/(i1 * eta_tdr * eta_leje^4)

end

% Tangentialkræfter
if ~isempty(Tp) && ~isempty(d1)
    disp("Tangentialkræfter for pinion og gear - modsatrettede og lige store")
    Wd1 = Tp/(d1/2)
    Wd2 = Wd1
end    
    

% Hastigheder
if ~isempty(omega1) && ~isempty(omega2) && ~isempty(d1) && ~isempty(d2)
    disp("Hastighed for pinion 1")
    Vp = d1/2 * omega1
    
    disp("Hastighed for gear 1")
    Vg = d2/2 * omega2

elseif ~isempty(omega3) && ~isempty(omega4) && ~isempty(d3) && ~isempty(d4)
    disp("Hastighed for pinion 2")
    Vp = d3/2 * omega3
    
    disp("Hastighed for gear 2")
    Vg = d4/2 * omega4


end

    
% Bøjningsspændinger i tandfoden



end
