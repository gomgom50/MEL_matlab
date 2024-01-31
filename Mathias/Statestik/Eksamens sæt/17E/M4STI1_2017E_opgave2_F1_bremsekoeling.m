%% M4STI1 2017E Opgave 2: Nedkøling af Formel 1 bremser
clc; clear; close all; format compact; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2017E.xlsx','G:H')
O = D(:,2)
% O er de observerede antal. Til Goodness of Fit testen skal vi sammenligne
% O med E, der er det forventede observerede antal, hvis antagelsen om
% normalfordeling er korrekt


%% a: Vurdering
% Hvis antagelsen om normalfordeling er korrekt vil vi forvente flest
% observationer omkring middelværdien på 231 grader C og færre jo længere
% væk fra middelværdien. Det stemmer godt overens med antal observationer
% vist i tabellen. Det kan også illustreres med et søjlediagram:
figure(1)
bar(D(:,1),O)
title('Antal observationer i 5 temperaturintervaller');
xlabel('Temperaturinterval nummer')
ylabel('Antal målinger')

% Fordelingen på de fem intervaller ser nogenlunde symmetrisk ud, og den 
% har toppunkt i midten - i den tredje kategori, hvor også middelværdien 
% hører til. Det ser plausibelt ud, at data kommer fra en normalfordeling. 
% Da tabellen viser aggregerede tal, ikke de 850 målinger, giver det ikke
% mening at lave normplot. 



%% b: Sandsynligheder for temperaturintervallerne
mu = 231
sigma = 42
P_u150 = normcdf(150, mu, sigma)      
% P_u150 = 0.0269
P_m150og200 = normcdf(200, mu, sigma) - normcdf(150, mu, sigma)          
% P_m150og200 = 0.2033
P_m200og250 = normcdf(250, mu, sigma) - normcdf(200, mu, sigma)          
% P_m200og250 = 0.4443
P_m250og300 = normcdf(300, mu, sigma) - normcdf(250, mu, sigma)          
% P_m250og300 = 0.2753
P_o300 = 1 - normcdf(300, mu, sigma)
% P_o300 = 0.0502

% Test: Summen af sandsynlighederne skal give 1
P_test = P_u150 + P_m150og200 + P_m200og250 + P_m250og300 + P_o300


%% c: Forventet antal nedbremsninger i de fem temperaturintervaller
n = 850
n_u150 = n*P_u150
% n_u150 = 22.8582
n_m150og200 = n*P_m150og200
% n_m150og200 = 172.8358
n_m200og250 = n*P_m200og250
% n_m200og250 = 377.6333
n_m250og300 = n*P_m250og300
% n_m250og300 = 233.9974
n_o300 = n*P_o300
% n_o300 = 42.6753

% Test: Summen af antal i intervallerne skal give 850
n_test = n_u150 + n_m150og200 + n_m200og250 + n_m250og300 + n_o300

E = [n_u150; n_m150og200; n_m200og250; n_m250og300; n_o300]
% Matricen E er det forventede antal i de fem kategorier, hvis antagelsen
% om normalfordeling er korrekt. Hvis den er det, skal E helst ligne O


%% d: Formel for teststørrelsen
% Teststørrelsen beregnes ved at addere et bidrag for hver kategori (her
% temperaturintervaller). Det i-te bidrag er (O_i - E_i)^2/E_i

% Teststørrelsen chi2_0 kan også beregnes med matlab's matrix
% operationer:

% chi2_0 = sum(((O - E) .^ 2) ./ E)

% Teststørrelsen chi2_0 er chi-i-anden fordelt med df = k-p-1 frihedsgrader. 
% k er antal kategorier, p er antal estimerede parametre. Vi har k = 5
% kategorier (temperaturintervaller) og p = 2 parametre, der er estimeret ud
% fra data (middelværdi = 231 og standardafvigelse = 42), så 
% df = 5 - 2 - 1 = 2. 


%% e: Kritisk grænse

alfa = 0.05
df = 2
chi2_alfa = chi2inv(1-alfa, df)

% Den kritiske grænse chi2_alfa = 5.9915 er den værdi, hvor det gælder, at
% sandsynligheden for at få den værdi, eller noget større er 5% (alfa), 
% hvis antagelsen om normalfordeling er korrekt. Med andre ord, hvis
% teststørrelsen chi2_0 er over den kritiske grænse chi2_alfa, så
% forkaster vi nulhypotesen om, at bremsernes køleevne kan modelleres med
% en normalfordeling. 


%% f: Beregning af teststørrelsen og konklusion
chi2_0 = sum(((O - E) .^ 2) ./ E)

% Da teststørrelsen chi2_0 = 12.5703 er større end den kritiske grænse på
% chi2_alfa = 5.9915 forkaster vi hypotesen om, at bremsernes køleevne er
% normalfordelt. 
