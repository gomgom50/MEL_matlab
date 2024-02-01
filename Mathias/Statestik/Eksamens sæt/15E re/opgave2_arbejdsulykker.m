%% M4STI E2015rx opgave 2 om arbejdsulykker (kontingenstabel)
clc; clear all; close all;

%% Indlæs data
M=xlsread('Data_M4STI1_2015E_reeksamen.xlsx', 'E:G') 

%% a 
p_f2 = (99 + 89 + 113)/1039                 % P(F2) = 0.2897
p_h1 = (89 + 99 + 82)/1039                  % P(H1) = 0.2599
p_f2_faelles_h1 = 99/1039                   % P(F2 n H1) = 0.0953
p_f2_givet_h1 = 99/(89 + 99 + 82)           % P(F2 | H1) = 0.3667
p_h1_givet_f2 = 99/(99 + 89 + 113)          % P(H1 | F2) = 0.3289

%% b
p_h1_ikke_f2 = (89 + 82)/1039               % P(H1 n F2^c) = 0.1646


%% c Beregn tabel over forventet antal ulykker, E
total = sum(sum(M))             % Total antal 
soejlefrekvens = sum(M,1)/total % Frekvens for hver søjle
raekkefrekvens = sum(M,2)/total % Frekvens for hver række
r = size(M,1)                   % Antal rækker
c = size(M,2)                   % Antal søjler
E = zeros(r,c);                 % Matricen E kommer til at indeholde 
                                % forventet antal

for i=1:r
    for j=1:c
        E(i,j) = total*raekkefrekvens(i)*soejlefrekvens(j);
    end
end
E

%% d. Opstil nul- og alternativ-hypoteser
% H0: Antal ulykker er uafhængig af fabrik og skiftehold
% Ha: De er ikke uafhængige

%% e. Formel for teststatistikken og dens fordeling
% chi2_0 = sum_i(sum_j( (O_ij - E_ij)^2/E_ij ))
% hvor O_ij er observeret antal ulykker på hold i på fabrik j
% og E_ij er forventet antal ulykker på hold i på fabrik j
% under forudsætning af uafhængighed.
% Teststatistikken chi2_0 er chi-i-anden fordelt med (r-1)*(c-1)
% frihedsgrader, hvis H0 er sand.

%% f. Beregn kritisk værdi, teststatistikken og konklusion på testen
% For at beregne kritisk værdi skal jeg bruge antal frihedsgrader
% Beregning af frihedsgrader df
df = (r - 1)*(c - 1) 
% signifikansniveau 5%
alpha = 0.05;
chi2_kritisk = chi2inv(1-alpha,df)
% Vi forkaster H0, hvis chi2_0 > chi2_kritisk

% Beregning af teststatistikken chi2_0. 
% Vi har de observerede antal O_ij i M og de forventede antal E_ij i O
chi2_0 = 0;
for i=1:r
    for j=1:c
        chi2_0 = chi2_0 + (M(i,j) - E(i,j))^2 / E(i,j);
    end
end
chi2_0


p_value = 1 - chi2cdf(chi2_0, df)

% Konklusion: Den kritiske værdi chi2_kritisk er 9.4877, så da 
% teststatistikken chi2_0 er 12.5915 og dermed større end den kritiske
% værdi, så kan vi forkaste nulhypotesen. Der er således ikke uafhængighed
% mellem fabrik og skiftehold mht. arbejdsulykker. P-værdien på 0.0135
% fortæller, at hvis der var uafhængighed, så ville man kun observere data
% som vores i godt 1% af tilfældene, altså et godt stykke fra vores
% signifikansniveau på 5%. 

%% g
% Det er mest sikkert at arbejde på hold 1, fabrik 3
% Det er mindst sikkert at arbejde på hold 3, fabrik 1
