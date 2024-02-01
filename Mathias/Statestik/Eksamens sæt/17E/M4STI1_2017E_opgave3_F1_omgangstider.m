Hej


%% M4STI1 2017E Opgave 3: Omgangstider med to bremsefarbrikater
clc; clear; close all; format compact; 

%% Indlæs og behandl data
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

% Forskelle på Brembo og CI: Der er ikke stor forskel på de gennemsnitlige
% omgangstider med de to bremsefabrikater (hhv. 92.7978 og 92.9125), men
% der er ret stor forskel på varianserne (hhv. 0.6726 og 6.8375). Dermed er
% der også ret stor forskel på standardadafvigelserne, da de er
% kvadratroden af varianserne. 
% Konfidensintervallet for CI er bredere end for Brembo, da bredden
% afhænger af standardafvigelsen, som er mere end 3 gange så stor for CI. 
% Omgangstiderne er således mere ensartede med Brembo end med CI i denne test. 


%% c: Hypotesetest for varianser af to stikprøver
% Hypoteser:
% H_0: sigma2_brembo = sigma2_ci
% H_a: sigma2_brembo <> sigma2_ci
% hvor sigma2_brembo og sigma2_ci er populationsvariansen for omgangstider 
% med hhv. Brembo og CI bremser


%% d: Formel for teststørrelsen og dens fordeling
% F_0 = s2_brembo/s2_ci
% hvor s2_brembo og s2_ci er stikprøvevarianserne for omgangstider med hhv. 
% Brembo og CI bremser.
% Teststørrelsen er F-fordelt med n-1 frihedsgrader i både tæller og
% nævner (da vi har samme stikprøvestørrelse i de to stikprøver, nemlig 
% n = 20). 

% Lærebogen V&K anbefaler, at stikprøven med størst varians sættes i tælleren,
% så teststørrelsen bliver større end 1. Det skyldes, at bogens
% sandsynlighedstabel for F kun kan tage værdier over 1 for at spare plads.
% Det behøver vi ikke, da vi bruger MatLab, og her har jeg gjort det 
% omvendt, så F_0 < 1


%% e: Kritisk region, teststørrelsens værdi og konklusion
% Det er en to-sidet test (vi tester blot om der er forskel på
% varianserne), så nulhypotesen forkastes, hvis teststørrelsen er under 
% F_alfahalve_nedre eller over F_alfahalve_oevre, som beregnes sådan: 

F_alfahalve_nedre = finv(alfa/2, n-1, n-1)      % 0.3958
F_alfahalve_oevre = finv(1-alfa/2, n-1, n-1)    % 2.5265

% Teststørrelsens værdi:
F_0 = s2_brembo/s2_ci       % 0.0984

% Konklusion: 
% Da F_0 < F_alfahalve_nedre forkastes nulhypotesen. 
% Med andre ord viser stikprøverne, at der på 5 % signifikansniveau er
% forskel på variansen af omgangstiderne med de to bremsefabrikater. 


%% f: Antagelser
% Hypotesetesten for varianser bygger på antagelsen, at observationerne af 
% omgangstider er normalfordelt. Det er altså en stærkere antagelse end
% f.eks. den Centrale Grænseværdisætning, hvor det bare antages at
% fordelingen er 'pæn' eller stikprøvestørrelsen er stor. 
% Vi kan teste antagelsen med normalfordelingsplot:

figure(1)
normplot(brembo)
title('Normalfordelingsplot, Brembo')

figure(2)
normplot(ci)
title('Normalfordelingsplot, CI')

% Begge normalfordelingsplots er nogenlunde lineære, så jeg mener at 
% antagelsen holder. 
