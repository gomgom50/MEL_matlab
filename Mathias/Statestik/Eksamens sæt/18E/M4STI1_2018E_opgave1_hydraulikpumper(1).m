%% Eksamen M4STI1 2018E opgave 1: Hydrauliske pumper til eksoskelettet
clear; close all; clc; format compact;

%% Oplysninger fra opgaveformuleringen
mu = 105      % Oplyst populations-middelv�rdi
sigma = 5.0   % Oplyst populations-standardafvigelse

%% Indl�s og behandl data
Y = xlsread('Data_M4STI1_2018E.xlsx','A:A')
n = size(Y,1)

%% a: Stikpr�ve-middelv�rdi og -standardafvigelse
y_streg = mean(Y)   % y_streg = 103.1250
s = std(Y)          % s = 4.9407

% Stikpr�ve-middelv�rdien p� y_streg = 103.1250 er en anelse under den
% oplyste middelv�rdi p� 105 bar. Tilsvarende er
% stikpr�ve-standardafvigelsen s = 4.9407 en anelse under den oplyste v�rdi
% p� 5.0 bar. Specifikationerne ser umiddelbart trov�rdige ud. 


%% b: Stem-and-leaf diagram, boksplot og histogram
stemleafplot(Y)

figure(1)
boxplot(Y)
title('Boxplot over 8 hydraulikpumper');
ylabel('M�lt maksimalt tryk (bar)');

figure(2)
histogram(Y,[90:5:120])
title('Histogram over 8 hydraulikpumper');
xlabel('M�lt maksimalt tryk (bar)');
ylabel('Antal pumper');
% Diagrammerne viser alle, at stikpr�ven kommer fra en 'p�n' fordeling, der
% godt kunne ligne normalfordelingen. Den er nogenlunde symmetrisk med et
% enkelt toppunkt og udd�ende haler. Boxplottet har median 103, symmetrisk 
% 'Interkvartil range' omkring medianen og symmetriske koste. 


%% c: Er stikpr�ven plausibel?
% Det f�lger af den centrale gr�nsev�rdis�tning, at y_streg er 
% normalfordelt med middelv�rdi mu og standardafvigelse sigma/sqrt(n), 
% hvis n er tilstr�kkelig stor. Derfor er z0 = (y_streg-mu)/(sigma/sqrt(n)) 
% standard normalfordelt: 
z0 = (y_streg-mu)/(sigma/sqrt(n))           % z0 = -1.0607

% Sandsynligheden for at f� en stikpr�ve med z0 = -1.0607 eller mere
% ekstrem svarer til at f� |z0| > 1.0607 (d.v.s. enten mindre end -1.0607
% eller st�rre end 1.0607):
P_stikproeve = 2*(1 - normcdf(abs(z0)))     % P_stikproeve = 0.2888

% Det er alts� slet ikke usandsynligt, at f� en stikpr�ve som vores, hvis
% leverand�rens specifikationer er korrekte. Det kan forventes i knap 29%
% af stikpr�ver. 


%% d: Konklusion og antagelser
% Stikpr�ven underbygger leverand�rens specifikationer. 
% I delsp�rgsm�l a. s� vi at stikpr�vens gennemsnit og standardafvigelse
% er t�t p� de oplyste v�rdier. 
% I delsp�rgsm�l c. s� vi, at stikpr�ven er sandsynlig for en population
% med mu = 105 bar og sigma = 5.0 bar. Det konkluderede vi under antagelse
% af den centrale gr�nsev�rdis�tning, som foruds�tter, at n = 8 er
% tilstr�kkelig stor.
% I delsp�rgsm�l b. s� vi, at stikpr�ven kommer fra en p�n fordeling:
% symmetrisk, med et enkelt toppunkt og ingen outliers. Derfor er n = 8
% stor nok til at den centrale gr�nsev�rdis�tning er opfyldt. Dette bekr�ftes 
% yderligere af et normalfordelingsplot, der viser at observationerne 
% ligger nogenlunde p� en ret linje:  
normplot(Y)


