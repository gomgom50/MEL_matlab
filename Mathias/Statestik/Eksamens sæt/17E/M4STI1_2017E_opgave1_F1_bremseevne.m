%% M4STI1 2017E Opgave 1: Eksperiment med 3 faktorers indflydelse p� bremseevne
clc; clear; close all; format compact; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2017E.xlsx','A:D')

x = D(:,1:3)    % Kombinationer af de tre faktorers niveauer
bremse = x(:,1)
koerer = x(:,2)
daek = x(:,3)
y = D(:,4)      % M�linger af bremseevne (ms)


%% a: Boxplots
figure(1)
boxplot(y, bremse, 'labels', {'Brembo'; 'Carbone Industrie'})
title('Bremseevne for bremsefabrikater')

figure(2)
boxplot(y, koerer, 'labels', {'8: Grosjean'; '20: Magnussen'})
title('Bremseevne for racerk�rere')

figure(3)
boxplot(y, daek, 'labels', {'Medium'; 'Soft'; 'Ultrasoft'})
title('Bremseevne for d�ktyper')

% Fig. 1 viser, at de to bremsefabrikater er sammenlignelige. Medianen er
% lavere for CI, men IQR er ensartede. CI har mindre koste, s� CI bremser 
% mere ensartet end Brembo, alt andet lige.
% Fig. 2 viser, at de to racerk�rere er meget ens. De har nogenlunde lige 
% store IQR og koste, men der er en tendens til at Magnussens boksplot
% ligger lidt lavere end Grosjeans, alts� at Magnussen bremser bedre. 
% Fig. 3 viser, at der er tydelig forskel p� de tre d�ktyper. Som forventet
% har Ultrasoft bedst vejgreb, s� bremsetiden er kortest. Tilsvarende
% bremser Soft d�k bedre end Medium. IQR og koste er af sammenlignelig
% st�rrelse, s� ensartet variation. Der er tre outliers, men det er ikke
% bekymrende. De er alle st�rre end forventet, s� det er sikkert bare 
% nedbremsninger, der ikke er forl�bet optimalt, f.eks. p.g.a. udskridning. 


%% b: ANOVA 
[p,table,stats,terms] = anovan(y, x, 'model','full', 'varnames',{'Bremse','K�rer','D�k'})

% NB: Jeg bruger Name-Value kombinationen 'model', 'full' for at f� ogs�
% tre-faktor interaktionen med. Hvis jeg brugte 'interaction' ville jeg kun 
% f� to-faktor interaktionerne. 

% Der er ikke signifikant forskel p� bremsefabrikaterne (p=0.29)
% Der er signifikant forskel p� k�rerne (p=0.0001)
% Der er signifikant forskel p� d�ktyperne (p=0)
% Der er signifikant interaktion mellem bremsefabrikat og k�rer (p=0)
% Der er ikke andre signifikante 2-faktor interaktioner
% Der er ikke signifikant 3-faktor interaktion (mellem bremsefabrikat, 
%     k�rer og d�ktype) (p=0.70)


%% c: Frihedsgrader
% For interaktionen mellem to faktorer A og C med hhv. a og c niveauer er 
% der (a-1)*(c-1) frihedsgrader. 
% Derfor er der for interaktionen mellem bremsefabrikat og d�ktype
% (2-1)*(3-1) = 2 frihedsgrader. 


%% d: Parvis sammenligning af d�ktyper
% D�ktype er den tredje faktor, s� vi skal bruge 'Dimension', [3] i kaldet 
% af multcompare 
[c,m] = multcompare(stats, 'Alpha',0.05, 'CType','lsd', 'Dimension',[3])

% Resultatet er, at alle tre d�ktyper har signifikant forskellig
% bremseevne. I matricen c har hver af de tre parvise sammenligninger en
% p-v�rdi p� h�jest 0.0001.

% If�lge c matricen er 95 % konfidensintervallet for forskellen p� bremseevne 
% for hvert par af d�ktyper f�lgende:
% Medium og Soft (1 og 2):       [ 71.7; 114.7]   
% Medium og Ultrasoft (1 og 3):  [115.8; 158.9]
% Soft og Ultrasoft (2 og 3):    [ 22.6;  65.7]


%% e: 
% Ved at v�lge 'Dimension', [1,2,3] f�r jeg sammenlignet alle
% kombinationer. 
[c,m] = multcompare(stats, 'Alpha',0.05, 'CType','lsd', 'Dimension', [1,2,3])
% If�lge grafikken, der kommer ud af multcompare er den bedste kombination
% (d.v.s. korteste forventede bremsetid) Brembo, Magnussen, Ultrasoft. 
% Denne kombination er signifikant forskellig fra alle, bortset fra den 
% n�stbedste, nemlig CI, Grosjean, Ultrasoft. 
% Den d�rligste kombination er Brembo, Grosjean, Medium. 
% Der er signifikant forskel p� kombinationerne. Det ses f.eks. grafisk, da
% den d�rligste kombination er forskellig fra alle andre, s�ledes ogs� den 
% bedste. 
% Det kan ogs� ses i c matricen, hvor den d�rligste kombination (1) 
% sammenlignes med den bedste (11) i matricens r�kke 10 med en p-v�rdi 
% p� 0.0000.


%% f: Antagelser for residualer
% Vi har antaget, at residualerne er normalfordelte med middelv�rdi 0 og 
% med samme varians for hver faktor. 
% Residualer findes i stats objektet, lavet af anovan
resid = stats.resid

figure(4)
normplot(resid)
% Residualerne ligger rimeligt p�nt p� en linje, s� de lader til at v�re
% normalfordelte, som antaget

figure(5)
scatter(bremse, resid, 'filled')
xlabel('Bremsefabrikat')
ylabel('Residualer')
title('Bremseevne for bremsefabrikater')
axis([0 3 -100 100])
% Der er st�rre varians p� residualerne for Brembo end for CI

figure(6)
scatter(koerer, resid, 'filled')
xlabel('Racerk�rer')
ylabel('Residualer')
title('Bremseevne for racerk�rer')
axis([0 25 -100 100])

% Grosjean (8) har st�rre varians p� residualerne end Magnussen (20)

figure(7)
scatter(daek, resid, 'filled')
xlabel('D�ktype')
ylabel('Residualer')
title('Bremseevne for d�ktyper')
axis([0 4 -100 100])
% Der er mindre varians p� residualerne for Soft bremser end for Medium og 
% Ultrasoft

% Vi kan ikke v�re helt trygge ved vores konklusioner, da der lader til at
% v�re forskel p� variationerne for de forskellige faktorer. Residualerne
% lader dog til at v�re normalfordelte.  

% Bonus-info:
% Vi kan lave en Bartlett's test for hver faktor 
% (Der blev kun bedt om en unders�gelse med plots, s� dette er udenfor 
% forventningerne til opgavens besvarelse). 
vartestn(y, bremse)
vartestn(y, koerer)
vartestn(y, daek)
% For hver test er p-v�rdien over 5%, s� vi kan ikke forkaste nulhypotesen,
% som siger, at variansen er ens. Vi kan s�ledes g� ud fra, at variansen er
% ens for alle faktorniveauer, som vi har antaget. De visuelle forskelle
% fra plots er ikke store nok til at v�re signifikante. 
