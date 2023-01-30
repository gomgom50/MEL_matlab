%% M4STI1 2017E Opgave 1: Eksperiment med 3 faktorers indflydelse på bremseevne
clc; clear; close all; format compact; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2017E.xlsx','A:D')

x = D(:,1:3)    % Kombinationer af de tre faktorers niveauer
bremse = x(:,1)
koerer = x(:,2)
daek = x(:,3)
y = D(:,4)      % Målinger af bremseevne (ms)


%% a: Boxplots
figure(1)
boxplot(y, bremse, 'labels', {'Brembo'; 'Carbone Industrie'})
title('Bremseevne for bremsefabrikater')

figure(2)
boxplot(y, koerer, 'labels', {'8: Grosjean'; '20: Magnussen'})
title('Bremseevne for racerkørere')

figure(3)
boxplot(y, daek, 'labels', {'Medium'; 'Soft'; 'Ultrasoft'})
title('Bremseevne for dæktyper')

% Fig. 1 viser, at de to bremsefabrikater er sammenlignelige. Medianen er
% lavere for CI, men IQR er ensartede. CI har mindre koste, så CI bremser 
% mere ensartet end Brembo, alt andet lige.
% Fig. 2 viser, at de to racerkørere er meget ens. De har nogenlunde lige 
% store IQR og koste, men der er en tendens til at Magnussens boksplot
% ligger lidt lavere end Grosjeans, altså at Magnussen bremser bedre. 
% Fig. 3 viser, at der er tydelig forskel på de tre dæktyper. Som forventet
% har Ultrasoft bedst vejgreb, så bremsetiden er kortest. Tilsvarende
% bremser Soft dæk bedre end Medium. IQR og koste er af sammenlignelig
% størrelse, så ensartet variation. Der er tre outliers, men det er ikke
% bekymrende. De er alle større end forventet, så det er sikkert bare 
% nedbremsninger, der ikke er forløbet optimalt, f.eks. p.g.a. udskridning. 


%% b: ANOVA 
[p,table,stats,terms] = anovan(y, x, 'model','full', 'varnames',{'Bremse','Kører','Dæk'})

% NB: Jeg bruger Name-Value kombinationen 'model', 'full' for at få også
% tre-faktor interaktionen med. Hvis jeg brugte 'interaction' ville jeg kun 
% få to-faktor interaktionerne. 

% Der er ikke signifikant forskel på bremsefabrikaterne (p=0.29)
% Der er signifikant forskel på kørerne (p=0.0001)
% Der er signifikant forskel på dæktyperne (p=0)
% Der er signifikant interaktion mellem bremsefabrikat og kører (p=0)
% Der er ikke andre signifikante 2-faktor interaktioner
% Der er ikke signifikant 3-faktor interaktion (mellem bremsefabrikat, 
%     kører og dæktype) (p=0.70)


%% c: Frihedsgrader
% For interaktionen mellem to faktorer A og C med hhv. a og c niveauer er 
% der (a-1)*(c-1) frihedsgrader. 
% Derfor er der for interaktionen mellem bremsefabrikat og dæktype
% (2-1)*(3-1) = 2 frihedsgrader. 


%% d: Parvis sammenligning af dæktyper
% Dæktype er den tredje faktor, så vi skal bruge 'Dimension', [3] i kaldet 
% af multcompare 
[c,m] = multcompare(stats, 'Alpha',0.05, 'CType','lsd', 'Dimension',[3])

% Resultatet er, at alle tre dæktyper har signifikant forskellig
% bremseevne. I matricen c har hver af de tre parvise sammenligninger en
% p-værdi på højest 0.0001.

% Ifølge c matricen er 95 % konfidensintervallet for forskellen på bremseevne 
% for hvert par af dæktyper følgende:
% Medium og Soft (1 og 2):       [ 71.7; 114.7]   
% Medium og Ultrasoft (1 og 3):  [115.8; 158.9]
% Soft og Ultrasoft (2 og 3):    [ 22.6;  65.7]


%% e: 
% Ved at vælge 'Dimension', [1,2,3] får jeg sammenlignet alle
% kombinationer. 
[c,m] = multcompare(stats, 'Alpha',0.05, 'CType','lsd', 'Dimension', [1,2,3])
% Ifølge grafikken, der kommer ud af multcompare er den bedste kombination
% (d.v.s. korteste forventede bremsetid) Brembo, Magnussen, Ultrasoft. 
% Denne kombination er signifikant forskellig fra alle, bortset fra den 
% næstbedste, nemlig CI, Grosjean, Ultrasoft. 
% Den dårligste kombination er Brembo, Grosjean, Medium. 
% Der er signifikant forskel på kombinationerne. Det ses f.eks. grafisk, da
% den dårligste kombination er forskellig fra alle andre, således også den 
% bedste. 
% Det kan også ses i c matricen, hvor den dårligste kombination (1) 
% sammenlignes med den bedste (11) i matricens række 10 med en p-værdi 
% på 0.0000.


%% f: Antagelser for residualer
% Vi har antaget, at residualerne er normalfordelte med middelværdi 0 og 
% med samme varians for hver faktor. 
% Residualer findes i stats objektet, lavet af anovan
resid = stats.resid

figure(4)
normplot(resid)
% Residualerne ligger rimeligt pænt på en linje, så de lader til at være
% normalfordelte, som antaget

figure(5)
scatter(bremse, resid, 'filled')
xlabel('Bremsefabrikat')
ylabel('Residualer')
title('Bremseevne for bremsefabrikater')
axis([0 3 -100 100])
% Der er større varians på residualerne for Brembo end for CI

figure(6)
scatter(koerer, resid, 'filled')
xlabel('Racerkører')
ylabel('Residualer')
title('Bremseevne for racerkører')
axis([0 25 -100 100])

% Grosjean (8) har større varians på residualerne end Magnussen (20)

figure(7)
scatter(daek, resid, 'filled')
xlabel('Dæktype')
ylabel('Residualer')
title('Bremseevne for dæktyper')
axis([0 4 -100 100])
% Der er mindre varians på residualerne for Soft bremser end for Medium og 
% Ultrasoft

% Vi kan ikke være helt trygge ved vores konklusioner, da der lader til at
% være forskel på variationerne for de forskellige faktorer. Residualerne
% lader dog til at være normalfordelte.  

% Bonus-info:
% Vi kan lave en Bartlett's test for hver faktor 
% (Der blev kun bedt om en undersøgelse med plots, så dette er udenfor 
% forventningerne til opgavens besvarelse). 
vartestn(y, bremse)
vartestn(y, koerer)
vartestn(y, daek)
% For hver test er p-værdien over 5%, så vi kan ikke forkaste nulhypotesen,
% som siger, at variansen er ens. Vi kan således gå ud fra, at variansen er
% ens for alle faktorniveauer, som vi har antaget. De visuelle forskelle
% fra plots er ikke store nok til at være signifikante. 
