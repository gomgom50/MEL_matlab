function [suboptpktfolge,subopttid] = subopttotalrejsetid(rejsetider,pktfolge0)
N = length(pktfolge0);                            % Antal punkter
suboptpktfolge = pktfolge0;                       % Er bedste rækkefølge før der byttes om
subopttid = totalrejsetid_min(rejsetider,pktfolge0);  % Er samlet rejsetid før der byttes om
%ændrede til min funktion
hidtilkortestetid = subopttid;                    % Er bedste samlede rejsetid hidtil
while 1
  % Gennemtjek for ombytninger i svejserækkefølgen, der giver kortere samlet rejsetid
  for i = 1:N-1
    for j = i+1:N
      testpktfolge = suboptpktfolge;
      testpktfolge([i j]) = testpktfolge([j i]);  % Ombyt to punkter i rækkefølgen
      testtid = totalrejsetid_min(rejsetider,testpktfolge);
      %ændrede til min funktion
      if testtid < subopttid &&  testpktfolge(1) == 1 && testpktfolge(21) == 1%Vi har her tilføjede 2 betingelser for at den nye
% rækkefølge kan vuderes bedre end den forige
        subopttid = testtid;
        suboptpktfolge = testpktfolge;
      end
    end
  end
  % Hvis ingen rejsetidsforkortende ombytninger fundet, stop søgning, ellers fortsæt
  if subopttid == hidtilkortestetid
    break                                       % Afslut while-løkken og dermed funktionen
  else
    hidtilkortestetid = subopttid;              % Opdater hidtil korteste tid
  end
end
