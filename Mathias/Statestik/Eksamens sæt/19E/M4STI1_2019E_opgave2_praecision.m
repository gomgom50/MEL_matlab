%% Opgave 2: Pr�cisionen af printede emner
clc; clear; close all; format compact; 


%% Indl�s data
D = xlsread('Data_M4STI1_2019E', 'A:B')
oensket = D(:,1)
opnaaet = D(:,2)
n = size(D,1)


%% a. Beregn afvigelse (delta) og plot afvigelsen som funktion af �nsket bredde
delta = oensket - opnaaet

figure(1)
scatter(oensket, delta)
lsline
title('Plot af afvigelse mod �nsket bredde')
xlabel('�nsket bredde')
ylabel('Afvigelse')


%% b. Kan afvigelsen beskrives som en line�r funktion af �nsket bredde?
mdl = fitlm(oensket, delta)
% Der er ikke en line�r sammenh�ng. Begge estimater af koefficienterne er 
% ikke signifikant forskellige fra 0 (p-v�rdier hhv. 0.234 og 0.141). 
% R-squared er kun 0.0958, s� under 10 % af variationen beskrives af
% modellen. 


%% c. Er afvigelsen normalfordelt med middelv�rdi 0?
delta_streg = mean(delta)
% Jeg ville forvente, at middelv�rdien af afvigelsen ville v�re t�ttere
% p� 0, hvis det var normalfordelt st�j. Den er 0.14 mm. 
% Det tyder p�, at den opn�ede bredde generelt er lidt under den �nskede.

figure(2)
histogram(delta, 8)
title('Histogram over afvigeleser')
ylabel('Antal')
xlabel('Afvigelse')
% Fordelingen af afvigelsen ser ud til at have et enkelt toppunkt, men 
% ikke s�rlig symmetrisk. Fordelingen er h�jresk�v. 

figure(3)
normplot(delta)
% Data ligger ikke p� en linje i normalfordelingsplottet, s� afvigelserne
% tyder ikke p� at v�re normalfordelte


%% d. Estimering af lambda
absdelta = abs(delta)     % Den numeriske (absolutte) v�rdi af afvigelsen
mu_hat = mean(absdelta)
lambda_hat = 1/mu_hat
% Estimatet for mu er 0.35 
% Estimatet for lambda er 2.8571


%% e. Histogram
figure(4)
histogram(absdelta, 7)
% Antagelsen ser rimelig ud. Den f�rste kolonne er h�jst og s� bliver de
% generelt lavere og lavere


%% Goodness of fit test
%% f. Beregn gr�nserne for k=5 kategorier, s� der forventes n/k i hver
k = 5
k0 = 0
k1 = expinv(1/5, mu_hat)
k2 = expinv(2/5, mu_hat)
k3 = expinv(3/5, mu_hat)
k4 = expinv(4/5, mu_hat)
k5 = Inf    % Inf er uendelig
kateg = [k0, k1, k2, k3, k4, k5]
% Her er de 5 kategorier:
% 1: k0 til k1:     [0; 0.0781[
% 2: k1 til k2:     [0.0781; 0.1788[
% 3: k2 til k3:     [0.1788; 0.3207[
% 4: k3 til k4:     [0.3207; 0.5633[
% 5: k4 til k5:     [0.5633; Inf[


%% g. Vis antal observerede O og antal forventede E for de k kategorier (evt. vha Excel)
% Man kan sortere absdelta med funktionen sort() og s� fordele de 24 
% observationer i de 5 kategorier. F.eks. er der 2 observationer i f�rste 
% kategori, nemlig de 2 med v�rdien 0. 
% I anden kategori er der 7 observationer, der alle har v�rdien 0.1. 
% O.s.v. for de resterende kategorier. Vi f�r: 
% O = [2, 7, 8, 2, 5]

% Alternativt kan man bruge funktionen histcounts:
O = histcounts(absdelta, kateg)
E = ones(1, k)*n/k % Vi har lavet kategorierne, s� der forventes n/k i hver

resultat = [ kateg(1:5)', kateg(2:6)', O', E' ]
table = array2table(resultat, 'Variablenames', {'Fra', 'Til', 'O', 'E'})


%% h. Opstil hypoteser for testen
% H0: De absolutte afvigelser f�lger eksponentialfordelingen
% Ha: De absolutte afvigelser f�lger *ikke* eksponentialfordelingen


%% i. Opstil testst�rrelsens fordelig og beregn den kritiske v�rdi
% Testst�rrelsen f�lger en Chi-i-anden fordeling med k - p -1
% frihedsgrader, hvor k er antal kategorier (k = 5) og p er antal
% estimerede parametre (vi har estimeret lambda, s� p = 1)
alfa = 0.05
p = 1
df = k - p - 1      % df = 5 - 1 - 1 = 3
chi2_kritisk = chi2inv(1-alfa,df)  % chi2_kritisk = 7.8147 


%% j Beregn testst�rrelsen og konkluder
chi2_0 = 0;
for i=1:k
    chi2_0 = chi2_0 + (O(i) - E(i))^2 / E(i);
end
chi2_0
% chi2_0 = 6.4167

p_vaerdi = 1 - chi2cdf(chi2_0, df)
% p_vaerdi = 0.0930

% Konklusion: Da testst�rrelsen chi2_0 = 6.4167 ikke overstiger den
% kritiske v�rdi chi2_kritisk = 7.8147 kan vi ikke forkaste nulhypotesen
% H0. Dermed kan vi tro p�, at den absolutte afvigelse f�lger
% eksponentialfordelingen. Dog er p-v�rdien 0.0930 ikke s�rligt stor. Det
% er ikke langt fra, at vi m�tte forkaste nulhypotesen. 