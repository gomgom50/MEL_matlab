function pris = billettakst(zoner,billettype,alder)
if zoner < 2 || zoner > 26, error('Zoner skal være ml. 2 og 26'), end
if strcmp(billettype,'kontant')
  if zoner <= 2
    pris = 10*zoner + 2;
  else
    pris = 10 * zoner;
  end
elseif strcmp(billettype,'rejsekort')
  if zoner <= 3
    pris = 5*zoner + 2.5;
  elseif zoner <= 6
    pris = 5.5 * zoner+1;
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
  pris = pris * 1/2;
end
  