%% Opgave 3 (Slitage)

clc; clear all; close all;

% Baggrundsdata
M = xlsread('Data_M4STI1_2015F_reeksamen.xlsx','E:F') 

Materiale = M(:,1)      % Materialenummer
Slitage = M(:,2)        % Slitageindeks

n_A = 12                            % Antal målinger af A
n_B = 10                            % Antal målinger af B
SlitageA = Slitage(1:n_A)           % Slitagedata for A
SlitageB = Slitage(n_A+1:n_A+n_B)   % Slitagedata for B

y_A_streg = mean(SlitageA)          % Stikprøvemiddelværdi for A
y_B_streg = mean(SlitageB)          % Stikprøvemiddelværdi for B
s_A = std(SlitageA)                 % Stikprøvespredning for A
s_B = std(SlitageB)                 % Stikprøvespredning for B



%% a 
figure(1)
boxplot(Slitage, Materiale, 'labels', {'A', 'B'})
title('Boksplot over slidstyrke af materiale A og B');
xlabel('Materiale');
ylabel('Slitage');

% Boksplottet viser at A's interkvartile range for  ligger over B's. B's
% koste er en anelse længere end A's, men ellers er de to diagrammer meget
% sammenlignelige i størrelse, bortset fra at A's ligger højere. Der lader
% ikke til at være nogle outliers. 

%% b
alpha = 0.05                        % Signifikansniveau
delta = 2                           % Formodet forskel i middelværdier
% Hypoteser. 
% H0: mu_A - mu_B = 2
% Ha: mu_A - mu_B > 2 (N.B. Ensidig test, da udgangspunktet er at B er mere
% slidstærk end A)


%% c 
% Teststatistik
% t = (y_A_streg - y_B_streg - delta)/(s_pooled*sqrt(1/n_A + 1/n_B))

df = n_A + n_B - 2                  % Frihedsgrader i pooled spredning
% s_pooled er den puljede stikprøvespredning, hvor de to stikprøvers
% spredning er vægtet sammen efter antal observationer:
s_pooled = sqrt(((n_A - 1)*s_A^2 + (n_B - 1)*s_B^2)/df)

t = (y_A_streg - y_B_streg - delta)/(s_pooled*sqrt(1/n_A + 1/n_B))

% Teststatistikken er t-fordelt med n_A + n_B - 2 frihedsgrader
% Værdien er beregnet til t = 1.4450


%% d
% Skridt 3. Kritisk region
% Vi har en ensidig test, hvor vi afviser nulhypotesen, hvis t > t0, hvor
% t0 = tinv(1-alpha,df)

t0 = tinv(1-alpha,df)

% t = 1.4450 og t0 = 1.7247. Da t ikke er større end t0 kan vi ikke afvise
% nulhypotesen. Forskellen på slidstyrken er altså ikke 2 eller mere.  
pvalue = 1 - tcdf(t, df)

% Det bekræftes også af p-value=0.0820, som er større end 0.05

%% e
% Ny hypotesetest med delta = 0 i stedet for delta = 2
% Ny H0: mu_A - mu_B = 0
% Ny Ha: mu_A - mu_B <> 0
% Altså en tosidig test. Vi genberegner t:
delta = 0
t = (y_A_streg - y_B_streg - delta)/(s_pooled*sqrt(1/n_A + 1/n_B))

% Vi genberegner t0
t0 = -tinv(alpha/2,df)

pvalue = 1 - tcdf(t, df)

% t = 2.4772 er større end t0 = 2.0860, så slitagen på A er signifikant 
% forskellig fra B på 5% signifikansnieveau. P-værdien er 0.0111


%% f
CIspan = tinv(1-alpha/2,df)*s_pooled*sqrt(1/n_A + 1/n_B)
CIlow  = y_A_streg - y_B_streg - CIspan
CIhigh = y_A_streg - y_B_streg + CIspan
% Forskellen er med 95% sikkerhed i konfidensintervallet [0.7580; 8.8420]


%% g
% Boksplottet viser at der generelt er mere slitage på A end B, men det er
% ikke et klart billede. Interkvartilet for B ligger under A, men når
% kostene medtages er der stort overlap
% Hypotesetesten viser, at der er forskel på middelværdierne, 
% men forskellen er ikke over 2, som antaget. 
% 95 % konfidenstintervallet for forskellen af middelværdier indeholder
% ikke 0, så det underbygger, at forskellen er større end 0

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
% 1. Data er fra en 'pæn' fordeling, der ligner normalfordelingen
% 2. Data fra samme fordeling, hvor kun middelværdien er forskellig
% 3. Målingerne er uafhængige

% Er antagelserne rimelige? 
% 1. Både ifølge stem-and-leaf plots og normalfordelingsplots ser 
%    fordelingerne nogenlunde pæne ud
% 2. Boxplottet viser nogenlunde lige brede interkvartiler
% 3. Vi har ingen grund til at tro at een måling på maskinen kan påvirke den
%    næste. 

