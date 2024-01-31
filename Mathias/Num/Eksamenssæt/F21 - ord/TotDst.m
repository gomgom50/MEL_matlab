function TD = TotDst(Pl,Tr,Dst)
% MaalFkt - Bestemmer den totale score af funktionen ved at
% gange de to matricer sammen en indgang af gangen
% for alle rækker i og kolonner j
% Kald: TD = TotDst(Pl,Tr,Dst)
% Input:
% Pl = Placeringen af lokationer
% Tr = Numersik værdi af tilskrevede placering
% fx Tr(2,1) kan være mængden der transporteres fra lokation 2 til 1
% Dst = Afstande mellem placeringer
% fx Dst(2,1) kan være værdien fra lokation 2 til 1
% Output:
% TD = den totale score

sum = 0; % bruges i forloop til at sumere continuert

%næstede forloop starter
for i = 1:length(Pl) %forloop der køre fra 1 til længden af Pl

    for j = i:length(Tr) %forloop der køre fra i til længden af Tr
        % Hver indgang ganges nu sammen i de to matricer Dst og Tr
        sum = Dst(i,j) * Tr(Pl(i), Pl(j)) + sum;
        sum = Dst(j,i) * Tr(Pl(j), Pl(i)) + sum;
    end
end
% Ved slut er alle tal i matrixen gennemgået
TD = sum; % summen af værdierne udskrives
end