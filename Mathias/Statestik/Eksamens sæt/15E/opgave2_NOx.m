%% M4STI E2015 opgave 2 om bilers NOx udledning
clc; clear all; close all;


%% a Hypotesetest
%  skridt 1
mu0 = 0.08
%  H0:  my = mu0
%  Ha:  my > mu0
% Bilproducenten er bekymret for om middelværdien er over den tilladte på 
% 0.08, så vi vælger ensidig test med Ha:  my > mu0

%% b
% Skridt 2
% Vi kender ikke populations-spredningen, så vi estimerer den som s ud fra
% stikprøven. Derfor er teststørrelsen t t-fordelt med n-1 frihedsgrader:
% t = (y_streg - mu0)/(s/sqrt(n))

% skridt 3
alpha = 0.05
% Vi ved at der testes på n=10 biler
n = 10
df = n-1  

%% c
% Kritisk grænse t0 for ensidig hypotesetest til højre
t0 = tinv(1-alpha, n-1)

% skridt 4
% Nu kan vi indlæse data og beregne teststørrelsen
y = xlsread('M4STI1_2015E_data.xlsx', 'A:A')
n_test = size(y,1) % tester at der er indlæst 10 observationer

y_streg = mean(y)
sumy2 = sum(y .* y)
s2 = (n*sumy2 - (sum(y))^2)/(n*(n-1))
s = sqrt(s2)
% Teststørrelsen
t = (y_streg - mu0)/(s/sqrt(n))


% Skridt 5
% teststørrelsen t = 2.5822 er større end den øvre kritiske grænse,
% t0 = 1.8331, så vi forkaster H0 på baggrund af stikprøven. Bilerne
% udleder for meget NOx. 

% p-værdi:
pValue = 1 - tcdf(t, n-1)


%% d
% 95 pct. konfidensinterval
t_alphahalf = -tinv(alpha/2, n-1)
CI_width = t_alphahalf*s/sqrt(n)

CI_low = y_streg - CI_width
CI_high = y_streg + CI_width

%% e
% 95 pct. prædiktionsinterval
PI_width = t_alphahalf*s*sqrt(1 + 1/n)

PI_low = y_streg - PI_width
PI_high = y_streg + PI_width

%% f
% Antagelser
% Vi har antaget den centrale grænseværdisætning, som siger, at
% teststørrelsen følger t-fordelingen hvis n er tilstrækkelig stor. Hvor
% stor n behøver at være afhænger af, hvor pæn fordelingen, som stikprøven
% kommer fra, er. 

stemleafplot(y,-3)
% Stem-and-leaf plottet viser at data kommer fra en pæn fordeling med et
% enkelt toppunkt, nogenlunde symmetrisk og med hurtigt uddøende haler

normplot(y)
% Normalfordelingsplottet viser ikke en særligt lineær sammenhæng, så vi 
% er ikke overbevist om, at stikprøvens fordeling ligner normalfordelingen. 
% Det er lidt bekymrende, at der kun er 10 observationer i stikprøven. 
% Med over 30 observationer ville vi være næsten sikre på, at den centrale 
% grænseværdisætning holder. Det kan derfor anbefales, at bilproducenten 
% foretager NOx målingen på flere biler for at være mere sikker på, at 
% modelantagelserne holder. 