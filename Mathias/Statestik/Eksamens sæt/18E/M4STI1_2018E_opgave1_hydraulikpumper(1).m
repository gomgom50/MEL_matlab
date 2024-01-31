%% Eksamen M4STI1 2018E opgave 1: Hydrauliske pumper til eksoskelettet
clear; close all; clc; format compact;

%% Oplysninger fra opgaveformuleringen
mu = 105      % Oplyst populations-middelværdi
sigma = 5.0   % Oplyst populations-standardafvigelse

%% Indlæs og behandl data
Y = xlsread('Data_M4STI1_2018E.xlsx','A:A')
n = size(Y,1)

%% a: Stikprøve-middelværdi og -standardafvigelse
y_streg = mean(Y)   % y_streg = 103.1250
s = std(Y)          % s = 4.9407

% Stikprøve-middelværdien på y_streg = 103.1250 er en anelse under den
% oplyste middelværdi på 105 bar. Tilsvarende er
% stikprøve-standardafvigelsen s = 4.9407 en anelse under den oplyste værdi
% på 5.0 bar. Specifikationerne ser umiddelbart troværdige ud. 


%% b: Stem-and-leaf diagram, boksplot og histogram
stemleafplot(Y)

figure(1)
boxplot(Y)
title('Boxplot over 8 hydraulikpumper');
ylabel('Målt maksimalt tryk (bar)');

figure(2)
histogram(Y,[90:5:120])
title('Histogram over 8 hydraulikpumper');
xlabel('Målt maksimalt tryk (bar)');
ylabel('Antal pumper');
% Diagrammerne viser alle, at stikprøven kommer fra en 'pæn' fordeling, der
% godt kunne ligne normalfordelingen. Den er nogenlunde symmetrisk med et
% enkelt toppunkt og uddøende haler. Boxplottet har median 103, symmetrisk 
% 'Interkvartil range' omkring medianen og symmetriske koste. 


%% c: Er stikprøven plausibel?
% Det følger af den centrale grænseværdisætning, at y_streg er 
% normalfordelt med middelværdi mu og standardafvigelse sigma/sqrt(n), 
% hvis n er tilstrækkelig stor. Derfor er z0 = (y_streg-mu)/(sigma/sqrt(n)) 
% standard normalfordelt: 
z0 = (y_streg-mu)/(sigma/sqrt(n))           % z0 = -1.0607

% Sandsynligheden for at få en stikprøve med z0 = -1.0607 eller mere
% ekstrem svarer til at få |z0| > 1.0607 (d.v.s. enten mindre end -1.0607
% eller større end 1.0607):
P_stikproeve = 2*(1 - normcdf(abs(z0)))     % P_stikproeve = 0.2888

% Det er altså slet ikke usandsynligt, at få en stikprøve som vores, hvis
% leverandørens specifikationer er korrekte. Det kan forventes i knap 29%
% af stikprøver. 


%% d: Konklusion og antagelser
% Stikprøven underbygger leverandørens specifikationer. 
% I delspørgsmål a. så vi at stikprøvens gennemsnit og standardafvigelse
% er tæt på de oplyste værdier. 
% I delspørgsmål c. så vi, at stikprøven er sandsynlig for en population
% med mu = 105 bar og sigma = 5.0 bar. Det konkluderede vi under antagelse
% af den centrale grænseværdisætning, som forudsætter, at n = 8 er
% tilstrækkelig stor.
% I delspørgsmål b. så vi, at stikprøven kommer fra en pæn fordeling:
% symmetrisk, med et enkelt toppunkt og ingen outliers. Derfor er n = 8
% stor nok til at den centrale grænseværdisætning er opfyldt. Dette bekræftes 
% yderligere af et normalfordelingsplot, der viser at observationerne 
% ligger nogenlunde på en ret linje:  
normplot(Y)


