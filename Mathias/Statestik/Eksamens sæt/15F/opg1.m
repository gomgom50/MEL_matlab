%% Opgave 1

%% a
% Hvis stikprøven er repræsentativ for hele produktionen er 1.5 ud af 25
% defekte. Dvs. 
p = 1.5/25

% Sandsynligheden for at en tilfældig skivebremse er defekt er 0.06, 
% dvs. 6% er defekte

%% b
% Antal defekte skivebremser i en stikprøve følger en binomialfordeling, 
% hvor vi tæller antal 'succeser', dvs. antal defekte skivebremser i 
% stikprøven på 25
n = 25
p_0 = binopdf(0,n,p)

% Sandsynligheden for 0 defekte i på en given dags stikprøve er 0.2129

%% c
% Sandsynligheden for 2 eller flere defekte er det komplementære til
% sandsynligheden for 0 eller 1 defekte. 
% p_mindst2 = 1 - p_0 - p_1

p_1 = binopdf(1,n,p)
p_mindst2 = 1 - p_0 - p_1

% Sandsynligheden for 2 eller flere defekte i dagens stikprøve er 0.4473

%% d
% Middelværdi for binomialfordelingen: 
mu = n*p
sigma2 = n*p*(1-p)
sigma = sqrt(sigma2)

% middelværdi = 1.5 
% varians = 1.4100
% spredning = 1.1874
