function Alt = Ligefortandet(type, last)

% Inputs af kendte værdier
if type == "ligefortandet" 
    disp("Indtast alle de værdier der kendes")

    N_hjul = input("Antal tandhjul: ");
    N1 = input("N1 = ");
    N2 = input("N2 = ");
    N3 = input("N3 = ");
    mn = input("Modul = ");
    C = input("Centerakseafstand = ");
    d1 = input("Delecirkeldiameter 1 = ");
    d2 = input("Delecirkeldiameter 2 = ");
    d3 = input("Delecirkeldiameter 3 = ");

    db1 = input("Grundcirkeldiameter 1 = ");
    db2 = input("Grundcirkeldiameter 2 = ");

    da1 = input("Tandtopdiameter 1 = ");
    da2 = input("tandtopdiameter 2 = ");

    phi = input("Indgrebsvinkel i grader = ");

    Ns = [N1 N2 N3];
    ds = [d1 d2 d3];

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

    end

    if isempty(N1) && ~isempty(d1) && ~isempty(mn)
        disp("N1 Tandantal")
        N1 = d1/mn

    elseif isempty(N2) && ~isempty(d2) && ~isempty(mn)
        disp("N2 Tandantal")
        N2 = d2/mn

    elseif isempty(N3) && ~isempty(d3) && ~isempty(mn)
        disp("N3 Tandantal")
        N3 = d3/mn

    elseif isempty(mn)
        disp("Modul")
        mn = ds./Ns
    end

    % Centerakseafstand
    if isempty(C)
        disp("Centerakseafstand")
        C = (d1 + d2)/2

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
    
    
end
end
