Hej


%% M4STI1 2017E Opgave 3: Omgangstider med to bremsefarbrikater
clc; clear; close all; format compact; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2017E.xlsx','K:L')
brembo = D(:,1)
ci = D(:,2)
n = size(D,1) % Antal omgangstider per bremsefabrikat


%% a: Gennemsnit, varians, standardafvigelse
y_streg_brembo = mean(brembo)   % 92.7978
y_streg_ci = mean(ci)           % 92.9125
s2_brembo = var(brembo)         % 0.6726
s2_ci = var(ci)                 % 6.8375
s_brembo = std(brembo)          % 0.8201
s_ci = std(ci)                  % 2.6149


%% b: Konfidensinterval
alfa = 0.05
df = n - 1
t_alfahalve = tinv(alfa/2, df)
KI_bredde_brembo = -t_alfahalve*s_brembo/sqrt(n)
KI_min_brembo = y_streg_brembo - KI_bredde_brembo
KI_max_brembo = y_streg_brembo + KI_bredde_brembo
% 95% konfidensinterval for Brembo: [92.4140; 93.1817]

KI_bredde_ci = -t_alfahalve*s_ci/sqrt(n)
KI_min_ci = y_streg_ci - KI_bredde_ci
KI_max_ci = y_streg_ci + KI_bredde_ci
% 95% konfidensinterval for CI: [91.6888; 94.1363]

% Forskelle p� Brembo og CI: Der er ikke stor forskel p� de gennemsnitlige
% omgangstider med de to bremsefabrikater (hhv. 92.7978 og 92.9125), men
% der er ret stor forskel p� varianserne (hhv. 0.6726 og 6.8375). Dermed er
% der ogs� ret stor forskel p� standardadafvigelserne, da de er
% kvadratroden af varianserne. 
% Konfidensintervallet for CI er bredere end for Brembo, da bredden
% afh�nger af standardafvigelsen, som er mere end 3 gange s� stor for CI. 
% Omgangstiderne er s�ledes mere ensartede med Brembo end med CI i denne test. 


%% c: Hypotesetest for varianser af to stikpr�ver
% Hypoteser:
% H_0: sigma2_brembo = sigma2_ci
% H_a: sigma2_brembo <> sigma2_ci
% hvor sigma2_brembo og sigma2_ci er populationsvariansen for omgangstider 
% med hhv. Brembo og CI bremser


%% d: Formel for testst�rrelsen og dens fordeling
% F_0 = s2_brembo/s2_ci
% hvor s2_brembo og s2_ci er stikpr�vevarianserne for omgangstider med hhv. 
% Brembo og CI bremser.
% Testst�rrelsen er F-fordelt med n-1 frihedsgrader i b�de t�ller og
% n�vner (da vi har samme stikpr�vest�rrelse i de to stikpr�ver, nemlig 
% n = 20). 

% L�rebogen V&K anbefaler, at stikpr�ven med st�rst varians s�ttes i t�lleren,
% s� testst�rrelsen bliver st�rre end 1. Det skyldes, at bogens
% sandsynlighedstabel for F kun kan tage v�rdier over 1 for at spare plads.
% Det beh�ver vi ikke, da vi bruger MatLab, og her har jeg gjort det 
% omvendt, s� F_0 < 1


%% e: Kritisk region, testst�rrelsens v�rdi og konklusion
% Det er en to-sidet test (vi tester blot om der er forskel p�
% varianserne), s� nulhypotesen forkastes, hvis testst�rrelsen er under 
% F_alfahalve_nedre eller over F_alfahalve_oevre, som beregnes s�dan: 

F_alfahalve_nedre = finv(alfa/2, n-1, n-1)      % 0.3958
F_alfahalve_oevre = finv(1-alfa/2, n-1, n-1)    % 2.5265

% Testst�rrelsens v�rdi:
F_0 = s2_brembo/s2_ci       % 0.0984

% Konklusion: 
% Da F_0 < F_alfahalve_nedre forkastes nulhypotesen. 
% Med andre ord viser stikpr�verne, at der p� 5 % signifikansniveau er
% forskel p� variansen af omgangstiderne med de to bremsefabrikater. 


%% f: Antagelser
% Hypotesetesten for varianser bygger p� antagelsen, at observationerne af 
% omgangstider er normalfordelt. Det er alts� en st�rkere antagelse end
% f.eks. den Centrale Gr�nsev�rdis�tning, hvor det bare antages at
% fordelingen er 'p�n' eller stikpr�vest�rrelsen er stor. 
% Vi kan teste antagelsen med normalfordelingsplot:

figure(1)
normplot(brembo)
title('Normalfordelingsplot, Brembo')

figure(2)
normplot(ci)
title('Normalfordelingsplot, CI')

% Begge normalfordelingsplots er nogenlunde line�re, s� jeg mener at 
% antagelsen holder. 