%% e: 99% konfidensinterval for populationsmiddelv�rdien mu
% N�r vi ikke kan bruge leverand�rens oplyste standardafvigelse sigma, m�
% vi beregne konfidensintervallet, hvor stikpr�vestandardafvigelsen s
% indg�r. Formlen er: 
% y_streg +/- t_alfahalve*s*sqrt(1/n)

alfa = 0.01
t_alfahalve = tinv(1-alfa/2, n-1)       % t_alfahalve = 3.4995
ki_bredde = t_alfahalve*s*sqrt(1/n)     % ki_bredde = 6.1129
ki_lav = y_streg - ki_bredde            % ki_lav = 97.0121
ki_hoej = y_streg + ki_bredde           % ki_hoej = 109.2379
% 99% konfidensinterval: [97.0; 109.2]


%% f: 99% pr�diktionsinterval:
pi_bredde = t_alfahalve*s*sqrt(1 + 1/n) % pi_bredde = 18.3388
pi_lav = y_streg - pi_bredde            % pi_lav = 84.7862
pi_hoej = y_streg + pi_bredde           % pi_hoej = 121.4638
% 99% pr�diktionsinterval: [84.8; 121.5]


%% g: Stikpr�vest�rrelse, s� konfidensintervallets bredde er h�jst 6.0
% N.B. Denne opgave viste sig at v�re formuleret, s� den var for sv�r at
% regne. Det blev der taget hensyn til i bed�mmelsen. Problemet er, at der
% st�r i opgaven, at man skal benytte stikpr�ven og se bort fra leverand�rens 
% specifikationer af middelv�rdi og standardafvigelse for pumperne. 

% Hvis der ikke havde st�et det, kunne vi benytte populations-
% standardafvigelsen sigma=5.0 og formlen: n_ny = (z_alfahalve*sigma/B)^2
% S� kunne opgaven l�ses s�dan: 
B = 6.0/2                           % Med B = 3.0 bliver den totale 
                                    % intervalbredde 6.0
z_alfahalve = norminv(1-alfa/2)     % z_alfahalve = 2.5758
n_ny = (z_alfahalve*sigma/B)^2      % n_ny = 18.4303
% Vi runder op til n�rmeste heltal, s� intervalbredden er h�jst 6.0 
n_ny_min = ceil(n_ny)               % n_ny_min = 19

% Men som sagt benyttes her leverand�rens specifikationer sigma=5.0. 
% Hvis vi benytter stikpr�vestandardafvigelsen s=4.9407, skal vi bruge
% t-fordeling i stedet for standard normalfordeling:
% t_alfahalve = tinv(1-alfa/2, n-1).
% Problemet er at t_alfahalve afh�nger af stikpr�vest�rrelsen n. Derfor kan
% vi ikke udtrykke stikpr�vest�rrelsen som funktion af bredden (vi kan
% ikke isolere n i formlen).

% Her er den korrekte (men for sv�re) l�sning af opgaven:
% I stedet for at udtrykke stikpr�vest�rrelsen som funktion af bredden, s� 
% l�ber jeg igennem en l�kke, hvor bredden beregnes for st�rre og st�rre
% stikpr�vest�rrelse, indtil bredden er kommet under de �nskede (B = 3.0):
n_ny = 0;                % Jeg starter med mindst mulig stikpr�vest�rrelse
bredde = 99999;          % Bredden s�ttes til en tilpas stor startv�rdi
while bredde > B
    n_ny = n_ny + 1;
    t_alfahalve = tinv(1-alfa/2, n_ny);       
    bredde = t_alfahalve*s*sqrt(1/n_ny);    
    % Variablen 'bredde' angiver konfidensintervallets halve bredde n�r 
    % stikpr�vest�rrelsen er n_ny. Nu skal vi teste om bredde er kommet
    % under B, s� vi er f�rdige, eller om skal forts�tte i l�kken og for�ge 
    % stikpr�vest�rrelsen. 
end
bredde      % bredde = 2.9692
n_ny        % n_ny = 22
% Alts�: n�r n_ny kommer op p� 22, s� kommer den halve bredde under 3.0, s�
% den totale bredde af konfidensintervallet kommer under 6.0





