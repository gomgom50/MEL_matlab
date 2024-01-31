%% Opgave 1 (Hypotesetest af katapults�der)
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
% Vi kender ikke populations-spredningen, s� vi estimerer den med 
% stikpr�vespredningen s, som vi beregner fra stikpr�ven. 
% Derfor er teststatistikken t:
% t = (y_streg - mu0)/(s/sqrt(n))
% hvor y_streg er stikpr�ve-middelv�rdi og n er stikpr�vest�rrelsen.
% Teststatistikken er t-fordelt med n-1 frihedsgrader.


%% c
% Skridt 3: Kritisk region
% Der �nskes 5% signifikansniveau:
alpha = 0.05
% Vi ved at der testes p� n=10 affyringer af katapults�det:
n=10
% Kritisk gr�nse t0 for en to-sidet hypotesetest
t0 = tinv(1-alpha/2, n-1)
% Vi forkaster nulhypotesen, hvis t < -t0 eller hvis t > t0, med andre ord,
% hvis |t| > t0

% Skridt 4: Beregn teststatistikken
% Nu kan vi indl�se data og beregne teststatistikken
y = xlsread('Data_M4STI1_2016F_reeksamen.xlsx','A:A')

% Beregning af stikpr�vens middelv�rdi og spredning:
y_streg = mean(y)
sumy2 = sum(y .* y)
s2 = (n*sumy2 - (sum(y))^2)/(n*(n-1))
s = sqrt(s2)
% Teststatistikken
t = (y_streg - mu0)/(s/sqrt(n))

% Skridt 5: Konkluder
% Teststatistikken t = 3.0616 er st�rre end den �vre kritiske gr�nse,
% t0 = 2.2622, s� vi forkaster H0 p� baggrund af stikpr�ven.
% Katapult-systemet uds�tter ikke piloterne for en p�virkning p� 14.0 G, og
% ud fra stikpr�ven lader det til, at det uds�tter dem for en h�jere
% p�virkning. 

% p-v�rdi som alternativ til kritisk region:
pValue = 2*(1 - tcdf(t, n-1))
% P-v�rdien er sandsynligheden for at observere det, vi har, eller noget
% mere ekstremt, givet at H0 er sand. Da vi har tosidet test skal vi gange
% med 2, da 'mere ekstremt' b�de kan v�re over og under middelv�rdien. 
% p-v�rdien er 0.0135, s� vi forkaster H0, da den er under alpha = 0.05.


%% d
% Antagelser
% Vi har antaget den centrale gr�nsev�rdis�tning. Det er som konsekvens af 
% den, at teststatistikken f�lger t-fordelingen hvis n er tilstr�kkelig stor. 
% Hvor stor n beh�ver at v�re afh�nger af, hvor p�n fordelingen, som 
% stikpr�ven kommer fra, er. 

stemleafplot(y,-1)
% Stem-and-leaf plottet tyder p�, at data kommer fra en p�n fordeling med et
% enkelt toppunkt, nogenlunde symmetrisk og med hurtigt udd�ende haler. Der
% er dog kun tre stammer, s� jeg pr�ver et histogram: 

figure(1)
histogram(y, 5)
% Det kunne godt opfattes som en sk�v fordeling, men det er sikkert kun fordi,
% der er s� f� observationer (10). 

figure(2)
normplot(y)
% Normalfordelingsplottet viser en nogenlunde line�r sammenh�ng, s� vi 
% er tilfredse. Stikpr�vens fordeling ligner normalfordelingen, s� det  
% lader til at modelantagelserne holder. 



%% e
% 95 pct. konfidensinterval
t_alphahalf = -tinv(alpha/2, n-1)
CI_width = t_alphahalf*s/sqrt(n)

CI_low = y_streg - CI_width
CI_high = y_streg + CI_width
% Vi er 95% sikre p�, at den sande middelv�rdi for G-p�virkningen af 
% katapultsystemet ligger mellem 14.12 og 14.82. Bem�rk at 14.0 ligger
% udenfor dette konfidensinterval.