%% e: 99% konfidensinterval for populationsmiddelværdien mu
% Når vi ikke kan bruge leverandørens oplyste standardafvigelse sigma, må
% vi beregne konfidensintervallet, hvor stikprøvestandardafvigelsen s
% indgår. Formlen er: 
% y_streg +/- t_alfahalve*s*sqrt(1/n)

alfa = 0.01
t_alfahalve = tinv(1-alfa/2, n-1)       % t_alfahalve = 3.4995
ki_bredde = t_alfahalve*s*sqrt(1/n)     % ki_bredde = 6.1129
ki_lav = y_streg - ki_bredde            % ki_lav = 97.0121
ki_hoej = y_streg + ki_bredde           % ki_hoej = 109.2379
% 99% konfidensinterval: [97.0; 109.2]


%% f: 99% prædiktionsinterval:
pi_bredde = t_alfahalve*s*sqrt(1 + 1/n) % pi_bredde = 18.3388
pi_lav = y_streg - pi_bredde            % pi_lav = 84.7862
pi_hoej = y_streg + pi_bredde           % pi_hoej = 121.4638
% 99% prædiktionsinterval: [84.8; 121.5]


%% g: Stikprøvestørrelse, så konfidensintervallets bredde er højst 6.0
% N.B. Denne opgave viste sig at være formuleret, så den var for svær at
% regne. Det blev der taget hensyn til i bedømmelsen. Problemet er, at der
% står i opgaven, at man skal benytte stikprøven og se bort fra leverandørens 
% specifikationer af middelværdi og standardafvigelse for pumperne. 

% Hvis der ikke havde stået det, kunne vi benytte populations-
% standardafvigelsen sigma=5.0 og formlen: n_ny = (z_alfahalve*sigma/B)^2
% Så kunne opgaven løses sådan: 
B = 6.0/2                           % Med B = 3.0 bliver den totale 
                                    % intervalbredde 6.0
z_alfahalve = norminv(1-alfa/2)     % z_alfahalve = 2.5758
n_ny = (z_alfahalve*sigma/B)^2      % n_ny = 18.4303
% Vi runder op til nærmeste heltal, så intervalbredden er højst 6.0 
n_ny_min = ceil(n_ny)               % n_ny_min = 19

% Men som sagt benyttes her leverandørens specifikationer sigma=5.0. 
% Hvis vi benytter stikprøvestandardafvigelsen s=4.9407, skal vi bruge
% t-fordeling i stedet for standard normalfordeling:
% t_alfahalve = tinv(1-alfa/2, n-1).
% Problemet er at t_alfahalve afhænger af stikprøvestørrelsen n. Derfor kan
% vi ikke udtrykke stikprøvestørrelsen som funktion af bredden (vi kan
% ikke isolere n i formlen).

% Her er den korrekte (men for svære) løsning af opgaven:
% I stedet for at udtrykke stikprøvestørrelsen som funktion af bredden, så 
% løber jeg igennem en løkke, hvor bredden beregnes for større og større
% stikprøvestørrelse, indtil bredden er kommet under de ønskede (B = 3.0):
n_ny = 0;                % Jeg starter med mindst mulig stikprøvestørrelse
bredde = 99999;          % Bredden sættes til en tilpas stor startværdi
while bredde > B
    n_ny = n_ny + 1;
    t_alfahalve = tinv(1-alfa/2, n_ny);       
    bredde = t_alfahalve*s*sqrt(1/n_ny);    
    % Variablen 'bredde' angiver konfidensintervallets halve bredde når 
    % stikprøvestørrelsen er n_ny. Nu skal vi teste om bredde er kommet
    % under B, så vi er færdige, eller om skal fortsætte i løkken og forøge 
    % stikprøvestørrelsen. 
end
bredde      % bredde = 2.9692
n_ny        % n_ny = 22
% Altså: når n_ny kommer op på 22, så kommer den halve bredde under 3.0, så
% den totale bredde af konfidensintervallet kommer under 6.0





