%% M4STI1 2018F Opgave 2: Bølgemaskinens effekt afhængig af bølgerne
clc; clear; close all; format compact; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2018F.xlsx','E:G')

Laengde = D(:,1)    % Bølgelængde 
Hoejde = D(:,2)     % Bølgehøjde
Effekt = D(:,3)     % Produceret effekt
n = size(D,1)       % Antal observationer i datasættet


%% a: Plots for de uafhængige variable
figure(1)
scatter(Laengde,Effekt)
lsline                      % Regressionslinje
title('Bølgemaskinens effekt som funktion af bølgelængde')
xlabel('Bølgelængde (m)')
ylabel('Produceret effekt (kW)')
% Figur 1 viser, at med stigende bølgelængde er der faldende effekt, altså
% en negativ korrelation. Det er forventeligt, for når bølgelængden er høj, 
% kommer der færre bølger per tidsenhed, der kan udnyttes energi af. 
% Der er stor variation i data som følge af, at bølgehøjden tilsyneladende 
% også har stor indvirkning på den producerede effekt. 

figure(2)
scatter(Hoejde, Effekt)
lsline                      % Regressionslinje
title('Bølgemaskinens effekt som funktion af bølgehøjde')
xlabel('Bølgehøjde (m)')
ylabel('Produceret effekt (kW)')
% Der er en positiv korrelation, så bølgemaskinen kan producere højere
% effekt, desto højere bølgerne er. Der lader til at være en stærkere
% virkning af bølgehøjde end af længde, og der er mindre variation i data
% for dette plot. 


%% b: Multipel lineær regression
mdl = fitlm([Laengde Hoejde], Effekt, ...
    'ResponseVar', 'Effekt', ...
    'PredictorVars', {'Laengde', 'Hoejde'})

% Regressionsligning:
%   Effekt = 51.19 - 24.737*Laengde + 19.606*Hoejde


%% c: Fortolkning af regressionsanalysen
% Det er en ganske god model. Alle koefficienterne er signifikant
% forskellige fra 0 på 95 % signifikansniveau, da p-værdierne er tæt på 0 
% (under 0.05). I ANOVA testen er F=17.9, som giver en p-værdi på 0.000732.
% Det er altså meget usandsynlig at hverken bølgelængde eller højde har en 
% effekt på den producerede effekt. Desuden er R-squared 0.799
% og Adjusted R-squared er 0.754, så modellen forklarer en pæn del af
% variationen. Men der er plads til forbedringer. 


%% d: Unormale punkter
lev = mdl.Diagnostics.Leverage;     % hat diagonal
rst = mdl.Residuals.Studentized;    % R-Student
nr = (1:n)';
resultat = [nr, Laengde, Hoejde, Effekt, lev, rst]            % Jeg samler det hele til en resultattabel

k = 2;                  % Der er to regressorer
lev_limit = 2*(k+1)/n   % lev_limit = 0.5
% Der er ingen løftestangspunkter, da alle værdier for lev er under 
% lev_limit på 0.5. Dog er punkt nr. 10 med Laengde = 3.0 og Hoejde = 1.0 
% tæt på, da lev = 0.4708. 
% Der er en enkelt outlier, for punkt nr. 3 med Laengde = 1.0 og 
% Hoejde = 3.0 har |rst| = 3.1069, som er over grænsen på 3. 
% Der er ingen indflydelsespunkter, for det kræver at samme punkt er både
% løftestangspunkt og outlier. 


%% e: Er sammenhængen lineær for fast bølgelængde L = 2.0?
% Datasættet reduceres til de 6 observationer med Laengde = 2.0:
Hoejde = Hoejde(4:9,:)
Effekt = Effekt(4:9,:)

figure(3)
scatter(Hoejde, Effekt)
lsline
title('Effekt som funktion af bølgehøjde, hvor bølgelængden er 2.0 m')
xlabel('Bølgehøjde (m)')
ylabel('Produceret effekt (kW)')
% Plottet viser en sammenhæng, der måske bedre kan beskrives som S-formet
% end som lineær. Der lader til at skulle en vis bølgehøjde til for at
% danne energi, og når bølgelængden bliver tilstrækkelig stor klinger den
% producerede effekt af.

% Jeg tester med en simpel lineær regression: 
mdl2 = fitlm(Hoejde, Effekt)
% Det er en god model, hvor hældingskoefficienten b1=20.286 er signifikant
% (pValue = 0.00069657). R-Squared og Adjusted R-Squared er over 0.9 (hhv.
% 0.957 og 0.947), så modellen forklarer en stor andel af variationen. 
% Men på plottet ser punkterne ud til at følge et S-formet forløb.


%% f: Transformation af bølgehøjden 
k = 2.5
Hoejde_l = 1./(1 + exp(k - Hoejde))
mdl3 = fitlm(Hoejde_l, Effekt)
plot(mdl3)


%% g: Effekt som funktion af bølgehøjde
% Regressionsligning:
% Effekt = -9.1154 + 122.39*Hoejde_l 
% Effekt = -9.1154 + 122.39*1/(1 + exp(k - Hoejde)) 
Hoejde_0 = 4.7
Effekt_0 = -9.1154 + 122.39*1/(1+exp(k - Hoejde_0))
% Den forventede effekt af bølger på 4.7 m er 101.0661 kW = 101 kW

