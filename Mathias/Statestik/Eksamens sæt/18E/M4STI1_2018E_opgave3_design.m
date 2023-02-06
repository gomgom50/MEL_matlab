%% Eksamen M4STI1 2018E opgave 3: K�nsspecifikke pr�ferencer af designs
clear; close all; clc; format compact;

%% Data fra brugerunders�gelsen

O = xlsread('Data_M4STI1_2018E.xlsx','G:H')

% H�ndelse A: Testpersonen foretr�kker model SL1
% H�ndelse B: Testpersonen er en kvinde

%% a. Sandsynligheder
% P(A) er sandsynligheden for at en tilf�ldig testperson foretr�kker SL1. 
% I alt 17 (6 kvinder og 11 m�nd) ud af de 37 testpersoner foretr�kker SL1. 
% De udg�r 17/37 = 45.95 %. 
% I det f�lgende beregner jeg samlet antal af hvert k�n og pr�ference:
soejlesum = sum(O,1) % Sum for hver s�jle (antal kvinder og m�nd)
raekkesum = sum(O,2) % Sum for hver r�kke (antal der foretr�kker SL1 og SL2)
total = sum(sum(O))  % Total antal testpersoner

P_A = raekkesum(1)/total    % P_A  = 0.4595
P_Ac = raekkesum(2)/total   % P_Ac = 0.5405
P_B = soejlesum(1)/total    % P_B  = 0.5135
P_Bc = soejlesum(2)/total   % P_Bc = 0.4865


%% b. Sandsynligheder 
% P(A n B) er sandsynligheden for f�llesh�ndelsen mellem A og B. Dvs.
% sandsynligheden for at en tilf�ldig testperson er b�de kvinde og
% foretr�kker SL1. Der er 6 ud af de 37 testpersoner, der opfylder dette.
% Derfor er sandsynligheden 6/37 = 16.2 %:
P_A_faelles_B = O(1,1)/total        % P_A_faelles_B = 0.1622

% P(A | B) er sandsynligheden for A givet B. D.v.s. sandsynligheden for at
% en af de 19 kvindelige testpersoner foretr�kker SL1. Der er 6 ud af de 19 
% kvindelige testpersoner, der foretr�kker SL1, s� sandsynligheden er 
% 6/19 =  31.6 %:
P_A_givet_B = O(1,1)/soejlesum(1)   % P_A_givet_B = 0.3158

    
%% c.
% Definitionen p� at A og B er uafh�ngige er, at P(A) = P(A|B). Da 
% P(A) = 0.46 og P(A|B) = 0.32 kunne det godt tyde p�, at de to h�ndelser
% ikke er uafh�ngige. Alts�: 46 % af testdeltagerne foretr�kker SL1, men
% blandt kvinderne er det kun 32 %. Der lader til at v�re k�nsforskelle.
% Tilsvarende kan man beregne, at P(B) = 0.51, men P(B|A) = 0.35.


%% d. 
% Det hvide omr�de i Venn diagrammet angiver de m�nd, der foretr�kker SL1.
% Dem er der 11 af.
%
% H�ndelserne beskrevet i mulighed 2 og 3 svarer begge til det gr� omr�de i 
% Venn diagrammet. Det er dem, der enten er kvinder eller foretr�kker SL2. 


%% e. Beregn tabel over forventet antal, hvis der er uafh�ngighed, E
soejlefrekvens = soejlesum/total    % Frekvens for hver s�jle
raekkefrekvens = raekkesum/total    % Frekvens for hver r�kke
r = size(O,1)                       % Antal r�kker
c = size(O,2)                       % Antal s�jler
E = zeros(r,c);                     % Matricen E kommer til at indeholde 
                                    % forventet antal. I f�rste omgang 
                                    % indeholder den 0'er i alle celler

                                    
% For hver celle i matricen E beregnes det forventede antal som det totale
% antal gange sandsynligheden for at v�re i den i-te r�kke og j-te s�jle.
% Denne sandsynlighed kan beregnes som sandsynligheden for at v�re i den
% i-te r�kke gange sandsynligheden for at v�re i den j-te s�jle, da de to
% ting antages at v�re uafh�ngige. 
for i=1:r
    for j=1:c
        E(i,j) = total*raekkefrekvens(i)*soejlefrekvens(j);
    end
end
E


%% f. Opstil nul- og alternativ-hypoteser
% H0: Pr�ference for prototypedesign og k�n er uafh�ngige
% Ha: De er ikke uafh�ngige


%% g. Formel for testst�rrelsen og dens fordeling
% chi2_0 = sum_i(sum_j( (O_ij - E_ij)^2/E_ij ))
% hvor O_ij er det observerede antal testpersoner, der foretr�kker design i 
% (SL1, SL2) og som har k�n j (kvinde, mand), og hvor E_ij er det tilsvarende
% forventede antal under foruds�tning af uafh�ngighed.
% Testst�rrelsen chi2_0 er chi-i-anden fordelt med (r-1)*(c-1)
% frihedsgrader.


%% h. Beregn kritisk v�rdi, teststatistikken og konklusion p� testen
% For at beregne kritisk v�rdi skal jeg bruge antal frihedsgrader
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
% Testst�rrelsen chi2_0 = 3.2459 er ikke st�rre end den kritiske v�rdi, 
% chi2_kritisk = 3.8415, s� vi kan ikke forkaste nulhypotesen p� 
% 5 % signifikansniveau. P-v�rdien er 0.07, s� de forskelle i pr�ferencer,
% vi har observeret mellem k�nnene er ikke tilstr�kkeligt store til, at vi
% kan udelukke, at de er tilf�ldige.


%% Alternativ l�sning af hypotesetest (til kontrol af l�sning)
% Funktionen chi2cont er ikke i MatLab men kan downloades fra BB
[h, pval, chi2_0] = chi2cont(O, alfa)
% h angiver om nulhypotesen kan forkastes (0: nej, 1: ja)
% pval er p-v�rdien for chi-i-anden testen
% chi2_0 er testst�rrelsen
