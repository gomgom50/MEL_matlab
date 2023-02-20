% Opgave 2 (Vindm�llestr�m)

clc; clear all; close all;

M = xlsread('Data_M4STI1_2015F_reeksamen.xlsx','A:B') 

x = M(:,1)      % Regressor x (vindhastighed)
y = M(:,2)      % Respons y (str�mproduktion)

%% a
% Simpel line�r regression
mdl = fitlm(x, y)

% Regressionsligning:
% Svar: y = 0.13088 + 0.24115*x
y_95 = 0.13088 + 0.24115*9.5
% Svar: Forventet str�mproduktion svarende til 9.5 er 2.4218


%% b
% Beskrivelse af modellens kvalitet
% B�de R-squared og Adjusted R-Squared er t�t p� 0.90, s� modellen 
% beskriver en acceptabelt h�j del af variationen i data. 
% Koefficienten for h�ldningen (b1) er signifikant forskellig fra 0, 
% men det er koefficienten for sk�ring med y-aksen (b0) ikke (p-v�rdi 0.31). 


%% c
% Scatterplot og residualplot

yhat = 0.13088 + 0.24115*x

% Scatterplot
figure(1)
hold on;
scatter(x, y, 'filled')
plot(x, yhat)
xlabel('Vindhastighed');
ylabel('Produceret str�m');
hold off;

resid = y - yhat

% Residualplot
figure(2)
title('Residualplot')
scatter(yhat, resid, 'filled')
xlabel('y_{hat}')
ylabel('residual')

% Det fremg�r tydeligt af figur 1, at sammenh�ngen mellem x og y ikke er line�r. 
% Derfor er der tendens til at den line�re model rammer for h�jt for lave og   
% h�je v�rdier af x og for lavt midt imellem. Det ses ogs� i residualplottet, 
% hvor residualet er negativt for h�je og lave v�rdier af y_hat og positivt 
% for v�rdier i midten. 
% Det tyder p�, at en transformation kan give en bedre model. 


%% d
% F�rst en logaritmisk transformation 
y1 = y; 
x1 = log(x);

mdl1 = fitlm(x1, y1)

% y1 = -0.83036 + 1.4168*x1

% Dern�st en reciprok transformation
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
ylabel('Produceret str�m')
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
ylabel('Produceret str�m')
hold off;

resid2 = y2 - y2hat

figure(6)
title('Residualplot')
scatter(y2hat, resid2, 'filled')
xlabel('y_{hat}')
ylabel('residual')

%% f
% Den logaritmiske model er bedre end den line�re uden transformation, da 
% b�de R-square () og Adjusted R-Square er h�jere end for den utransformerede. 
% Desuden er p-v�rdierne mindre, og begge koefficienter er signifikante. 
% Residualplottet viser dog, at residualerne ikke er tilf�ldigt fordelt.

% Den reciprokke model er endnu bedre end den logaritmiske. B�de R-Squared
% og Adjusted R-Squared er t�t p� 1, og p-v�rdierne for begge koefficienter
% er t�t p� nul. Scatterplottet med regressionsligningen p� viser at
% punkterne ikke varierer ret meget omkring linjen, og residualerne i
% residualplottet lader til at v�re tilf�ldigt fordelt. Derfor v�lges denne
% model som den bedste. Regressionsligningen er:
% y = 2.9789 - 6.9345/x
