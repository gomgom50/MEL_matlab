function [SubOptPl,SubOptMV] = SubOptPlacMaxMV(Tr,Dst,Pl0)
% SubOptPlacMaxMV - Returnerer den rute der afgiver den højeste numeriske
% værdi baseret på Maalfunktionen (MaalFkt) ved suboptimal placering.
% Kald: SubOptPlacMaxMV(Tr,Dst,Pl0)
% Input:
% Pl0 = Start placeringen af lokationer eller udgangspunktet.
% Tr = Numeriske værdier tilskrevet placering.
% Dst = Afstanden mellem placeringer eller kommunikationspotentialet.
% Output:
% SubOptPlacMaxMV(Tr,Dst,Pl0) - Numerisk værdi & vektor med "rute".
% SubOptPl = Numerisk værdi der afgøre hvor god placeringen er, 
% højst er bedst.
% SubOptMV = vektor med placeringerne der har en god placering.

% Stedholdere for den tidligere bedste numeriske værdi og den mulige
% opkommende bedste numeriske værdi.
max = MaalFkt(Pl0, Tr, Dst);
oldMax = MaalFkt(Pl0, Tr, Dst);

% Variable & Stedholder for bedste rute.
bedsteMatrix = Pl0;

% Nestede forloop starter
for j = 1:length(Tr)
    for i = 1:length(Tr)
        mutMatrix = bedsteMatrix;

        % Et eksempel på en meget simpelt mutMatrix [1, 2] i først
        % for loop sker der ikke noget da i og j = 1. I næste for
        % loop så vil position i og j blive flippede. muMatrix
        % vil således blive: [2, 1]
        pos1 = bedsteMatrix(j);
        pos2 = bedsteMatrix(i);
        mutMatrix(i) = pos1;
        mutMatrix(j) = pos2;

        %Hvis MaalFkt giver en større max værdi end den tidligere
        %satte max så vil denne nye MaalFkt blive sat til max og
        %den nye bedste matrix sat.
        if MaalFkt(mutMatrix, Tr, Dst) > max
            max = MaalFkt(mutMatrix, Tr, Dst);
            bedsteMatrix = mutMatrix;
        end
    end
end

%Hvis alle mulige græne som ikke er afskået er gennemgået og der
%ikke fandtes en max værdi som er støre en den tidligere fundet max
%værdi så må vi have fundet den sub optimale løsning hvilket udskrives.
SubOptMV = max
SubOptPl = bedsteMatrix
end