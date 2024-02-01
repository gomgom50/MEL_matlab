%% Opgave 2 (Slitage p� kuglelejer)
close all; clear; clc; 

%% Indl�s data
M = xlsread('Data_M4STI1_2016F_reeksamen.xlsx','C:E')

y = M(:,3)
x = M(:,1:2)


%% a: Scatter plots
x1 = M(:,1);
x2 = M(:,2);

figure(1)
scatter(x1,y,'filled')
title('Slitage p� kuglelejer');
xlabel('x1 (Olie viskositet)');
ylabel('y (Slitage)');
% Der lader ikke til at v�re korrellation mellem viskositet og slitage

figure(2)
scatter(x2,y,'filled')
title('Slitage p� kuglelejer');
xlabel('x2 (Belastning)');
ylabel('y (Slitage)');
% Der lader til at v�re positiv korrellation mellem belastning og slitage


%% b: 
mdl = fitlm(x, y)

% Koefficienterne afl�ses, s� regressionsligningen kan skrives op:
% y = 68.182 - 0.06637*x1 + 2.5256*x2


%% c: 
%  Estimeret slitage med viskositet = 25.0 og en belastning = 100:
y_est = 68.182 - 0.06637*25.0 + 2.5256*100
% y_est = 319.0827 = 319


%% d:
% pValue for de tre estimater for koefficienterne angiver sandsynligheden
% for det observerede, hvis koefficienterne i virkeligheden er 0. P-v�rdien
% for koefficienten for Intercept (b0) og for x2 (b2) er t�t p� 0, s� vi
% kan tro p�, at disse koefficienter i virkeligheden ikke er 0. Til geng�ld
% kan koefficienten for x1 (b1) meget vel v�re 0 i virkeligheden, da
% p-v�rdien er stor. Det vil sige, at vi er ikke sikre p�, at der er en
% effekt af x1, men der er af x2. Det svarer til hvad vi s� i scatter
% plots. 
%
% F-testens p-v�rdi p� 3.83e-12 angiver sandsynligheden for det
% observerede, hvis begge koefficienter b1 og b2 i virkeligheden er 0,
% alts� ingen effekt af hverken viskositet eller belastning p� slitage. Da
% det er en meget lille sandsynlighed, tror vi p� en effekt af mindst en af
% regressorerne.
%
% R-squared er et m�l for hvor meget af variationen i data, der kan
% forklares af regressionsmodellen. V�rdien p� 0.918 er normalt meget
% tilfredsstillende. I statistikken adjusted R-squared er R-squared
% justeret i forhold til hvor mange koefficienter, der skal estimeres, for
% at modvirke overfitting af modellen. Ogs� her er v�rdien h�j(0.91), s� 
% det er en tilfredsstillende model. Man burde dog overveje en simpel  
% regressionsmodel med kun x2 som regressor, da x1 ikke er signifikant.  


%% e: 
% 1. Fuld model med kvadratled og interaktionsled
mdl = fitlm(x, y, 'y ~ x1 + x2 + x1^2 + x2^2 + x1:x2')
% R^2 = 0.945, adj-R^2 = 0.93. Begge meget h�je v�rdier, s� modellen
% beskriver variationen i data godt.
% Mindst signifikante led er x1^2 med p-v�rdi=0.92702. Det fjerner jeg:

% 2:
mdl = fitlm(x, y, 'y ~ x1 + x2 + x2^2 + x1:x2')
% I denne model, hvor mindst signifikante led (x1^2) er fjernet, f�r jeg
% R^2 = 0.945, adj-R^2 = 0.933. Stadig meget h�je v�rdier.
% Mindst signifikante led er x2^2 med p-v�rdi=0.16752. Det fjerner jeg:

