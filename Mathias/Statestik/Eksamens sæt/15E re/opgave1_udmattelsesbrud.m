%% M4STI E2015rx opgave 1 om udmattelsesbrud
clc; clear all; close all;

%% Indl�s data
M = xlsread('Data_M4STI1_2015E_reeksamen.xlsx', 'A:B')
S = M(:,1)  % Stress p�virkning
N = M(:,2)  % Antal p�virkninger til udmattelsesbrud observeret

%% a
mdl = fitlm(S,N)

figure(1)
plot(mdl)
title('Model 1: N = b + a*S');
xlabel('S');
ylabel('N');

% Regressionsligning: N = 44055 -197.29*S

%% b
% Modellen er ikke god. B�de h�ldningskoefficient og sk�ring er signifikant
% forskellig fra 0 p� 5% signifikansniveau, og en stor del af variationen
% forklares af modellen (R-squared = 0.65 og R-squared = 0.58). Men plottet
% viser at data overhovedet ikke er line�re, s� en line�r model er ikke god
% til at fitte de givne data. Data f�lger en kurve, s� det vil v�re smart
% at lave en transformation



%% c: logaritmisk transformation
lnS = log(S);
lnN = log(N);

% F�rst pr�ves en logaritmisk transformation af N
mdl2 = fitlm(S,lnN)

figure(2);
plot(mdl2)
title('Model 2: ln(N) = b + a*S');
xlabel('S');
ylabel('ln(N)');

% Dern�st pr�ves en logaritmisk transformation af S
mdl3 = fitlm(lnS,N)

figure(3);
plot(mdl3)
title('Model 3: N = b + a*ln(S)');
xlabel('ln(S)');
ylabel('N)');

% Til sidst pr�ves en logaritmisk transformation af b�de S og N
mdl4 = fitlm(lnS,lnN)

figure(4);
plot(mdl4)
title('Model 4: ln(N) = b + a*ln(S)');
xlabel('ln(S)');
ylabel('ln(N)');


%% d
% Modellen med logaritmisk transformation af N er bedst. Begge
% koefficienter er signifikante, da deres p-v�rdier er meget t�t p� 0, og
% n�sten al variationen i data forklares af modellen; R-squared er 0.995 og
% Adjusted R-Squared er 0.993. 
% Modellen med logaritmisk transformation af b�de N og S er ogs� god. Her
% er koefficienterne ligeledes signifikante, og n�sten al variationen
% forklares af modellen. R-squared og Adjusted R-Squared er knap s� h�je
% (hhv. 0.984 og 0.981), men nok til at g�re det til en god model. 
% N�r man ser plots for disse to gode modeller er det dog tydeligt, at
% modellen med logartimisk transformation af begge variable ikke ser helt
% s� line�r ud som den, hvor vi kun laver transformation af N. 

%% e
% Regressionsligningen for min foretrukne model: 
%    ln(N) = 16.42 - 0.047542*S
% Forventet antal p�virkninger til udmattelsesbrud med S=180 MPa:
ln_N_180 = 16.42  - 0.047542*180
N_180 = exp(ln_N_180)

% ln_N_180 = 7.8624 
% N_180 = 2.5979e+03
% Dermed er det forventede antal p�virkninger til udmattelsesbrud 2598 


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

% Ingen m�linger har en hat-diagonal over lev_limit (0.5714), s� der er
% ingen leverage, 
% men m�lingen for 230 har R-student residual p� 3.8, s� det er en outlier.
% 