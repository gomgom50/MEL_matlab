% Opgave 2 (Vindmøllestrøm)

clc; clear all; close all;

M = xlsread('Data_M4STI1_2015F_reeksamen.xlsx','A:B') 

x = M(:,1)      % Regressor x (vindhastighed)
y = M(:,2)      % Respons y (strømproduktion)

%% a
% Simpel lineær regression
mdl = fitlm(x, y)

% Regressionsligning:
% Svar: y = 0.13088 + 0.24115*x
y_95 = 0.13088 + 0.24115*9.5
% Svar: Forventet strømproduktion svarende til 9.5 er 2.4218


%% b
% Beskrivelse af modellens kvalitet
% Både R-squared og Adjusted R-Squared er tæt på 0.90, så modellen 
% beskriver en acceptabelt høj del af variationen i data. 
% Koefficienten for hældningen (b1) er signifikant forskellig fra 0, 
% men det er koefficienten for skæring med y-aksen (b0) ikke (p-værdi 0.31). 


%% c
% Scatterplot og residualplot

yhat = 0.13088 + 0.24115*x

% Scatterplot
figure(1)
hold on;
scatter(x, y, 'filled')
plot(x, yhat)
xlabel('Vindhastighed');
ylabel('Produceret strøm');
hold off;

resid = y - yhat

% Residualplot
figure(2)
title('Residualplot')
scatter(yhat, resid, 'filled')
xlabel('y_{hat}')
ylabel('residual')

% Det fremgår tydeligt af figur 1, at sammenhængen mellem x og y ikke er lineær. 
% Derfor er der tendens til at den lineære model rammer for højt for lave og   
% høje værdier af x og for lavt midt imellem. Det ses også i residualplottet, 
% hvor residualet er negativt for høje og lave værdier af y_hat og positivt 
% for værdier i midten. 
% Det tyder på, at en transformation kan give en bedre model. 


%% d
% Først en logaritmisk transformation 
y1 = y; 
x1 = log(x);

mdl1 = fitlm(x1, y1)

% y1 = -0.83036 + 1.4168*x1

% Dernæst en reciprok transformation
y2 = y;
x2 = 1./x;

mdl2 = fitlm(x2, y2)

% y2 = 2.9789 - 6.9345*x2


%% e
% Logaritmisk transformation
y1hat = -0.83036 + 1.4168*x1
figure(3)
hold on;
scatter(x1, y1, 'filled')
plot(x1, y1hat)
xlabel('Vindhastighed logaritmisk (logx)')
ylabel('Produceret strøm')
hold off;

resid1 = y1 - y1hat

figure(4)
title('Residualplot')
scatter(y1hat, resid1, 'filled')
xlabel('y_{hat}')
ylabel('residual')

% Reciprok transformation
y2hat = 2.9789 - 6.9345*x2
figure(5)
hold on;
scatter(x2, y2, 'filled')
plot(x2, y2hat)
xlabel('Vindhastighed reciprok (1/x)')
ylabel('Produceret strøm')
hold off;

resid2 = y2 - y2hat

figure(6)
title('Residualplot')
scatter(y2hat, resid2, 'filled')
xlabel('y_{hat}')
ylabel('residual')

%% f
% Den logaritmiske model er bedre end den lineære uden transformation, da 
% både R-square () og Adjusted R-Square er højere end for den utransformerede. 
% Desuden er p-værdierne mindre, og begge koefficienter er signifikante. 
% Residualplottet viser dog, at residualerne ikke er tilfældigt fordelt.

% Den reciprokke model er endnu bedre end den logaritmiske. Både R-Squared
% og Adjusted R-Squared er tæt på 1, og p-værdierne for begge koefficienter
% er tæt på nul. Scatterplottet med regressionsligningen på viser at
% punkterne ikke varierer ret meget omkring linjen, og residualerne i
% residualplottet lader til at være tilfældigt fordelt. Derfor vælges denne
% model som den bedste. Regressionsligningen er:
% y = 2.9789 - 6.9345/x
