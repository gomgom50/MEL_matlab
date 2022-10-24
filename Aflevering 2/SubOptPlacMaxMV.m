function [SubOptPl,SubOptMV] = SubOptPlacMaxMV(Tr,Dst,Pl0)
% SubOptPlacMaxMV - Returnerer den rute der afgiver den højeste numeriske
% værdi baseret på Maalfunktionen (MaalFkt) ved suboptimal placering.
% Kald: SubOptPlacMaxMV(Tr,Dst,Pl0)
% Input:
% Pl = Placeringen af lokationer.
% Tr = Numeriske værdier tilskrevet placering.
% Dst = Afstanden mellem placeringer.
% Output:
% SubOptPlacMaxMV(Tr,Dst,Pl0) - Numerisk værdi & array "rute".

% Stedholdere for den tidligere bedste numeriske værdi og den mulige
% opkommende bedste numeriske værdi.
max = MaalFkt(Pl0, Tr, Dst);
oldMax = MaalFkt(Pl0, Tr, Dst);

% Variable & Stedholder for bedste rute.
bedsteMatrix = Pl0;

%
for j = 1:length(Tr)
    for i = 1:length(Tr)
        mutMatrix = bedsteMatrix;

        % Et eksempel på en meget simpelt mutMatrix [1, 2] i først
        % for loop sker der ikke nået da i og j = 1, i næste for
        % loop så ville position i og j blive flippede. muMatrix
        % ville således så sådanne ud: [2, 1]
        pos1 = bedsteMatrix(j);
        pos2 = bedsteMatrix(i);
        mutMatrix(i) = pos1;
        mutMatrix(j) = pos2;

        %Hvis den MaalFkt giver en støre max værdig en tidligere
        %sat max så ville denne nye MaalFkt blive sat til max og
        %den nye bedste matrix sat.
        if MaalFkt(mutMatrix, Tr, Dst) > max
            max = MaalFkt(mutMatrix, Tr, Dst);
            bedsteMatrix = mutMatrix;
        end
    end
end

%Hvis alle mulige græne som ikke er afskået er gennemgået og der
%ikke fantes en max værdig som er støre en den tidligere fundet max
%værdig så må vi have fundet den sub optimale løsning og while
%loopet bliver broken.
SubOptMV = max
SubOptPl = bedsteMatrix
end