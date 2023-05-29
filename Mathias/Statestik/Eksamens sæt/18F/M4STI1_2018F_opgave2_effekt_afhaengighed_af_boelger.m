%% M4STI1 2018F Opgave 2: B�lgemaskinens effekt afh�ngig af b�lgerne
clc; clear; close all; format compact; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2018F.xlsx','E:G')

Laengde = D(:,1)    % B�lgel�ngde 
Hoejde = D(:,2)     % B�lgeh�jde
Effekt = D(:,3)     % Produceret effekt
n = size(D,1)       % Antal observationer i datas�ttet


%% a: Plots for de uafh�ngige variable
figure(1)
scatter(Laengde,Effekt)
lsline                      % Regressionslinje
title('B�lgemaskinens effekt som funktion af b�lgel�ngde')
xlabel('B�lgel�ngde (m)')
ylabel('Produceret effekt (kW)')
% Figur 1 viser, at med stigende b�lgel�ngde er der faldende effekt, alts�
% en negativ korrelation. Det er forventeligt, for n�r b�lgel�ngden er h�j, 
% kommer der f�rre b�lger per tidsenhed, der kan udnyttes energi af. 
% Der er stor variation i data som f�lge af, at b�lgeh�jden tilsyneladende 
% ogs� har stor indvirkning p� den producerede effekt. 

figure(2)
scatter(Hoejde, Effekt)
lsline                      % Regressionslinje
title('B�lgemaskinens effekt som funktion af b�lgeh�jde')
xlabel('B�lgeh�jde (m)')
ylabel('Produceret effekt (kW)')
% Der er en positiv korrelation, s� b�lgemaskinen kan producere h�jere
% effekt, desto h�jere b�lgerne er. Der lader til at v�re en st�rkere
% virkning af b�lgeh�jde end af l�ngde, og der er mindre variation i data
% for dette plot. 


%% b: Multipel line�r regression
mdl = fitlm([Laengde Hoejde], Effekt, ...
    'ResponseVar', 'Effekt', ...
    'PredictorVars', {'Laengde', 'Hoejde'})

% Regressionsligning:
%   Effekt = 51.19 - 24.737*Laengde + 19.606*Hoejde


%% c: Fortolkning af regressionsanalysen
% Det er en ganske god model. Alle koefficienterne er signifikant
% forskellige fra 0 p� 95 % signifikansniveau, da p-v�rdierne er t�t p� 0 
% (under 0.05). I ANOVA testen er F=17.9, som giver en p-v�rdi p� 0.000732.
% Det er alts� meget usandsynlig at hverken b�lgel�ngde eller h�jde har en 
% effekt p� den producerede effekt. Desuden er R-squared 0.799
% og Adjusted R-squared er 0.754, s� modellen forklarer en p�n del af
% variationen. Men der er plads til forbedringer. 


%% d: Unormale punkter
lev = mdl.Diagnostics.Leverage;     % hat diagonal
rst = mdl.Residuals.Studentized;    % R-Student
nr = (1:n)';
resultat = [nr, Laengde, Hoejde, Effekt, lev, rst]            % Jeg samler det hele til en resultattabel

k = 2;                  % Der er to regressorer
lev_limit = 2*(k+1)/n   % lev_limit = 0.5
% Der er ingen l�ftestangspunkter, da alle v�rdier for lev er under 
% lev_limit p� 0.5. Dog er punkt nr. 10 med Laengde = 3.0 og Hoejde = 1.0 
% t�t p�, da lev = 0.4708. 
% Der er en enkelt outlier, for punkt nr. 3 med Laengde = 1.0 og 
% Hoejde = 3.0 har |rst| = 3.1069, som er over gr�nsen p� 3. 
% Der er ingen indflydelsespunkter, for det kr�ver at samme punkt er b�de
% l�ftestangspunkt og outlier. 


%% e: Er sammenh�ngen line�r for fast b�lgel�ngde L = 2.0?
% Datas�ttet reduceres til de 6 observationer med Laengde = 2.0:
Hoejde = Hoejde(4:9,:)
Effekt = Effekt(4:9,:)

figure(3)
scatter(Hoejde, Effekt)
lsline
title('Effekt som funktion af b�lgeh�jde, hvor b�lgel�ngden er 2.0 m')
xlabel('B�lgeh�jde (m)')
ylabel('Produceret effekt (kW)')
% Plottet viser en sammenh�ng, der m�ske bedre kan beskrives som S-formet
% end som line�r. Der lader til at skulle en vis b�lgeh�jde til for at
% danne energi, og n�r b�lgel�ngden bliver tilstr�kkelig stor klinger den
% producerede effekt af.

% Jeg tester med en simpel line�r regression: 
mdl2 = fitlm(Hoejde, Effekt)
% Det er en god model, hvor h�ldingskoefficienten b1=20.286 er signifikant
% (pValue = 0.00069657). R-Squared og Adjusted R-Squared er over 0.9 (hhv.
% 0.957 og 0.947), s� modellen forklarer en stor andel af variationen. 
% Men p� plottet ser punkterne ud til at f�lge et S-formet forl�b.


%% f: Transformation af b�lgeh�jden 
k = 2.5
Hoejde_l = 1./(1 + exp(k - Hoejde))
mdl3 = fitlm(Hoejde_l, Effekt)
plot(mdl3)


%% g: Effekt som funktion af b�lgeh�jde
% Regressionsligning:
% Effekt = -9.1154 + 122.39*Hoejde_l 
% Effekt = -9.1154 + 122.39*1/(1 + exp(k - Hoejde)) 
Hoejde_0 = 4.7
Effekt_0 = -9.1154 + 122.39*1/(1+exp(k - Hoejde_0))
% Den forventede effekt af b�lger p� 4.7 m er 101.0661 kW = 101 kW

