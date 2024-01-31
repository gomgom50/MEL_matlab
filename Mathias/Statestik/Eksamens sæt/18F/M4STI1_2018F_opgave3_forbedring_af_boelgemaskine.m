%% M4STI1 2018F Opgave 3: Forbedring af en b�lgemaskine
clc; clear; close all; format compact; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2018F.xlsx','I:J') 

% F�rste kolonne af D indeholder information om, om m�lingen er fra den 
% oprindelige model (1) eller den forbedrede model (2)
% Anden kolonne indeholder m�linger af energiproduktionen

n_o = 11  % Antal m�linger p� oprindelig model
n_f = 13  % Antal m�linger p� forbedret model

G = D(:,1)  % Gruppe (oprindelig eller forbedret model)
E = D(:,2)  % Energiproduktion

E_o = E(1:n_o)          % Energiproduktion m�lt p� oprindelig model (o)
E_f = E(n_o+1:n_o+n_f)  % Energiproduktion m�lt p� forbedret model (f)



%% a: Boksplot
figure(1)
boxplot(E, G, 'labels', {'Oprindelig', 'Forbedret'})
title('Energiproduktion af oprindelig og forbedret b�lgemaskine');
xlabel('Model');
ylabel('Energi (kW)');

% Boksplottet viser at energiproduktionen for den forbedrede model generelt
% ligger h�jere. B�de median, interkvartil range og koste ligger h�jere for  
% den forbedrede model. De to bokse ser ensartede ud, s� variationen lader  
% til at v�re af samme st�rrelsesorden. Der ser ikke ud til at v�re outliers.


%% b: Hypoteser
alfa = 0.05   % Signifikansniveau
delta = 0     % Vi unders�ger om der er forskel p� stikpr�vernes populations-
              % middelv�rdier, alts� om forskellen er p� delta = 0

% Hypoteser. 
% H0: mu_o - mu_f = delta
% Ha: mu_o - mu_f < delta (N.B. Ensidig test, da vi formoder, at modellen er blevet forbedret)


%% c: Teststatistik 
% Vi laver en t-test for to uafh�ngige stikpr�ver med ukendt populationsvarians
% t0 = (y_o_streg - y_f_streg - delta)/(s_pooled*sqrt(1/n_o + 1/n_f))

y_o_streg = mean(E_o)   % Stikpr�vemiddelv�rdi for oprindelig model
y_f_streg = mean(E_f)   % Stikpr�vemiddelv�rdi for forbedret model
s_o = std(E_o)          % Stikpr�vestandardafvigelse for oprindelig model
s_f = std(E_f)          % Stikpr�vestandardafvigelse for forbedret model

df = n_o + n_f - 2     % Frihedsgrader, df = 22
% s_pooled er den puljede stikpr�vespredning, hvor de to stikpr�vers
% spredning er v�gtet sammen efter antal observationer:
s_pooled = sqrt(((n_o - 1)*s_o^2 + (n_f - 1)*s_f^2)/df)   % s_pooled = 9.1198
t0 = (y_o_streg - y_f_streg - delta)/(s_pooled*sqrt(1/n_o + 1/n_f))

% Teststatistikken er t-fordelt med df = n_o + n_f - 2 = 22 frihedsgrader
% V�rdien er beregnet til t0 = -2.7028


%% d: Kritisk region og konklusion
% Skridt 3. Kritisk region
% Vi har en ensidig test nedadtil, hvor vi afviser nulhypotesen, hvis 
% t0 < t_alfa, hvor
% t_alfa = tinv(alfa,df)

t_alfa = tinv(alfa,df)

% t0 = -2.7028 og t_alfa = -1.7171. Da teststatistikken t0 er mindre end den
% kritiske v�rdi t_alfa afviser vi nulhypotesen. 
% Det er alts� lykkedes de studerende at f� den nye model til at producere 
% mere energi end den oprindelige. 

pvalue = tcdf(t0, df)
% Det bekr�ftes ogs� af p-value = 0.0065, som er mindre end signifikans-
% niveauet alfa = 0.05

[h,p,ci,stats] = ttest2(E_o, E_f, 'Alpha',alfa, 'Tail','left')
% Vi kan f� bekr�ftet resultaterne med MatLab funktionen ttest2


%% e: 95% konfidensinterval
KI_span = tinv(1-alfa/2,df)*s_pooled*sqrt(1/n_o + 1/n_f)
KI_lav  = y_o_streg - y_f_streg - KI_span
KI_hoej = y_o_streg - y_f_streg + KI_span
% Forskellen i middel energiproduktion er med 95% sikkerhed i 
% konfidensintervallet [-17.8462; -2.3496]


%% f: Diskussion af boksplot, hypotesetest og konfidensinterval
% Boksplot, hypotesetest og konfidensinterval giver det samme billede:
% Som n�vnt under a) viser boksplottet, at der generelt er h�jere 
% energiproduktion for den forbedrede b�lgemaskine-model. Medianen ligger 
% h�jere. 
% Hypotesetesten viser, at der er signifikant forskel p� middelv�rdierne, 
% s� den forbedrede model faktisk er en forbedring. 
% 95% konfidenstintervallet for forskellen af middelv�rdier indeholder
% ikke 0, s� det underst�tter, at middelv�rdien er st�rst for den
% forbedrede model.


%% g: Antagelser
% Vi har antaget den centrale gr�nsev�rdis�tning for hver stikpr�ve.
% Desuden har vi antaget at de to stikpr�ver har samme varians.
% Vi kan teste den centrale gr�nsev�rdis�tning med stem-and-leaf plots og
% med normalfordelingsplots: 
stemleafplot(E_o)
stemleafplot(E_f)

figure(2)
normplot(E_o)
title('Normalfordelingsplot for oprindelig b�lgemaskine')

figure(3)
normplot(E_f)
title('Normalfordelingsplot for forbedret b�lgemaskine')

% Begge stem-and-leaf plots viser 'p�ne' fordelinger med et enkelt
% toppunkt, nogenlunde symmetrisk fordeling og hurtigt udd�ende haler.
% Normalfordelingsplots viser ogs�, at fordelingerne for stikpr�verne
% ligner normalfordelingen. Dog er data for den oprindelige b�lgemaskine
% ikke helt s� overbevisende som for den forbedrede. 
% De p�ne fordelinger kombineret med rimeligt store stikpr�vest�rrelser
% g�r, at vi kan v�re trygge ved, at antagelsen om den centrale
% gr�nsev�rdis�tning holder. 

% Antagelsen om at de to stikpr�ver har samme varians underbygges af det
% parallelle boksplot, der viser to ensartede bokse. Vi har desuden
% beregnet stikpr�ve-standardafvigelserne til v�rdier i samme
% st�rrelsesorden, nemlig hhv. 9.76 og 8.55



