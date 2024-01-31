%% E2016 Opg 3: Batteriets opladningsgrad
clear all; close all; clc;

M = xlsread('Data_M4STI1_2016E.xlsx', 'D:E')

vaegt = M(:,1)
opladn = M(:,2)

%% a. Lineær regression
mdl = fitlm(vaegt, opladn)
% Med R^2 = 0.905 og R^2_adjusted = 0.889 forklarer modellen en meget
% stor del af variationen i data. Begge koefficienter er signifikant
% forskellige fra 0, så der er negativ korrelation i data (p-værdi =
% 0.00028102. At dømme ud fra regressionsanalysen alene, er det en god
% model.

%% b: Figur
figure(1)
scatter(vaegt,opladn)
lsline
title('Sammenhæng mellem dronens belastning og batteriets opladningsgrad');
xlabel('Dronens belastning (kg)');
ylabel('Batteriets opladningsgrad (%)');

% Figuren viser, at selv om regressionsanalysens statistikker var gode, så
% er det ikke en lineær sammenhæng imellem belastning og opladningsgrad.
% For små belastninger op til ca. et kg ser sammenhængen lineær ud, men så
% begynder belastningen at være hårdt ved batteriet. 

%% c. 'Unormale' datapunkter
lev = mdl.Diagnostics.Leverage;     % hat diagonal
rst = mdl.Residuals.Studentized;    % R-Student
resultat = [M, lev, rst]            % Jeg samler det hele til en resultattabel som table 6.42

k = 1 % Antal regressorvariable
n = size(M,1) % Antal observationer
lev_limit = 2*(k+1)/n

% Vi kan se i tabellen resultat, at kun det sidste punkt med belastningen 2 kg
% har studentiseret residual |rst|>3, nemlig 3.8379. Dette punkt er derfor 
% en outlier. 
% Det er også kun det sidste punkt med belastning på 2 kg, der har leverage
% over grænsen på lev_limit = 0.5. Dette punkt har lev = 0.5088.
% Da punktet både er outlier og løftestangspunkt, så er det et
% indflydelsespunkt. 

%% d. Pizza på 630 gram

% Man kunne forsøge sig med at transformere data for at finde en lineær
% sammenhæng for hele datasættet, men da kurven er fint lineær indtil en
% belastning på 1 kg, og 0.63kg befinder sig på den lineære del, så laver
% jeg blot en lineær regression på de første fem datapunkter. 

vaegt_red = vaegt(1:5,:)
opladn_red = opladn(1:5,:)
fitlm(vaegt_red, opladn_red)

figure(5)
scatter(vaegt_red, opladn_red)
lsline

% Resultatet ser pænt ud og regressionslinjen følger data. 
% Modellen har en meget høj R^2 på 0.994 og R^2_adjusted på 0.992. 
% Begge koefficienter er signifikant forskellige fra 0.
% Vi kan dermed beregne opladningsgraden efter en km flyvning med pizzaen
% på 0.63 kg:
opladn_630 = 79.2 - 9.2*0.63

% Resultatet er 73.4 pct. 
% Havde vi brugt den oprindelige model, ville vi få 72.0 pct.:
opladn_630_oprindelig = 83.353 - 18.045*0.63