% 3:
mdl = fitlm(x, y, 'y ~ x1 + x2 + x1:x2')
% R^2 = 0.939, adj-R^2 = 0.93. V�rdierne er faldet en anelse, men er stadig 
% meget h�je. Nu er p-v�rdierne for alle led under 0.05, s� koefficienterne 
% er signifikante p� 5% niveau. 
% Jeg er tilfreds med denne model, som har ligningen:
% y = 170.36 - 3.8198*x1 + 1.3786*x2 + 0.042293*x1*x2

% Som kuriosum kan vi beregne den estimerede slitage med viskositet = 25.0 
% og en belastning = 100, n�r vi bruger den udvidede model:
y_est2 = 170.36 - 3.8198*25. + 1.3786*100 + 0.042293*25.0*100
% Resultatet er y_est2 = 318.4575 = 318, n�sten det samme som i
% delsp�rgsm�l c. (y_est = 319).


%% f
% Modellen fra c. har lidt lavere R^2 og adj-R^2 end modellen fra e., hhv.
% 0.918 mod 0.939 for R^2 og 0.91 mod 0.93 for adj-R^2. 
% Den udvidede model beskriver alts� variationen i data en anelse bedre, 
% selv n�r vi med adj-R^2 'straffer' for at have en parameter mere i modellen. 
% Det st�rste problem med modellen i c. er dog at koefficienten for x1 ikke
% er signifikant (pValue = 0.89696). Med andre ord kan koefficienten meget
% vel v�re 0, s� slitagen ikke afh�nger af viskositet. Det var ogs� det
% indtryk, vi fik af scatter plottet for x1 i a. 
% N�r x1 alligevel har signifikant effekt i den udvidede model, b�de direkte 
% og igennem leddet x1:x2, s� skyldes det interaktion mellem x1 og x2, som
% sl�rer billedet i delsp�rgsm�l c, fordi vi ikke har interaktion med i 
% modellen. N�r vi inddrager interaktionen mellem x1 og x2 i modellen, s� 
% bliver effekten signifikant, ogs� for x1 alene. 


%% g
[yhat, yci] = predict(mdl, x) 
% yhat som output fra funktionen predict er modellens estimat for slitage. 
% Vi kunne ogs� beregne yhat som: 
% yhat = 170.36 - 3.8198*x1 + 1.3786*x2 + 0.042293*x1.*x2
% yci er nedre og �vre gr�nse for konfidensinterval

% Residualet beregnes som forskellen mellem m�lt og estimeret v�rdi:
resid = y - yhat

% Jeg samler det hele til en tabel:
resultat = [x1, x2, y, yhat, resid, yci]


%% h
% Til resdidualanalysen er det bedst at bruge studentiserede residualer:
r = mdl.Residuals.Studentized

figure(3)
scatter(yhat,r)
title('Residualplot');
xlabel('y hat');
ylabel('Studentiseret residual');
% Residualerne lader ikke til at afh�nge af estimeret v�rdi, y_hat. Det er
% det �nskede m�nster, at residualerne er tilf�ldigt placeret i plottet.

figure(4)
scatter(x1,r)
title('Residualplot');
xlabel('x1 (Olieviskositet)');
ylabel('Studentiseret residual');
% M�nsteret ser ikke helt tilf�ldigt ud, men der er dog heller ikke et
% klart m�nster, f.eks. et tragtformet. 

figure(5)
scatter(x2,r)
title('Residualplot');
xlabel('x2 (Belastning)');
ylabel('Studentiseret residual');
% Det ser tilf�ldigt ud. Fint!

obs = 1:24 % Observationsr�kkef�lge
figure(6)
scatter(obs,r)
title('Residualplot');
xlabel('Observationsr�kkef�lge');
ylabel('Studentiseret residual');
% Der lader heller ikke til at v�re systematik af residualerne over tid.
% Fint. 

figure(7)
normplot(r)
% Residualerne skal f�lge en 'p�n' fordeling, s� vi kan teste om
% fordelingen ligner normalfordelingen. Da residualerne ligger nogenlunde
% p� en ret linje i normalfordelingsplottet kommer de fra en p�n fordeling.
% 
% Residualanalysen viser alt i alt, at modelantagelserne holder.

