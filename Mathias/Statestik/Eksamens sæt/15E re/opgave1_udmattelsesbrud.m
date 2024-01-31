%% M4STI E2015rx opgave 1 om udmattelsesbrud
clc; clear all; close all;

%% Indlæs data
M = xlsread('Data_M4STI1_2015E_reeksamen.xlsx', 'A:B')
S = M(:,1)  % Stress påvirkning
N = M(:,2)  % Antal påvirkninger til udmattelsesbrud observeret

%% a
mdl = fitlm(S,N)

figure(1)
plot(mdl)
title('Model 1: N = b + a*S');
xlabel('S');
ylabel('N');

% Regressionsligning: N = 44055 -197.29*S

%% b
% Modellen er ikke god. Både hældningskoefficient og skæring er signifikant
% forskellig fra 0 på 5% signifikansniveau, og en stor del af variationen
% forklares af modellen (R-squared = 0.65 og R-squared = 0.58). Men plottet
% viser at data overhovedet ikke er lineære, så en lineær model er ikke god
% til at fitte de givne data. Data følger en kurve, så det vil være smart
% at lave en transformation



%% c: logaritmisk transformation
lnS = log(S);
lnN = log(N);

% Først prøves en logaritmisk transformation af N
mdl2 = fitlm(S,lnN)

figure(2);
plot(mdl2)
title('Model 2: ln(N) = b + a*S');
xlabel('S');
ylabel('ln(N)');

% Dernæst prøves en logaritmisk transformation af S
mdl3 = fitlm(lnS,N)

figure(3);
plot(mdl3)
title('Model 3: N = b + a*ln(S)');
xlabel('ln(S)');
ylabel('N)');

% Til sidst prøves en logaritmisk transformation af både S og N
mdl4 = fitlm(lnS,lnN)

figure(4);
plot(mdl4)
title('Model 4: ln(N) = b + a*ln(S)');
xlabel('ln(S)');
ylabel('ln(N)');


%% d
% Modellen med logaritmisk transformation af N er bedst. Begge
% koefficienter er signifikante, da deres p-værdier er meget tæt på 0, og
% næsten al variationen i data forklares af modellen; R-squared er 0.995 og
% Adjusted R-Squared er 0.993. 
% Modellen med logaritmisk transformation af både N og S er også god. Her
% er koefficienterne ligeledes signifikante, og næsten al variationen
% forklares af modellen. R-squared og Adjusted R-Squared er knap så høje
% (hhv. 0.984 og 0.981), men nok til at gøre det til en god model. 
% Når man ser plots for disse to gode modeller er det dog tydeligt, at
% modellen med logartimisk transformation af begge variable ikke ser helt
% så lineær ud som den, hvor vi kun laver transformation af N. 

%% e
% Regressionsligningen for min foretrukne model: 
%    ln(N) = 16.42 - 0.047542*S
% Forventet antal påvirkninger til udmattelsesbrud med S=180 MPa:
ln_N_180 = 16.42  - 0.047542*180
N_180 = exp(ln_N_180)

% ln_N_180 = 7.8624 
% N_180 = 2.5979e+03
% Dermed er det forventede antal påvirkninger til udmattelsesbrud 2598 


%% f
figure(5);
plot(mdl2)
title('ln(N) = 16.42  - 0.0475*S');
xlabel('S');
ylabel('ln(N)');


%% g outliers

lev = mdl2.Diagnostics.Leverage;     % hat diagonal
rst = mdl2.Residuals.Studentized;    % R-Student
resultat = [S, lev, rst]             % Jeg samler det til en resultattabel

k = 1 % Antal regressorvariable
n = size(S,1) % Antal observationer

lev_limit = 2*(k+1)/n

% Ingen målinger har en hat-diagonal over lev_limit (0.5714), så der er
% ingen leverage, 
% men målingen for 230 har R-student residual på 3.8, så det er en outlier.
% 