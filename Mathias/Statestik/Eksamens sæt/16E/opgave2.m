%% E2016 Opg 2: Hypotesetest om dronens landingspr�cision
clear all; close all; clc;

% Indl�s data
M = xlsread('Data_M4STI1_2016E.xlsx', 'A:B')
delta_x = M(:,1)
delta_y = M(:,2)

%% a
figure(1)
hold on;
scatter(delta_x, delta_y)
axis([-1.5 1.5 -1.5 1.5])
plot([-1.5; 1.5], [0; 0])   % vandret referencelinje gennem (0,0)
plot([0; 0], [-1.5; 1.5])   % lodret referencelinje gennem (0,0)
title('50 landingers afvigelse fra m�let'); 
xlabel('Afvigelse i x-koordinat (m)');
ylabel('Afvigelse i y-koordinat (m)');
hold off;
% Punkterne lader til at v�re nogenlunde tilf�ldigt fordelt. 
% Der er m�ske en tendens til at v�re mindre variation i �verste, h�jre og
% i nederste, venstre kvadrant.


%% b
r = sqrt(delta_x.^2 + delta_y.^2)

figure(2)
histogram(r,7)
title('Histogram over dronens pr�cision');
xlabel('Afstand fra m�let (m)');
ylabel('Antal landinger');
% Histogrammet ligner ikke eksponentialfordelingen s�rligt godt, da f�rste
% s�jle burde v�re h�jest.


%% Hypotesetest
mu0 = 0.45
alfa = 0.05
n = 50

%% c
% Skridt 1
% H0: mu = mu0
% Ha: mu > mu0
% Formodningen er, at dronen er mere upr�cis end 0.45m, s� vi vil ikke
% forkaste nulhypotesen, hvis stikpr�ven er mindre end 0.45. Derfor ensidet
% hypotesetest. 

%% d
% Skridt 2
% t0 = (r_streg - mu0)/(s/sqrt(n)) 
% t0 er t-fordelt med n-1 frihedsgrader
% r_streg er den gennemsnitlige afstand fra m�let i de 50 flyvninger. 
% s er stikpr�ve-standardafvigelsen. 

%% e
% Skridt 3
t_alfa = tinv(1-alfa,n-1)   
% Kritisk region. Vi forkaster H0, hvis t0 > t_alfa
% t_alfa = 1.6766. 

% Skridt 4
r_streg = mean(r)
s = std(r)
t0 = (r_streg - mu0)/(s/sqrt(n))

% Skridt 5
% Vi f�r en stikpr�ve-middelv�rdi p� r_streg = 0.56, alts� over den
% formodede populationsmiddelv�rdi p� mu0 = 0.45. Hypotesetesten giver, at
% teststatistikken t0 = 2.4309 er st�rre end den kritiske gr�nse p� 
% t_alfa = 1.6766. Derfor kan vi forkaste nulhypotesen p� 5% signifikans-
% niveau. 

%% f. Antagelser
% Vi har antaget den centrale gr�nsev�rdis�tning for at kunne r�sonnere om
% teststatistikken t0. Antagelsen er, at stikpr�ven kommer fra en 'p�n' fordeling. 
% Vi kan teste om den holder med et stem-and-leaf plot
% og med et normalfordelingsplot:
stemleafplot(r,-2)
normplot(r)
% Stem-and-leaf plottet viser en nogenlunde p�n fordeling med et toppunkt
% og udd�ende haler. Normalfordelingsplottet viser en nogenlunde ret linje.
% Vigtigst er det dog, at stikpr�vest�rrelsen p� n = 50 g�r, at den
% centrale gr�nsev�rdis�tning holder, ogs� for mindre p�ne fordelinger. 

%% g: 95 pct. konfidensinterval
 
t_alfahalve = tinv(1-alfa/2, n-1)
CI_bredde = t_alfahalve*s/sqrt(n)

CI_nedre = r_streg - CI_bredde
CI_oevre = r_streg + CI_bredde

% Vi f�r CI_nedre = 0.4689 og CI_oevre = 0.6494, s� 95%
% konfidensintervallet er (0.4689; 0.6494). 
% Det betyder, at vi er 95% sikre p�, at dronens sande landings-pr�cision 
% ligger imellem 0.47 og 0.65 meter. Vi kan bem�rke, at den oplyste
% pr�cision p� 0.45 meter ligger udenfor dette interval. 