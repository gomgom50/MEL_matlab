%% M4STI E2015rx opgave 3 om vejgreb af formel 1 racer
clc; clear all; close all;

%% Indl�s data
M=xlsread('Data_M4STI1_2015E_reeksamen.xlsx', 'I:K') 

daek = M(:,1)
affjedring = M(:,2)
vejgreb = M(:,3)

%% a. Boxplots
figure(1);
boxplot(vejgreb, daek)
title('D�k');

figure(2);
boxplot(vejgreb, affjedring)
title('Affjedring');

% Ud fra boxplottene i figur 1 og 2 lader d�ktype 3 og affjedringsindstilling 
% 1 til at v�re bedst, da disse har klart h�jeste medianer og kasserne er 
% relativt smalle, s� der er mindre variation end i de andre kategorier. 
% Affjedring 1 har dog en outlier. 


%% b. ANOVA
figure(3);
[p,table,stats,terms] = anovan(vejgreb, {daek, affjedring}, 'model','interaction', 'varnames',{'daek','affjedring'})

% S�vel d�k, affjedring og interaktionen mellem de to er signifikante p� 5%
% signifikans niveau. P-v�rdierne er hhv. 0.0016, 0 og 0.0193.


%% c. Frihedsgrader
% Antal frihedsgrader for interaktionen er 4, og det er beregnet som 
% df = (a-1)*(b-1), hvor a er antal behandlinger p� f�rste faktor (daek)
% og b er antal behandlinger af andend faktor (affjedring). Derfor er 
% df = (3-1)*(3-1) = 4

%% d. Parvis sammenligning

figure(4);
[c,m] = multcompare(stats, 'Alpha', 0.05, 'CType', 'lsd', 'Dimension', [1])
% 1 er forskellig fra 2 og 3. 2 og 3 er ikke signifikant forskellige

figure(5);
[c,m] = multcompare(stats, 'Alpha', 0.05, 'CType', 'lsd', 'Dimension', [2])
% 1, 2 og 3 er alle parvist forskellige

%% e. Bedste kombination genovervejet
% ANOVA testen i delsp�rgsm�l b) viste, at der er signifikant interaktion.
% Interaktionen kan bevirke, at den bedste d�ktype og den bedste affjedring, 
% set isoleret, ikke n�dvendigvis er den bedste kombination, samlet set. 
% Det f�lgende boxplot med alle 9 kombinationer af d�ktype og affjedring 
% viser et mere kompliceret billede, og kombinationen med d�ktype 3 og 
% affjedringsindstilling 1 er ikke n�dvendigvis s� god som kombinationen af 
% d�ktype 2 og affjedring 1
figure(6);
boxplot(vejgreb, {daek,affjedring})

figure(7);
[c,m] = multcompare(stats, 'Alpha', 0.05, 'CType', 'lsd', 'Dimension', [1,2])
% Denne parvise sammenligning mellem kombinationerne af d�ktype og
% affjedringstype viser dog, at kombinationerne {1,1}, {2,1}, {3,1}, {2,2} 
% og {3,2} ikke er signifikant forskellige. 
% Jeg ville trods alt v�lge d�ktype 2 og affjedring 1 som min
% foretrukne kombination

%% f. Antagelser for residualer
% Vi har antaget, at residualerne er normalfordelte med middelv�rdi 0 og 
% med samme varians for hver faktor. 
% Resudualer findes i stats objektet, lavet af anovan
resid = stats.resid

figure(8)
normplot(resid)

figure(9)
scatter(daek, resid, 'filled')
xlabel('D�ktype')
ylabel('Residualer')

figure(10)
scatter(affjedring, resid, 'filled')
xlabel('Affjedringsindstilling')
ylabel('Residualer')

y_hat = [vejgreb - resid]  
% For hver observation beregnes estimatet for vejgrebet

figure(11)
scatter(y_hat, resid, 'filled')
xlabel('Estimat for vejgreb')
ylabel('Residualer')

% Antagelserne er tilfredsstillende underbygget; Normplottet er nogenlunde
% line�rt (fig. 8), residualerne er nogenlunde ens for de enkelte faktor-
% niveauer (fig. 9 og 10), der lader dog til at v�re mere variation p�
% niveau 1 for b�de d�k og affjedring. 
% Residualerne lader ikke til at afh�nge af st�rrelsen af y_hat (fig. 11)
