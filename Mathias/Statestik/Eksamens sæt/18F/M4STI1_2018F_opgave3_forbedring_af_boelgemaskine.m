%% M4STI1 2018F Opgave 3: Forbedring af en bølgemaskine
clc; clear; close all; format compact; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2018F.xlsx','I:J') 

% Første kolonne af D indeholder information om, om målingen er fra den 
% oprindelige model (1) eller den forbedrede model (2)
% Anden kolonne indeholder målinger af energiproduktionen

n_o = 11  % Antal målinger på oprindelig model
n_f = 13  % Antal målinger på forbedret model

G = D(:,1)  % Gruppe (oprindelig eller forbedret model)
E = D(:,2)  % Energiproduktion

E_o = E(1:n_o)          % Energiproduktion målt på oprindelig model (o)
E_f = E(n_o+1:n_o+n_f)  % Energiproduktion målt på forbedret model (f)



%% a: Boksplot
figure(1)
boxplot(E, G, 'labels', {'Oprindelig', 'Forbedret'})
title('Energiproduktion af oprindelig og forbedret bølgemaskine');
xlabel('Model');
ylabel('Energi (kW)');

% Boksplottet viser at energiproduktionen for den forbedrede model generelt
% ligger højere. Både median, interkvartil range og koste ligger højere for  
% den forbedrede model. De to bokse ser ensartede ud, så variationen lader  
% til at være af samme størrelsesorden. Der ser ikke ud til at være outliers.


%% b: Hypoteser
alfa = 0.05   % Signifikansniveau
delta = 0     % Vi undersøger om der er forskel på stikprøvernes populations-
              % middelværdier, altså om forskellen er på delta = 0

% Hypoteser. 
% H0: mu_o - mu_f = delta
% Ha: mu_o - mu_f < delta (N.B. Ensidig test, da vi formoder, at modellen er blevet forbedret)


%% c: Teststatistik 
% Vi laver en t-test for to uafhængige stikprøver med ukendt populationsvarians
% t0 = (y_o_streg - y_f_streg - delta)/(s_pooled*sqrt(1/n_o + 1/n_f))

y_o_streg = mean(E_o)   % Stikprøvemiddelværdi for oprindelig model
y_f_streg = mean(E_f)   % Stikprøvemiddelværdi for forbedret model
s_o = std(E_o)          % Stikprøvestandardafvigelse for oprindelig model
s_f = std(E_f)          % Stikprøvestandardafvigelse for forbedret model

df = n_o + n_f - 2     % Frihedsgrader, df = 22
% s_pooled er den puljede stikprøvespredning, hvor de to stikprøvers
% spredning er vægtet sammen efter antal observationer:
s_pooled = sqrt(((n_o - 1)*s_o^2 + (n_f - 1)*s_f^2)/df)   % s_pooled = 9.1198
t0 = (y_o_streg - y_f_streg - delta)/(s_pooled*sqrt(1/n_o + 1/n_f))

% Teststatistikken er t-fordelt med df = n_o + n_f - 2 = 22 frihedsgrader
% Værdien er beregnet til t0 = -2.7028


%% d: Kritisk region og konklusion
% Skridt 3. Kritisk region
% Vi har en ensidig test nedadtil, hvor vi afviser nulhypotesen, hvis 
% t0 < t_alfa, hvor
% t_alfa = tinv(alfa,df)

t_alfa = tinv(alfa,df)

% t0 = -2.7028 og t_alfa = -1.7171. Da teststatistikken t0 er mindre end den
% kritiske værdi t_alfa afviser vi nulhypotesen. 
% Det er altså lykkedes de studerende at få den nye model til at producere 
% mere energi end den oprindelige. 

pvalue = tcdf(t0, df)
% Det bekræftes også af p-value = 0.0065, som er mindre end signifikans-
% niveauet alfa = 0.05

[h,p,ci,stats] = ttest2(E_o, E_f, 'Alpha',alfa, 'Tail','left')
% Vi kan få bekræftet resultaterne med MatLab funktionen ttest2


%% e: 95% konfidensinterval
KI_span = tinv(1-alfa/2,df)*s_pooled*sqrt(1/n_o + 1/n_f)
KI_lav  = y_o_streg - y_f_streg - KI_span
KI_hoej = y_o_streg - y_f_streg + KI_span
% Forskellen i middel energiproduktion er med 95% sikkerhed i 
% konfidensintervallet [-17.8462; -2.3496]


%% f: Diskussion af boksplot, hypotesetest og konfidensinterval
% Boksplot, hypotesetest og konfidensinterval giver det samme billede:
% Som nævnt under a) viser boksplottet, at der generelt er højere 
% energiproduktion for den forbedrede bølgemaskine-model. Medianen ligger 
% højere. 
% Hypotesetesten viser, at der er signifikant forskel på middelværdierne, 
% så den forbedrede model faktisk er en forbedring. 
% 95% konfidenstintervallet for forskellen af middelværdier indeholder
% ikke 0, så det understøtter, at middelværdien er størst for den
% forbedrede model.


%% g: Antagelser
% Vi har antaget den centrale grænseværdisætning for hver stikprøve.
% Desuden har vi antaget at de to stikprøver har samme varians.
% Vi kan teste den centrale grænseværdisætning med stem-and-leaf plots og
% med normalfordelingsplots: 
stemleafplot(E_o)
stemleafplot(E_f)

figure(2)
normplot(E_o)
title('Normalfordelingsplot for oprindelig bølgemaskine')

figure(3)
normplot(E_f)
title('Normalfordelingsplot for forbedret bølgemaskine')

% Begge stem-and-leaf plots viser 'pæne' fordelinger med et enkelt
% toppunkt, nogenlunde symmetrisk fordeling og hurtigt uddøende haler.
% Normalfordelingsplots viser også, at fordelingerne for stikprøverne
% ligner normalfordelingen. Dog er data for den oprindelige bølgemaskine
% ikke helt så overbevisende som for den forbedrede. 
% De pæne fordelinger kombineret med rimeligt store stikprøvestørrelser
% gør, at vi kan være trygge ved, at antagelsen om den centrale
% grænseværdisætning holder. 

% Antagelsen om at de to stikprøver har samme varians underbygges af det
% parallelle boksplot, der viser to ensartede bokse. Vi har desuden
% beregnet stikprøve-standardafvigelserne til værdier i samme
% størrelsesorden, nemlig hhv. 9.76 og 8.55



