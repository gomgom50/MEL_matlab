%% M4STI E2015 opgave 2 om bilers NOx udledning
clc; clear all; close all;


%% a Hypotesetest
%  skridt 1
mu0 = 0.08
%  H0:  my = mu0
%  Ha:  my > mu0
% Bilproducenten er bekymret for om middelv�rdien er over den tilladte p� 
% 0.08, s� vi v�lger ensidig test med Ha:  my > mu0

%% b
% Skridt 2
% Vi kender ikke populations-spredningen, s� vi estimerer den som s ud fra
% stikpr�ven. Derfor er testst�rrelsen t t-fordelt med n-1 frihedsgrader:
% t = (y_streg - mu0)/(s/sqrt(n))

% skridt 3
alpha = 0.05
% Vi ved at der testes p� n=10 biler
n = 10
df = n-1  

%% c
% Kritisk gr�nse t0 for ensidig hypotesetest til h�jre
t0 = tinv(1-alpha, n-1)

% skridt 4
% Nu kan vi indl�se data og beregne testst�rrelsen
y = xlsread('M4STI1_2015E_data.xlsx', 'A:A')
n_test = size(y,1) % tester at der er indl�st 10 observationer

y_streg = mean(y)
sumy2 = sum(y .* y)
s2 = (n*sumy2 - (sum(y))^2)/(n*(n-1))
s = sqrt(s2)
% Testst�rrelsen
t = (y_streg - mu0)/(s/sqrt(n))


% Skridt 5
% testst�rrelsen t = 2.5822 er st�rre end den �vre kritiske gr�nse,
% t0 = 1.8331, s� vi forkaster H0 p� baggrund af stikpr�ven. Bilerne
% udleder for meget NOx. 

% p-v�rdi:
pValue = 1 - tcdf(t, n-1)


%% d
% 95 pct. konfidensinterval
t_alphahalf = -tinv(alpha/2, n-1)
CI_width = t_alphahalf*s/sqrt(n)

CI_low = y_streg - CI_width
CI_high = y_streg + CI_width

%% e
% 95 pct. pr�diktionsinterval
PI_width = t_alphahalf*s*sqrt(1 + 1/n)

PI_low = y_streg - PI_width
PI_high = y_streg + PI_width

%% f
% Antagelser
% Vi har antaget den centrale gr�nsev�rdis�tning, som siger, at
% testst�rrelsen f�lger t-fordelingen hvis n er tilstr�kkelig stor. Hvor
% stor n beh�ver at v�re afh�nger af, hvor p�n fordelingen, som stikpr�ven
% kommer fra, er. 

stemleafplot(y,-3)
% Stem-and-leaf plottet viser at data kommer fra en p�n fordeling med et
% enkelt toppunkt, nogenlunde symmetrisk og med hurtigt udd�ende haler

normplot(y)
% Normalfordelingsplottet viser ikke en s�rligt line�r sammenh�ng, s� vi 
% er ikke overbevist om, at stikpr�vens fordeling ligner normalfordelingen. 
% Det er lidt bekymrende, at der kun er 10 observationer i stikpr�ven. 
% Med over 30 observationer ville vi v�re n�sten sikre p�, at den centrale 
% gr�nsev�rdis�tning holder. Det kan derfor anbefales, at bilproducenten 
% foretager NOx m�lingen p� flere biler for at v�re mere sikker p�, at 
% modelantagelserne holder. 