%% Opgave 1 (Spr�jtemaling)

clc; clear all; close all;

%% Baggrundsviden
antal_pr_m2 = 0.8 % Antal helligdage per kvadratmeter
antal_skiver = 70
diameter = 1.2

%% a 
% Antal helligdage pr skive
areal_skive = pi*(diameter/2)^2
antal_pr_skive = antal_pr_m2*areal_skive

% svar: lambda = 0.9048


%% b 
% Hvilken fordeling?
% Svar: Poisson fordelingen
Middelvaerdi = antal_pr_skive
varians = antal_pr_skive
spredning = sqrt(varians)

% svar: Poisson; mu = 0.9048, var = 0.9048, std = 0.9512



%% c 
% Sandsynlighed for ingen helligdage p� nogen af skiverne
p_0_1 = poisspdf(0, antal_pr_skive)
p_0_70 = (p_0_1)^70
p_0_70_alternativ = poisspdf(0, 70*antal_pr_skive)

%svar: p_0_70 = 3.1201e-28


%% d 
% Forventet hyppighed af antal helligdage
x = 0:1:3
p = poisspdf(x, antal_pr_skive) % p indeholder sands. for hhv. 0, 1, 2 og 3 helligdage
p = [p, [1-sum(p)]]             % Nu tilf�jes sands. for 4 eller flere
E = antal_skiver * p    % Forventet hyppighed
tot = sum(E)            % Test; summen af hyppighederne b�r v�re 70

% Svar: Forventede hyppigheder for skiver med 0, 1, 2, 3 og 4+ helligdage:
% E = [28.3242 25.6271 11.5934 3.4965 0.9587]


%% e 
% Goodness of Fit test
% Da forventet antal skiver med 4 eller flere helligdage er under 3 reducerer
% vi til 4 kategorier ved at sl� de sidste to sammen: 0, 1, 2, 3 eller flere)

O = [22 31 10 7]
E = [28.3242 25.6271 11.5934 (3.4965 + 0.9587)]

% 1. Hypoteser 
% H0: Antal helligdage p� en skive f�lger en poissonfordeling med 
%     lambda = antal_pr_skive = 0.9048
% Ha: Antal helligdage p� en skive f�lger ikke denne fordeling

%2. Teststatistik
% Summen af (Oi-Ei)^2/Ei for alle i er chi-i-anden fordelt med df frihedsgrader,
% hvor df = k-p-1. k er antal kategorier (4), p antal parametre til 
% fordelingen, som vi har estimeret ud fra observationerne (p=0, vi kendte 
% nemlig lambda), s� df = 4-0-1 = 3

% 3. Kritisk gr�nse 
% Vi forkaster H0, hvis testv�rdien chi2test er st�rre end gr�nsev�rdien 
% chi2_0:
alpha = 0.01
df = 4-0-1
chi2_0 = chi2inv(1-alpha,df)

% 4. Beregne testv�rdi
chi2test = sum(((O - E).^2)./E)

% 5. Konklusion
% chi2test = 4.2111
% chi2_0 = 11.3449
% Testst�rrelsen er ikke over den kritiske gr�nse, derfor kan vi ikke
% forkaste nulhypotesen. Antal helligdage f�lger alts� den formodede
% poissonfordeling 

pvalue = 1 - chi2cdf(chi2test, df)

% Dette bekr�ftes af p-v�rdien, der ogs� er langt over 0.01, nemlig 0.2396


