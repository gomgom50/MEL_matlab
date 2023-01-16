function trt = totalrejsetid_min(rejsetider,pktfolge)
% totalrejsetid - Bestemmer den totale score af funktionen ved at
% gange de to matricer sammen en indgang af gangen
% for alle rækker i og kolonner j
% Kald: trt = totalrejsetid(Pl,Tr,Dst)
% Input:
% rejsetider = Numersik værdi af tilskrevede afstand til placering
% pktfolge = rækkefølgen der rejses i (punkt til punkt)
% Output:

N = length(pktfolge);
trt = 0; % bruges i forloop til at sumere continuert

%næstede forloop starter
for i = 1:N-1 %forloop der køre fra 1 til længden af Pl
    trt = rejsetider(pktfolge(i), pktfolge(i+1)) + trt;
end
end