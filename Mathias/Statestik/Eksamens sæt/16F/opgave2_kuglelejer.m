%% Opgave 2 (Slitage på kuglelejer)
close all; clear; clc; 

%% Indlæs data
M = xlsread('Data_M4STI1_2016F_reeksamen.xlsx','C:E')

y = M(:,3)
x = M(:,1:2)


%% a: Scatter plots
x1 = M(:,1);
x2 = M(:,2);

figure(1)
scatter(x1,y,'filled')
title('Slitage på kuglelejer');
xlabel('x1 (Olie viskositet)');
ylabel('y (Slitage)');
% Der lader ikke til at være korrellation mellem viskositet og slitage

figure(2)
scatter(x2,y,'filled')
title('Slitage på kuglelejer');
xlabel('x2 (Belastning)');
ylabel('y (Slitage)');
% Der lader til at være positiv korrellation mellem belastning og slitage


%% b: 
mdl = fitlm(x, y)

% Koefficienterne aflæses, så regressionsligningen kan skrives op:
% y = 68.182 - 0.06637*x1 + 2.5256*x2


%% c: 
%  Estimeret slitage med viskositet = 25.0 og en belastning = 100:
y_est = 68.182 - 0.06637*25.0 + 2.5256*100
% y_est = 319.0827 = 319


%% d:
% pValue for de tre estimater for koefficienterne angiver sandsynligheden
% for det observerede, hvis koefficienterne i virkeligheden er 0. P-værdien
% for koefficienten for Intercept (b0) og for x2 (b2) er tæt på 0, så vi
% kan tro på, at disse koefficienter i virkeligheden ikke er 0. Til gengæld
% kan koefficienten for x1 (b1) meget vel være 0 i virkeligheden, da
% p-værdien er stor. Det vil sige, at vi er ikke sikre på, at der er en
% effekt af x1, men der er af x2. Det svarer til hvad vi så i scatter
% plots. 
%
% F-testens p-værdi på 3.83e-12 angiver sandsynligheden for det
% observerede, hvis begge koefficienter b1 og b2 i virkeligheden er 0,
% altså ingen effekt af hverken viskositet eller belastning på slitage. Da
% det er en meget lille sandsynlighed, tror vi på en effekt af mindst en af
% regressorerne.
%
% R-squared er et mål for hvor meget af variationen i data, der kan
% forklares af regressionsmodellen. Værdien på 0.918 er normalt meget
% tilfredsstillende. I statistikken adjusted R-squared er R-squared
% justeret i forhold til hvor mange koefficienter, der skal estimeres, for
% at modvirke overfitting af modellen. Også her er værdien høj(0.91), så 
% det er en tilfredsstillende model. Man burde dog overveje en simpel  
% regressionsmodel med kun x2 som regressor, da x1 ikke er signifikant.  


%% e: 
% 1. Fuld model med kvadratled og interaktionsled
mdl = fitlm(x, y, 'y ~ x1 + x2 + x1^2 + x2^2 + x1:x2')
% R^2 = 0.945, adj-R^2 = 0.93. Begge meget høje værdier, så modellen
% beskriver variationen i data godt.
% Mindst signifikante led er x1^2 med p-værdi=0.92702. Det fjerner jeg:

% 2:
mdl = fitlm(x, y, 'y ~ x1 + x2 + x2^2 + x1:x2')
% I denne model, hvor mindst signifikante led (x1^2) er fjernet, får jeg
% R^2 = 0.945, adj-R^2 = 0.933. Stadig meget høje værdier.
% Mindst signifikante led er x2^2 med p-værdi=0.16752. Det fjerner jeg:

% 3:
mdl = fitlm(x, y, 'y ~ x1 + x2 + x1:x2')
% R^2 = 0.939, adj-R^2 = 0.93. Værdierne er faldet en anelse, men er stadig 
% meget høje. Nu er p-værdierne for alle led under 0.05, så koefficienterne 
% er signifikante på 5% niveau. 
% Jeg er tilfreds med denne model, som har ligningen:
% y = 170.36 - 3.8198*x1 + 1.3786*x2 + 0.042293*x1*x2

% Som kuriosum kan vi beregne den estimerede slitage med viskositet = 25.0 
% og en belastning = 100, når vi bruger den udvidede model:
y_est2 = 170.36 - 3.8198*25. + 1.3786*100 + 0.042293*25.0*100
% Resultatet er y_est2 = 318.4575 = 318, næsten det samme som i
% delspørgsmål c. (y_est = 319).


%% f
% Modellen fra c. har lidt lavere R^2 og adj-R^2 end modellen fra e., hhv.
% 0.918 mod 0.939 for R^2 og 0.91 mod 0.93 for adj-R^2. 
% Den udvidede model beskriver altså variationen i data en anelse bedre, 
% selv når vi med adj-R^2 'straffer' for at have en parameter mere i modellen. 
% Det største problem med modellen i c. er dog at koefficienten for x1 ikke
% er signifikant (pValue = 0.89696). Med andre ord kan koefficienten meget
% vel være 0, så slitagen ikke afhænger af viskositet. Det var også det
% indtryk, vi fik af scatter plottet for x1 i a. 
% Når x1 alligevel har signifikant effekt i den udvidede model, både direkte 
% og igennem leddet x1:x2, så skyldes det interaktion mellem x1 og x2, som
% slører billedet i delspørgsmål c, fordi vi ikke har interaktion med i 
% modellen. Når vi inddrager interaktionen mellem x1 og x2 i modellen, så 
% bliver effekten signifikant, også for x1 alene. 


%% g
[yhat, yci] = predict(mdl, x) 
% yhat som output fra funktionen predict er modellens estimat for slitage. 
% Vi kunne også beregne yhat som: 
% yhat = 170.36 - 3.8198*x1 + 1.3786*x2 + 0.042293*x1.*x2
% yci er nedre og øvre grænse for konfidensinterval

% Residualet beregnes som forskellen mellem målt og estimeret værdi:
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
% Residualerne lader ikke til at afhænge af estimeret værdi, y_hat. Det er
% det ønskede mønster, at residualerne er tilfældigt placeret i plottet.

figure(4)
scatter(x1,r)
title('Residualplot');
xlabel('x1 (Olieviskositet)');
ylabel('Studentiseret residual');
% Mønsteret ser ikke helt tilfældigt ud, men der er dog heller ikke et
% klart mønster, f.eks. et tragtformet. 

figure(5)
scatter(x2,r)
title('Residualplot');
xlabel('x2 (Belastning)');
ylabel('Studentiseret residual');
% Det ser tilfældigt ud. Fint!

obs = 1:24 % Observationsrækkefølge
figure(6)
scatter(obs,r)
title('Residualplot');
xlabel('Observationsrækkefølge');
ylabel('Studentiseret residual');
% Der lader heller ikke til at være systematik af residualerne over tid.
% Fint. 

figure(7)
normplot(r)
% Residualerne skal følge en 'pæn' fordeling, så vi kan teste om
% fordelingen ligner normalfordelingen. Da residualerne ligger nogenlunde
% på en ret linje i normalfordelingsplottet kommer de fra en pæn fordeling.
% 
% Residualanalysen viser alt i alt, at modelantagelserne holder.

