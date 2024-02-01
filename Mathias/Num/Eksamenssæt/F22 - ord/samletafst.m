function sa = samletafst(kundetildelt,afstande)
% samletafst - Bestemmer den samlede afstand imellem de ni kunder ot
% teknikkere for at vudere det mest effektive senarie.
% Kald: sa = samletafst(kundetildelt,afstande)
% Input:
% kundetildelt = rækkefølgen af kunder tildelt teknikker 1 til 9 vektor
% form
% afstande = afstanden imellem taknikker og den tildelte kunde på matrix
% form
% Output:
% sa = den samlede afstand imellem alle teknikker og kunder

    sum = 0; % bruges i forloop til at sumere continuert

    %næstede forloop starter
    for i = 1:length(kundetildelt) %forloop der køre fra 1 til længden af Pl
        sum = sum + afstande(i,kundetildelt(i));
    end

    sa = sum; % summen af værdierne udskrives
end