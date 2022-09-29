function Alt = Ligefortandet(type)

% Inputs af kendte værdier
if type == "Ligefortandet"
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

    phi = input("Indgrebsvinkel i grader = ");

    Ns = [N1 N2 N3];
    ds = [d1 d2 d3];

end

i = 0;
while i < 3
    i = i+1;

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

    if isempty(db1) && ~isempty(d1) && ~isempty(phi)
        db1 = d1 * cosd(phi)

    elseif isempty(db2) && ~isempty(d2) && ~isempty(phi)
        db2 = d2 * cosd(phi)

    elseif isempty(phi) && ~isempty(db1) && ~isempty(d1)
        phi = acosd(db1/d1)

    elseif isempty(phi) && ~isempty(db2) && ~isempty(d2)
        phi = acosd(db2/d2)

    elseif isempty(d1) && ~isempty(db1) && ~isempty(phi)
        d1 = db1/cosd(phi)

    elseif isempty(d2) && ~isempty(db2) && ~isempty(phi)
        d2 = db2/cosd(phi)

    end
    

    
    
end
end
