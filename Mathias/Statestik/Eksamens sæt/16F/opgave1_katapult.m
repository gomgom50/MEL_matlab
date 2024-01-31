%% Opgave 1 (Hypotesetest af katapultsæder)
close all; clear; clc; 


%% a Hypotesetest med 5 skridt
%  skridt 1: Opstil hypoteser
mu0 = 14.0
%  H0:  my = mu0
%  Ha:  my <> mu0
% Det er en to-sidet hypotesetest, da alternativhypotesen er, at my er 
% forskellig fra (enten > eller <) 14.0 G


%% b
% Skridt 2: Formuler teststatistikken
% Vi kender ikke populations-spredningen, så vi estimerer den med 
% stikprøvespredningen s, som vi beregner fra stikprøven. 
% Derfor er teststatistikken t:
% t = (y_streg - mu0)/(s/sqrt(n))
% hvor y_streg er stikprøve-middelværdi og n er stikprøvestørrelsen.
% Teststatistikken er t-fordelt med n-1 frihedsgrader.


%% c
% Skridt 3: Kritisk region
% Der ønskes 5% signifikansniveau:
alpha = 0.05
% Vi ved at der testes på n=10 affyringer af katapultsædet:
n=10
% Kritisk grænse t0 for en to-sidet hypotesetest
t0 = tinv(1-alpha/2, n-1)
% Vi forkaster nulhypotesen, hvis t < -t0 eller hvis t > t0, med andre ord,
% hvis |t| > t0

% Skridt 4: Beregn teststatistikken
% Nu kan vi indlæse data og beregne teststatistikken
y = xlsread('Data_M4STI1_2016F_reeksamen.xlsx','A:A')

% Beregning af stikprøvens middelværdi og spredning:
y_streg = mean(y)
sumy2 = sum(y .* y)
s2 = (n*sumy2 - (sum(y))^2)/(n*(n-1))
s = sqrt(s2)
% Teststatistikken
t = (y_streg - mu0)/(s/sqrt(n))

% Skridt 5: Konkluder
% Teststatistikken t = 3.0616 er større end den øvre kritiske grænse,
% t0 = 2.2622, så vi forkaster H0 på baggrund af stikprøven.
% Katapult-systemet udsætter ikke piloterne for en påvirkning på 14.0 G, og
% ud fra stikprøven lader det til, at det udsætter dem for en højere
% påvirkning. 

% p-værdi som alternativ til kritisk region:
pValue = 2*(1 - tcdf(t, n-1))
% P-værdien er sandsynligheden for at observere det, vi har, eller noget
% mere ekstremt, givet at H0 er sand. Da vi har tosidet test skal vi gange
% med 2, da 'mere ekstremt' både kan være over og under middelværdien. 
% p-værdien er 0.0135, så vi forkaster H0, da den er under alpha = 0.05.


%% d
% Antagelser
% Vi har antaget den centrale grænseværdisætning. Det er som konsekvens af 
% den, at teststatistikken følger t-fordelingen hvis n er tilstrækkelig stor. 
% Hvor stor n behøver at være afhænger af, hvor pæn fordelingen, som 
% stikprøven kommer fra, er. 

stemleafplot(y,-1)
% Stem-and-leaf plottet tyder på, at data kommer fra en pæn fordeling med et
% enkelt toppunkt, nogenlunde symmetrisk og med hurtigt uddøende haler. Der
% er dog kun tre stammer, så jeg prøver et histogram: 

figure(1)
histogram(y, 5)
% Det kunne godt opfattes som en skæv fordeling, men det er sikkert kun fordi,
% der er så få observationer (10). 

figure(2)
normplot(y)
% Normalfordelingsplottet viser en nogenlunde lineær sammenhæng, så vi 
% er tilfredse. Stikprøvens fordeling ligner normalfordelingen, så det  
% lader til at modelantagelserne holder. 



%% e
% 95 pct. konfidensinterval
t_alphahalf = -tinv(alpha/2, n-1)
CI_width = t_alphahalf*s/sqrt(n)

CI_low = y_streg - CI_width
CI_high = y_streg + CI_width
% Vi er 95% sikre på, at den sande middelværdi for G-påvirkningen af 
% katapultsystemet ligger mellem 14.12 og 14.82. Bemærk at 14.0 ligger
% udenfor dette konfidensinterval.
