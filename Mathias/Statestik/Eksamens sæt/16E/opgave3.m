%% E2016 Opg 3: Batteriets opladningsgrad
clear all; close all; clc;

M = xlsread('Data_M4STI1_2016E.xlsx', 'D:E')

vaegt = M(:,1)
opladn = M(:,2)

%% a. Line�r regression
mdl = fitlm(vaegt, opladn)
% Med R^2 = 0.905 og R^2_adjusted = 0.889 forklarer modellen en meget
% stor del af variationen i data. Begge koefficienter er signifikant
% forskellige fra 0, s� der er negativ korrelation i data (p-v�rdi =
% 0.00028102. At d�mme ud fra regressionsanalysen alene, er det en god
% model.

%% b: Figur
figure(1)
scatter(vaegt,opladn)
lsline
title('Sammenh�ng mellem dronens belastning og batteriets opladningsgrad');
xlabel('Dronens belastning (kg)');
ylabel('Batteriets opladningsgrad (%)');

% Figuren viser, at selv om regressionsanalysens statistikker var gode, s�
% er det ikke en line�r sammenh�ng imellem belastning og opladningsgrad.
% For sm� belastninger op til ca. et kg ser sammenh�ngen line�r ud, men s�
% begynder belastningen at v�re h�rdt ved batteriet. 

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
% Det er ogs� kun det sidste punkt med belastning p� 2 kg, der har leverage
% over gr�nsen p� lev_limit = 0.5. Dette punkt har lev = 0.5088.
% Da punktet b�de er outlier og l�ftestangspunkt, s� er det et
% indflydelsespunkt. 

%% d. Pizza p� 630 gram

% Man kunne fors�ge sig med at transformere data for at finde en line�r
% sammenh�ng for hele datas�ttet, men da kurven er fint line�r indtil en
% belastning p� 1 kg, og 0.63kg befinder sig p� den line�re del, s� laver
% jeg blot en line�r regression p� de f�rste fem datapunkter. 

vaegt_red = vaegt(1:5,:)
opladn_red = opladn(1:5,:)
fitlm(vaegt_red, opladn_red)

figure(5)
scatter(vaegt_red, opladn_red)
lsline

% Resultatet ser p�nt ud og regressionslinjen f�lger data. 
% Modellen har en meget h�j R^2 p� 0.994 og R^2_adjusted p� 0.992. 
% Begge koefficienter er signifikant forskellige fra 0.
% Vi kan dermed beregne opladningsgraden efter en km flyvning med pizzaen
% p� 0.63 kg:
opladn_630 = 79.2 - 9.2*0.63

% Resultatet er 73.4 pct. 
% Havde vi brugt den oprindelige model, ville vi f� 72.0 pct.:
opladn_630_oprindelig = 83.353 - 18.045*0.63