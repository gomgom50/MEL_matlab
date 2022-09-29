function Alt = MelInputTest(type)
    
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
    
    Ns = [N1 N2 N3];
    ds = [d1 d2 d3];
    end
    
    % Udregninger
    if isempty(d1)
        d1 = N1 * mn
        
    elseif isempty(d2)
        d2 = N2 * mn

    elseif isempty(d3)
        d3 = N3 * mn

    elseif isempty(N1)
        N1 = d1/mn

    elseif isempty(N2)
        N2 = d2/mn

    elseif isempty(N3)
        N3 = d3/mn
    end
    

end
    