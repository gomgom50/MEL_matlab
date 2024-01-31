%% Eksamen M4STI1 2018E opgave 3: Kønsspecifikke præferencer af designs
clear; close all; clc; format compact;

%% Data fra brugerundersøgelsen

O = xlsread('Data_M4STI1_2018E.xlsx','G:H')

% Hændelse A: Testpersonen foretrækker model SL1
% Hændelse B: Testpersonen er en kvinde

%% a. Sandsynligheder
% P(A) er sandsynligheden for at en tilfældig testperson foretrækker SL1. 
% I alt 17 (6 kvinder og 11 mænd) ud af de 37 testpersoner foretrækker SL1. 
% De udgør 17/37 = 45.95 %. 
% I det følgende beregner jeg samlet antal af hvert køn og præference:
soejlesum = sum(O,1) % Sum for hver søjle (antal kvinder og mænd)
raekkesum = sum(O,2) % Sum for hver række (antal der foretrækker SL1 og SL2)
total = sum(sum(O))  % Total antal testpersoner

P_A = raekkesum(1)/total    % P_A  = 0.4595
P_Ac = raekkesum(2)/total   % P_Ac = 0.5405
P_B = soejlesum(1)/total    % P_B  = 0.5135
P_Bc = soejlesum(2)/total   % P_Bc = 0.4865


%% b. Sandsynligheder 
% P(A n B) er sandsynligheden for fælleshændelsen mellem A og B. Dvs.
% sandsynligheden for at en tilfældig testperson er både kvinde og
% foretrækker SL1. Der er 6 ud af de 37 testpersoner, der opfylder dette.
% Derfor er sandsynligheden 6/37 = 16.2 %:
P_A_faelles_B = O(1,1)/total        % P_A_faelles_B = 0.1622

% P(A | B) er sandsynligheden for A givet B. D.v.s. sandsynligheden for at
% en af de 19 kvindelige testpersoner foretrækker SL1. Der er 6 ud af de 19 
% kvindelige testpersoner, der foretrækker SL1, så sandsynligheden er 
% 6/19 =  31.6 %:
P_A_givet_B = O(1,1)/soejlesum(1)   % P_A_givet_B = 0.3158

    
%% c.
% Definitionen på at A og B er uafhængige er, at P(A) = P(A|B). Da 
% P(A) = 0.46 og P(A|B) = 0.32 kunne det godt tyde på, at de to hændelser
% ikke er uafhængige. Altså: 46 % af testdeltagerne foretrækker SL1, men
% blandt kvinderne er det kun 32 %. Der lader til at være kønsforskelle.
% Tilsvarende kan man beregne, at P(B) = 0.51, men P(B|A) = 0.35.


%% d. 
% Det hvide område i Venn diagrammet angiver de mænd, der foretrækker SL1.
% Dem er der 11 af.
%
% Hændelserne beskrevet i mulighed 2 og 3 svarer begge til det grå område i 
% Venn diagrammet. Det er dem, der enten er kvinder eller foretrækker SL2. 


%% e. Beregn tabel over forventet antal, hvis der er uafhængighed, E
soejlefrekvens = soejlesum/total    % Frekvens for hver søjle
raekkefrekvens = raekkesum/total    % Frekvens for hver række
r = size(O,1)                       % Antal rækker
c = size(O,2)                       % Antal søjler
E = zeros(r,c);                     % Matricen E kommer til at indeholde 
                                    % forventet antal. I første omgang 
                                    % indeholder den 0'er i alle celler

                                    
% For hver celle i matricen E beregnes det forventede antal som det totale
% antal gange sandsynligheden for at være i den i-te række og j-te søjle.
% Denne sandsynlighed kan beregnes som sandsynligheden for at være i den
% i-te række gange sandsynligheden for at være i den j-te søjle, da de to
% ting antages at være uafhængige. 
for i=1:r
    for j=1:c
        E(i,j) = total*raekkefrekvens(i)*soejlefrekvens(j);
    end
end
E


%% f. Opstil nul- og alternativ-hypoteser
% H0: Præference for prototypedesign og køn er uafhængige
% Ha: De er ikke uafhængige


%% g. Formel for teststørrelsen og dens fordeling
% chi2_0 = sum_i(sum_j( (O_ij - E_ij)^2/E_ij ))
% hvor O_ij er det observerede antal testpersoner, der foretrækker design i 
% (SL1, SL2) og som har køn j (kvinde, mand), og hvor E_ij er det tilsvarende
% forventede antal under forudsætning af uafhængighed.
% Teststørrelsen chi2_0 er chi-i-anden fordelt med (r-1)*(c-1)
% frihedsgrader.


%% h. Beregn kritisk værdi, teststatistikken og konklusion på testen
% For at beregne kritisk værdi skal jeg bruge antal frihedsgrader
% Beregning af frihedsgrader df
df = (r - 1)*(c - 1)    % df = 1
% signifikansniveau 5%
alfa = 0.05;
chi2_kritisk = chi2inv(1-alfa,df)   % chi2_kritisk = 3.8415
% Vi forkaster H0, hvis chi2_0 > chi2_kritisk

% Beregning af teststatistikken chi2_0. 
% Vi har de observerede antal O_ij i O og de forventede antal E_ij i E
chi2_0 = 0;
for i=1:r
    for j=1:c
        chi2_0 = chi2_0 + (O(i,j) - E(i,j))^2 / E(i,j);
    end
end
chi2_0  % chi2_0 = 3.2459

p_value = 1 - chi2cdf(chi2_0, df)   % p_value = 0.071601

% Konklusion:
% Teststørrelsen chi2_0 = 3.2459 er ikke større end den kritiske værdi, 
% chi2_kritisk = 3.8415, så vi kan ikke forkaste nulhypotesen på 
% 5 % signifikansniveau. P-værdien er 0.07, så de forskelle i præferencer,
% vi har observeret mellem kønnene er ikke tilstrækkeligt store til, at vi
% kan udelukke, at de er tilfældige.


%% Alternativ løsning af hypotesetest (til kontrol af løsning)
% Funktionen chi2cont er ikke i MatLab men kan downloades fra BB
[h, pval, chi2_0] = chi2cont(O, alfa)
% h angiver om nulhypotesen kan forkastes (0: nej, 1: ja)
% pval er p-værdien for chi-i-anden testen
% chi2_0 er teststørrelsen
