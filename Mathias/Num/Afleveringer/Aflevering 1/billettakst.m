function pris = billettakst(zoner,billettype,alder)
% billettakst - Skriver prisen på en bestemt billet type
% Kald: pris = billettakst(zoner,billettype,alder)
% Input:
% zoner = antal zoner passageren skal køre
% billettype = billettypen der skal rejses med
% alder = alderen på passageren
% Output:
% pris = prisen på billeten
if zoner < 2 || 26 < zoner, error('Zoner skal være ml. 2 og 26'), end
if strcmp(billettype,'kontant')
    if zoner <= 4,
        pris = 10*zoner + 2;
    else
        pris = 10*zoner;
    end
elseif strcmp(billettype,'rejsekort')
    if zoner <= 3
        pris = 5*zoner + 2.5;
elseif zoner <= 6
    5.5*zoner + 1;
    elseif zoner <= 8
        pris = 6*zoner - 2;
    elseif zoner <= 10
        pris = 6*zoner - 2.5;
    else
        pris = 5.5*zoner + 2.5;
    end
else
error('Ugyldig billettype')
end
if strcmp(alder,'barn')
    pris = ans/2;
end