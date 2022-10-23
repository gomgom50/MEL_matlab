function MV = MaalFkt(Pl,Tr,Dst)
% MaalFkt - Bestemmer den totale score af af funktionen ved at
% gange de to matricer sammen en indgang af gangen 
% for alle rækker i og kolonner j
% Kald: MV = MaalFkt(Pl,Tr,Dst)
% Input:
% Pl = Placeringen af lokationer
% Tr = Numersik værdi af tilskrevede placering
% fx Tr(2,1) kan være mængden der transporteres fra lokation 1 til 2
% Dst = Afstande mellem placeringer
% fx Dst(2,1) kan være værdien fra lokation 1 til 2
% Output:
% MV = den totale score

    sum = 0; % bruges i forloop til at sumere continuert

    %næstede forloop starter
    for i = 1:length(Pl) %forloop der køre fra 1 til længden af Pl

        for j = i:length(Tr) %forloop der køre fra i til længden af Tr

            % i reduceres med 1 for hver gang dette forloop er gennemført
            % Hver indgang ganges nu sammen i de to matricer Dst og Tr
            sum = Dst(i,j) .* Tr(Pl(i), Pl(j)) + sum;
            % Det ses at der bruges indgangen for placeringen(Pl) for Tr
            % da placeringenerne kan ændres men afstanden imellem pladser
            % ikke ændres
        end
    end
    % Ved slut er alle tal i den øvre trekant af matrixen gennemgået
    MV = sum; % summen af værdierne udskrives
end
