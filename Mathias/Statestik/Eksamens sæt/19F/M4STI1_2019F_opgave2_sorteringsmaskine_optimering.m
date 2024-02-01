%% Eksamen M4STI1 2019F opgave 2: Optimering af sorteringsmaskinens vinkel 
%% og rotationshastighed
clear; close all; clc; format compact;

%% Indl�sning af data
D = xlsread('Data_M4STI1_2019F.xlsx', 'A:C')
vinkel = D(:,1)     % Vinkel p� pladerne, der skal sortere plastikken
rothast = D(:,2)    % Rotationshastighed for pladerne
effekt = D(:,3)     % Sorteringseffektivitet
n = size(D,1)       % Antal observationer i datas�ttet


%% a: Scatter plots
figure(1)
scatter(vinkel, effekt, 'filled')
lsline
title('Sorteringseffektivitet som funktion af sorteringspladernes vinkel')
xlabel('Vinkel (theta) [grader]')
ylabel('Sorteringseffektivitet (%)')
axis([10, 50, 50, 100])
% Der lader til at v�re en sammenh�ng mellem vinkel og sorteringseffekt, 
% men den er ikke line�r.
% Sorteringseffektiviteten er h�j ved 25 og 35 grader, men lav ved 15 og 45
% grader. Formodentlig er en polynomiel sammenh�ng bedre. 

figure(2)
scatter(rothast, effekt, 'filled')
lsline
title('Sorteringseffektivitet som funktion af rotationshastighed')
xlabel('Rotationshastighed (omega) [s^{-1}]')
ylabel('Sorteringseffektivitet (%)')
axis([0, 3.5, 50, 100])
% Der lader til at v�re en positiv korrelation mellem rotationshastighed
% og sorteringseffekt, men den er meget svag. 


%% b: Multipel line�r regression
mdl = fitlm([vinkel, rothast], effekt)
% Regressionsligning:
% effekt = 70.57 + 0.052*vinkel + 2.0689*rothast


%% c: Forklaring
% Modellen er d�rlig til at beskrive data. Det er kun koefficienten b0 =
% 70.57 (dvs. sk�ringen med y-aksen), der er signifikant forskellig fra 0. 
% B�de b1 = 0.052 og b2 = 2.0689 har h�je p-v�rdier (hhv. 0.79 og 0.42), s� 
% de kunne lige s� godt v�re 0. Der er alts� ingen signifikant korrelation. 
% Det samme resultat kommer af ANOVA testen. F-testst�rrelsen er 0.375 og
% den tilh�rende p-v�rdi er 0.693, s� b�de b1 og b2 kan sagtens v�re 0
% samtidig. 
% R-squared = 0.0423 fort�ller ligeledes, at modellen er d�rlig, da den kun
% beskriver 4 % af variationen i data. 


%% d: Udvidet model
% Jeg udvider modellen med kvadratled og interaktionsled vha. Wilkinson 
% notation: 

mdl1 = fitlm([vinkel, rothast], effekt, 'y ~ x1 + x2 + x1^2 + x2^2 + x1:x2')

% Jeg v�lger et signifikansniveau p� 5 %. Der er flere koefficienter, der
% ikke er signifikante: b2, b12 og b22 kan alle v�re lig 0, da de har
% p-v�rdier over 0.05. b22 = -0.18542 har den h�jeste p-v�rdi p� 0.8806, s�
% den er mindst signifikant. Den fjerner jeg fra modellen:

mdl2 = fitlm([vinkel, rothast], effekt, 'y ~ x1 + x2 + x1^2 + x1:x2')	

% Nu er koefficienterne b2 og b12 ikke signifikante, selvom b2 er t�t p�
% med p-v�rdi = 0.063813. Jeg fjerner leddet for interaktion, da b12 har
% den st�rste p-v�rdi, nemlig 0.21322:

mdl3 = fitlm([vinkel, rothast], effekt, 'y ~ x1 + x2 + x1^2')
% Nu er alle koefficienter for h�ldningskoefficienter signfikant forskellige
% fra 0. R-squared er kun reduceret fra 0.886 til 0.873 fra den fulde model 
% til denne. Selv om plots fra delopgave a viser meget varians i data, s� 
% forklarer modellen alts� 87 % af det. Samtidig er Adjusted R-Squared
% steget en anelse fra 0.846 til 0.849. Den model v�lger jeg.


%% e: Modelforskrift
% effekt = 6.2447 + 5.032*vinkel + 2.0689*rothast - 0.083*(vinkel)^2
effekt_est = 6.2447 + 5.032 * 28 + 2.0689 * 2.5 - 0.083 * (28)^2
% effekt_est = 87.2409


%% f - Optimal vinkel 
% Modellens formel:  
% effekt = b0 + b1*vinkel + b2*rothast + b11*(vinkel)^2
% Ligningen differentieres partielt mht. vinkel, s�ttes lig 0 og l�ses for
% at bestemme optimal v�rdi af vinkel:
% d(effekt)/d(vinkel) = 0 + b1 + 0 + 2*b11*vinkel = 0 =>
% vinkel = -b1/(2*b11) 
b1 = 5.032
b11 = -0.083
vinkel_opt = -b1/(2*b11) 
% vinkel_opt = 30.3133

% En alternativ (men mindre kvalificeret) l�sning kunne v�re at afl�se den
% optimale vinkel i scatterplottet fra delsp�rgsm�l a. Her lader toppunktet
% til at v�re cirka midt imellem 25 og 35 grader, alts� vinkel_opt = 30 et
% godt bud. 


%% g: Unormale punkter
lev = mdl3.Diagnostics.Leverage;     % hat diagonal
rst = mdl3.Residuals.Studentized;    % R-Student
nr = (1:n)';                         % Observationsnummer
% Jeg samler det hele til en resultattabel:
resultat = [nr, vinkel, rothast, effekt, lev, rst]            

k = 3;                  % Der er tre regressorer (vinkel, rothast og (vinkel)^2)
lev_limit = 2*(k+1)/n   % lev_limit = 0.4

% Der er ingen l�ftestangspunkter, for ingen har lev > lev_limit = 0.4.
% Der er ingen outliers, for ingen har |rst| > 3.
% Dermed er der heller ingen indflydelsespunkter. 




