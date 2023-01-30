%% M4STI1 2019F Opgave 3: Sorteringseffektivitet med forskellige belægninger
clc; clear; close all; format compact; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2019F.xlsx','E:F')
effekt_opr = D(:,1)     % Sorteringseffekt med oprindelig belægning
effekt_ny = D(:,2)      % Sorteringseffekt med ny belægning
n = size(D,1)           % Antal sorteringer, dvs. stikprøvestørrelse


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


% 95% konfidensinterval for oprindelig belægning:
KI_bredde_opr = t_alfahalve*s_opr/sqrt(n)
KI_min_opr = y_streg_opr - KI_bredde_opr
KI_max_opr = y_streg_opr + KI_bredde_opr
% 95% konfidensinterval for oprindelig belægning: [78.3033; 83.0717]

% 95% konfidensinterval for ny belægning:
KI_bredde_ny = t_alfahalve*s_ny/sqrt(n)
KI_min_ny = y_streg_ny - KI_bredde_ny
KI_max_ny = y_streg_ny + KI_bredde_ny
% 95% konfidensinterval for ny belægning: [79.3106; 81.4810]


%% c: Parallelt boksplot
boxplot(D, 'Labels', {'Oprindelig', 'Ny'})
title('Sorteringseffektivitet for oprindelig og ny belægning')
ylabel('Sorteringseffektivitet (%)')
xlabel('Belægning')

% Forskelle på oprindelig og ny belægning: 
% I a. så vi at middelværdierne er sammenlignelige for de to stikprøver
% (hhv. 80.7 og 80.4), men der lader til at være forskel på
% standardafvigelserne (hhv. 5.6 og 2.6) og dermed på varianserne. 
% I b. så vi samme billede, at 95 % konfidensintervallet for oprindelig
% belægning var bredere end for ny (hhv. [78.3; 83.1] og 79.3; 81.5]).
% I c. viser det parallelle boksplot at medianerne er på samme niveau, men
% de interkvartile ranges og kostene er større for den oprindelige belægning. 
% Alt i alt lader den nye belægning til at have gjort sorteringen mere 
% ensartet og dermed mere uafhængig af fordelingen af hårdt og blødt
% plastik i kasserne. Det lader til at problemet med at sortere fladt, 
% hårdt plastik er blevet løst. 


%% d: Hypotesetest for varianser af to stikprøver
% Hypoteser:
% H_0: sigma2_opr = sigma2_ny
% H_a: sigma2_opr <> sigma2_ny
% hvor sigma2_opr og sigma2_ny er populationsvariansen for sorterings-
% effektivitet af hårdt plastik med hhv. oprindelig og ny belægning


%% e: Formel for teststørrelsen og dens fordeling
% F_0 = s2_opr/s2_ny
% hvor s2_opr og s2_ny er stikprøvevarianserne for sorteringseffektiviteten 
% med hhv. oprindelig og ny belægning.
% Teststørrelsen er F-fordelt med n-1 frihedsgrader i både tæller og
% nævner (da vi har samme stikprøvestørrelse i de to stikprøver, nemlig 
% n = 24). 


%% f: Kritisk region, teststørrelsens værdi og konklusion
% Det er en to-sidet test (vi tester blot, om der er forskel på
% varianserne), så nulhypotesen forkastes, hvis teststørrelsen er under 
% F_alfahalve_nedre eller over F_alfahalve_oevre, som beregnes sådan: 

alfa = 0.05
F_alfahalve_nedre = finv(alfa/2, n-1, n-1)      % 0.4326
F_alfahalve_oevre = finv(1-alfa/2, n-1, n-1)    % 2.3116

% Teststørrelsens værdi:
F_0 = s2_opr/s2_ny       % 4.8270

% Konklusion: 
% Da F_0 > F_alfahalve_oevre forkastes nulhypotesen. 
% Med andre ord viser stikprøverne, at der på 5 % signifikansniveau er
% forskel på variansen af sorteringseffektiviteten med de to belægninger. 

% Da teststørrelsen beregnes som forholdet mellem stikprøvernes varians 
% kunne den lige så godt beregnes sådan:  
F_0 = s2_ny/s2_opr       % 0.2072
% I så fald forkastes nulhypotesen ligeledes, da F_0 < F_alfahalve_nedre


%% g: Antagelser
% Hypotesetesten for varianser bygger på antagelsen, at observationerne i 
% de to stikprøver begge er normalfordelte. Det er en stærkere antagelse 
% end den Centrale Grænseværdisætning, hvor det blot antages, at data kommer
% fra en 'pæn' fordelingen, med mindre stikprøvestørrelsen er stor. 
% Vi kan teste antagelsen med normalfordelingsplot:

figure(1)
normplot(effekt_opr)
title('Normalfordelingsplot, oprindelig belægning')

figure(2)
normplot(effekt_ny)
title('Normalfordelingsplot, ny belægning')

% Begge normalfordelingsplots er nogenlunde lineære, så det lader til, at 
% antagelsen holder. 


