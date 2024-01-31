%%Opgave 4
clc; clear all; close all; 
M=xlsread('M4STI_2015_data.xlsx','F:I')

y = M(:,4)
x = M(:,1:3)
n = size(y,1)

%% a Scatter plots
figure(1)
scatter(x(:,1),y,'filled')
lsline  % vis regressionslinje
ylabel('Tilfredshed')
xlabel('Alder')

figure(2)
scatter(x(:,2),y,'filled')
ylabel('Tilfredshed')
xlabel('Sygdom')

figure(3)
scatter(x(:,3),y,'filled')
ylabel('Tilfredshed')
xlabel('Bekymring')

%% b
mdl = fitlm(x, y)

%% c 
tilfredshed = 144.58 - 1.1267*60 - 0.58727*45 +1.3448*3.0

%% d

%% e
mdl = fitlm(x(:,1:2), y)

%% f
mdl = fitlm(x, y)   % Jeg kører fitlm igen, så mdl er modellen med x1, x2, x3
[yhat, yci] = predict(mdl,x)

xresidual = yhat-y

resultat = [x, y, yhat, y-yhat, yci]

lev = mdl.Diagnostics.Leverage;     % hat diagonal
rst = mdl.Residuals.Studentized;    % R-Student
obs = (1:n)';
resultat = [obs, M, lev, rst]            % Jeg samler det hele til en resultattabel

k=3;
lev_limit = 2*(k+1)/n

%% g

figure(4)
title('R-Student vs. modelestimat')
scatter(yhat,rst)
lsline
xlabel('Estimeret tilfredshed')
ylabel('R-Student')

figure(5)
title('R-Student vs. Alder')
scatter(x(:,1),rst)
xlabel('Alder')
ylabel('R-Student')

figure(6)
title('R-Student vs. Sygdom')
scatter(x(:,2),rst)
xlabel('Sygdom')
ylabel('R-Student')

figure(7)
title('R-Student vs. Bekymring')
scatter(x(:,3),rst)
xlabel('Bekymring')
ylabel('R-Student')

figure(9)
normplot(rst)

