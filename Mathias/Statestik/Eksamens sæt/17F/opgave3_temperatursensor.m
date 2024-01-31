%% Opgave 3: NTC termistor
clc; clear; close all; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2017F.xlsx','A:B')
t = D(:,1)  % temperatur t
M = D(:,2)  % modstand M


%% a: Lineær regression
mdl1 = fitlm(M,t)

figure(1)
plot(mdl1)
title('Lineær model: t = b0 + b1*M');
xlabel('Modstand M (1000 ohm)');
ylabel('temperatur (grader C)');

coeff = table2array(mdl1.Coefficients)
b0 = coeff(1,1)
b1 = coeff(2,1)

% Regressionsligning:
% t_lin = 36.8460 - 1.5257*M   % t_lin: temperatur beregnet med lineær funk.

t_lin_10 = b0 + b1*10.0
% Den forventede temperatur, der svarer til en målt modstand på 10.0
% kilo-ohm er 21.5889 ~ 21.6 grader Celsius


%% b
% Det er en god model, bedømt ud fra statistikkerne. R-squared er 0.901, så
% modellen forklarer 90% af variationen i data. Adjusted R-squared er
% 0.889, hvilket også er tilfredsstillende højt. P-værdierne for begge
% koefficienter er tæt på nul, så for begges vedkommende kan vi afvise 
% nulhypotesen om, at de i virkeligheden er 0. Regressionsligningen har
% altså både en skæring med 2-aksen og en hældningskoefficient. 
% Anova-analysen giver en F-værdi på 72.8. Hertil svarer en p-værdi på
% 2.74e-05, altså tæt på 0. Det er således nærmest umuligt, at der ikke er
% en korrelation mellem M og t. 
% Når man plotter data sammen med regressionsligningen er det dog tydeligt,
% at sammenhængen mellem M og t ikke er lineær. 


%% c
% 2-gradspolynomium
M2 = M.^2
mdl2 = fitlm([M, M2],t)

% Alternativt kan Wilkinson notation bruges:
% mdl2 = fitlm(M, t, 'y~x1 + x1^2')

% Funktionsudtryk: 
t_pol = 46.869 - 3.376*M + 0.055853*M.^2 % t_pol: temp. beregnet med polynomium
t_pol_10 = 46.869 - 3.376*10.0 + 0.055853*(10.0)^2
% t_pol_10 = 18.69

% logaritmisk transformation
log_M = log(M)
mdl3 = fitlm(log_M,t)

% Funktionsudtryk: 
% t_log = 61.707 - 19.39*log(M)
t_log_10 = 61.707 - 19.39*log(10.0)
% t_log_10 = 17.06


%% d
% Scatterplots polynomiel model
figure(2)
plot(mdl2)
title('Polynomiel model: t = b0 + b1*M + b2*M^2');
xlabel('Modstand M (1000 ohm)');
ylabel('temperatur (grader C)');

% Scatterplots logaritmisk model
figure(3)
plot(mdl3)
title('Logaritmisk model: t = b0 + b1*ln(M)');
xlabel('ln(M)');
ylabel('temperatur t (grader C)');

% Residualplots polynomiel model: 

res_pol = mdl2.Residuals.Studentized
t_pol = 46.869 - 3.376*M + 0.055853*M.^2

figure(4)
normplot(res_pol)

figure(5)
scatter(t_pol, res_pol)
title('Studentiserede residualer for polynomiel model');
xlabel('Estimeret temperatur');
ylabel('R-Student');

% Residualplots logaritmisk model: 

res_log = mdl3.Residuals.Studentized
t_log = 61.707 - 19.39*log(M)

figure(6)
normplot(res_log)

figure(7)
scatter(t_log, res_log)
title('Studentiserede residualer for logaritmisk model');
xlabel('Estimeret temperatur');
ylabel('R-Student');


%% e: 
% Begge modeller er gode og forklarer næsten al variationen i data 
% (R^2 er hhv. 0.987 og 0.998. Adjusted R^2 er næsten samme værdi). 
% Alle koefficienter er stærkt signifikante i begge modeller. Begge
% modeller er gode fits af data og kan forsvares. 
% Jeg foretrækker den logaritmiske model, fordi den trods alt har højest
% R^2 og Adjusted R^2. Desuden er jeg mest tryg ved residualanalysen for
% den logaritmiske model: I normalfordelingsplottet for den logaritmiske
% model ser residualerne ud til at ligge pænere på en ret linje, så 
% antagelsen om normalfordelte residualer er mere overbevisende. Desuden
% ser residualerne helt tilfældige ud i residualplottet for den
% logaritmiske model. I residualplottet for den polynomielle model ser de
% også tilfældige ud, i hvert fald er der hverken kurve- eller tragt-formet
% tendens, men der er en tendens til at residualerne ligger som en slange,
% så et residual muligvis afhænger af det forrige. 
% Alt i alt: Jeg foretrækker den logaritmiske model. 