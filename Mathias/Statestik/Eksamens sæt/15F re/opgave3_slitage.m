%% Opgave 3 (Slitage)

clc; clear all; close all;

% Baggrundsdata
M = xlsread('Data_M4STI1_2015F_reeksamen.xlsx','E:F') 

Materiale = M(:,1)      % Materialenummer
Slitage = M(:,2)        % Slitageindeks

n_A = 12                            % Antal m�linger af A
n_B = 10                            % Antal m�linger af B
SlitageA = Slitage(1:n_A)           % Slitagedata for A
SlitageB = Slitage(n_A+1:n_A+n_B)   % Slitagedata for B

y_A_streg = mean(SlitageA)          % Stikpr�vemiddelv�rdi for A
y_B_streg = mean(SlitageB)          % Stikpr�vemiddelv�rdi for B
s_A = std(SlitageA)                 % Stikpr�vespredning for A
s_B = std(SlitageB)                 % Stikpr�vespredning for B



%% a 
figure(1)
boxplot(Slitage, Materiale, 'labels', {'A', 'B'})
title('Boksplot over slidstyrke af materiale A og B');
xlabel('Materiale');
ylabel('Slitage');

% Boksplottet viser at A's interkvartile range for  ligger over B's. B's
% koste er en anelse l�ngere end A's, men ellers er de to diagrammer meget
% sammenlignelige i st�rrelse, bortset fra at A's ligger h�jere. Der lader
% ikke til at v�re nogle outliers. 

%% b
alpha = 0.05                        % Signifikansniveau
delta = 2                           % Formodet forskel i middelv�rdier
% Hypoteser. 
% H0: mu_A - mu_B = 2
% Ha: mu_A - mu_B > 2 (N.B. Ensidig test, da udgangspunktet er at B er mere
% slidst�rk end A)


%% c 
% Teststatistik
% t = (y_A_streg - y_B_streg - delta)/(s_pooled*sqrt(1/n_A + 1/n_B))

df = n_A + n_B - 2                  % Frihedsgrader i pooled spredning
% s_pooled er den puljede stikpr�vespredning, hvor de to stikpr�vers
% spredning er v�gtet sammen efter antal observationer:
s_pooled = sqrt(((n_A - 1)*s_A^2 + (n_B - 1)*s_B^2)/df)

t = (y_A_streg - y_B_streg - delta)/(s_pooled*sqrt(1/n_A + 1/n_B))

% Teststatistikken er t-fordelt med n_A + n_B - 2 frihedsgrader
% V�rdien er beregnet til t = 1.4450


%% d
% Skridt 3. Kritisk region
% Vi har en ensidig test, hvor vi afviser nulhypotesen, hvis t > t0, hvor
% t0 = tinv(1-alpha,df)

t0 = tinv(1-alpha,df)

% t = 1.4450 og t0 = 1.7247. Da t ikke er st�rre end t0 kan vi ikke afvise
% nulhypotesen. Forskellen p� slidstyrken er alts� ikke 2 eller mere.  
pvalue = 1 - tcdf(t, df)

% Det bekr�ftes ogs� af p-value=0.0820, som er st�rre end 0.05

%% e
% Ny hypotesetest med delta = 0 i stedet for delta = 2
% Ny H0: mu_A - mu_B = 0
% Ny Ha: mu_A - mu_B <> 0
% Alts� en tosidig test. Vi genberegner t:
delta = 0
t = (y_A_streg - y_B_streg - delta)/(s_pooled*sqrt(1/n_A + 1/n_B))

% Vi genberegner t0
t0 = -tinv(alpha/2,df)

pvalue = 1 - tcdf(t, df)

% t = 2.4772 er st�rre end t0 = 2.0860, s� slitagen p� A er signifikant 
% forskellig fra B p� 5% signifikansnieveau. P-v�rdien er 0.0111


%% f
CIspan = tinv(1-alpha/2,df)*s_pooled*sqrt(1/n_A + 1/n_B)
CIlow  = y_A_streg - y_B_streg - CIspan
CIhigh = y_A_streg - y_B_streg + CIspan
% Forskellen er med 95% sikkerhed i konfidensintervallet [0.7580; 8.8420]


%% g
% Boksplottet viser at der generelt er mere slitage p� A end B, men det er
% ikke et klart billede. Interkvartilet for B ligger under A, men n�r
% kostene medtages er der stort overlap
% Hypotesetesten viser, at der er forskel p� middelv�rdierne, 
% men forskellen er ikke over 2, som antaget. 
% 95 % konfidenstintervallet for forskellen af middelv�rdier indeholder
% ikke 0, s� det underbygger, at forskellen er st�rre end 0

%% h 
stemleafplot(SlitageA)
stemleafplot(SlitageB)

figure(2)
normplot(SlitageA)
title('Normalfordelingsplot materiale A')

figure(3)
normplot(SlitageB)
title('Normalfordelingsplot materiale B')


% Antagelser
% 1. Data er fra en 'p�n' fordeling, der ligner normalfordelingen
% 2. Data fra samme fordeling, hvor kun middelv�rdien er forskellig
% 3. M�lingerne er uafh�ngige

% Er antagelserne rimelige? 
% 1. B�de if�lge stem-and-leaf plots og normalfordelingsplots ser 
%    fordelingerne nogenlunde p�ne ud
% 2. Boxplottet viser nogenlunde lige brede interkvartiler
% 3. Vi har ingen grund til at tro at een m�ling p� maskinen kan p�virke den
%    n�ste. 

