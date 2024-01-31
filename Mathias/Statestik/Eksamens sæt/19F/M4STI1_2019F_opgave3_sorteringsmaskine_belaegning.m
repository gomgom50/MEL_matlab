%% M4STI1 2019F Opgave 3: Sorteringseffektivitet med forskellige bel�gninger
clc; clear; close all; format compact; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2019F.xlsx','E:F')
effekt_opr = D(:,1)     % Sorteringseffekt med oprindelig bel�gning
effekt_ny = D(:,2)      % Sorteringseffekt med ny bel�gning
n = size(D,1)           % Antal sorteringer, dvs. stikpr�vest�rrelse


%% a: Gennemsnit, varians, standardafvigelse
y_streg_opr = mean(effekt_opr)  % 80.6875
y_streg_ny = mean(effekt_ny)    % 80.3958
s2_opr = var(effekt_opr)        % 31.8811
s2_ny = var(effekt_ny)          % 6.6048
s_opr = std(effekt_opr)         % 5.6463
s_ny = std(effekt_ny)           % 2.5700


%% b: Konfidensinterval
alfa = 0.05
df = n - 1
t_alfahalve = -tinv(alfa/2, df)
% alternativt: t_alfahalve = tinv(1 - alfa/2, df)


% 95% konfidensinterval for oprindelig bel�gning:
KI_bredde_opr = t_alfahalve*s_opr/sqrt(n)
KI_min_opr = y_streg_opr - KI_bredde_opr
KI_max_opr = y_streg_opr + KI_bredde_opr
% 95% konfidensinterval for oprindelig bel�gning: [78.3033; 83.0717]

% 95% konfidensinterval for ny bel�gning:
KI_bredde_ny = t_alfahalve*s_ny/sqrt(n)
KI_min_ny = y_streg_ny - KI_bredde_ny
KI_max_ny = y_streg_ny + KI_bredde_ny
% 95% konfidensinterval for ny bel�gning: [79.3106; 81.4810]


%% c: Parallelt boksplot
boxplot(D, 'Labels', {'Oprindelig', 'Ny'})
title('Sorteringseffektivitet for oprindelig og ny bel�gning')
ylabel('Sorteringseffektivitet (%)')
xlabel('Bel�gning')

% Forskelle p� oprindelig og ny bel�gning: 
% I a. s� vi at middelv�rdierne er sammenlignelige for de to stikpr�ver
% (hhv. 80.7 og 80.4), men der lader til at v�re forskel p�
% standardafvigelserne (hhv. 5.6 og 2.6) og dermed p� varianserne. 
% I b. s� vi samme billede, at 95 % konfidensintervallet for oprindelig
% bel�gning var bredere end for ny (hhv. [78.3; 83.1] og 79.3; 81.5]).
% I c. viser det parallelle boksplot at medianerne er p� samme niveau, men
% de interkvartile ranges og kostene er st�rre for den oprindelige bel�gning. 
% Alt i alt lader den nye bel�gning til at have gjort sorteringen mere 
% ensartet og dermed mere uafh�ngig af fordelingen af h�rdt og bl�dt
% plastik i kasserne. Det lader til at problemet med at sortere fladt, 
% h�rdt plastik er blevet l�st. 


%% d: Hypotesetest for varianser af to stikpr�ver
% Hypoteser:
% H_0: sigma2_opr = sigma2_ny
% H_a: sigma2_opr <> sigma2_ny
% hvor sigma2_opr og sigma2_ny er populationsvariansen for sorterings-
% effektivitet af h�rdt plastik med hhv. oprindelig og ny bel�gning


%% e: Formel for testst�rrelsen og dens fordeling
% F_0 = s2_opr/s2_ny
% hvor s2_opr og s2_ny er stikpr�vevarianserne for sorteringseffektiviteten 
% med hhv. oprindelig og ny bel�gning.
% Testst�rrelsen er F-fordelt med n-1 frihedsgrader i b�de t�ller og
% n�vner (da vi har samme stikpr�vest�rrelse i de to stikpr�ver, nemlig 
% n = 24). 


%% f: Kritisk region, testst�rrelsens v�rdi og konklusion
% Det er en to-sidet test (vi tester blot, om der er forskel p�
% varianserne), s� nulhypotesen forkastes, hvis testst�rrelsen er under 
% F_alfahalve_nedre eller over F_alfahalve_oevre, som beregnes s�dan: 

alfa = 0.05
F_alfahalve_nedre = finv(alfa/2, n-1, n-1)      % 0.4326
F_alfahalve_oevre = finv(1-alfa/2, n-1, n-1)    % 2.3116

% Testst�rrelsens v�rdi:
F_0 = s2_opr/s2_ny       % 4.8270

% Konklusion: 
% Da F_0 > F_alfahalve_oevre forkastes nulhypotesen. 
% Med andre ord viser stikpr�verne, at der p� 5 % signifikansniveau er
% forskel p� variansen af sorteringseffektiviteten med de to bel�gninger. 

% Da testst�rrelsen beregnes som forholdet mellem stikpr�vernes varians 
% kunne den lige s� godt beregnes s�dan:  
F_0 = s2_ny/s2_opr       % 0.2072
% I s� fald forkastes nulhypotesen ligeledes, da F_0 < F_alfahalve_nedre


%% g: Antagelser
% Hypotesetesten for varianser bygger p� antagelsen, at observationerne i 
% de to stikpr�ver begge er normalfordelte. Det er en st�rkere antagelse 
% end den Centrale Gr�nsev�rdis�tning, hvor det blot antages, at data kommer
% fra en 'p�n' fordelingen, med mindre stikpr�vest�rrelsen er stor. 
% Vi kan teste antagelsen med normalfordelingsplot:

figure(1)
normplot(effekt_opr)
title('Normalfordelingsplot, oprindelig bel�gning')

figure(2)
normplot(effekt_ny)
title('Normalfordelingsplot, ny bel�gning')

% Begge normalfordelingsplots er nogenlunde line�re, s� det lader til, at 
% antagelsen holder. 


