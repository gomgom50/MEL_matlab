%% Opgave 1 om den tidlige udvikling af coronavirus i Italien
clear; close all; clc; format compact; 

n = 3300        % Antal indbyggere i Vo'
n_C1 = 89       % Antal positive Covid-19 tests d. 6. marts
n_C2 = 6        % Antal positive Covid-19 tests d. 20. marts
n_C3 = 0        % Antal positive Covid-19 tests d. 3. april

%% a
P_C1 = n_C1 / n       % P(C1) = 0.0270
P_C2 = n_C2 / n       % P(C1) = 0.0018
P_C3 = n_C3 / n       % P(C1) = 0


%% b
% Alle 6, der blev testet positiv 20/3 var også positive 6/3, så: 
n_C2_faelles_C1 = 6
P_C2_faelles_C1 = n_C2_faelles_C1 / n      % P(C2 n C1) = 0.0018
P_C2_givet_C1   = n_C2_faelles_C1 / n_C1   % P(C2|C1) = 0.0674


%% c
% Nye oplysninger i teksten
n_pos_uden_symp = 63    % Der er 63 testet positiv, men uden symptomer
n_neg_med_symp = 125    % Der er 125 testet negativ, men med symptomer

% Vi skal finde antal personer med symptomer blandt dem der blev testet
% positiv d. 6. marts. Ud af 89 positive havde 69 ingen symptomer. De
% resterende 89-63 = 26 havde, så n_pos_med_symp = 26
n_pos_med_symp = n_C1 - n_pos_uden_symp     % Antal positive med symptomer

P_S1_givet_C1 = n_pos_med_symp / n_C1           % P(S1 | C1)  = 0.2921
P_S1c_givet_C1 = 1 - P_S1_givet_C1              % P(S1c | C1) = 0.7079
P_S1_givet_C1c = n_neg_med_symp / (n - n_C1)    % P(S1 | C1c) = 0.0389


%% d
% Dem med symptomer er dels dem der tester positiv og har symptomer og dels
% dem, der tester negativ, men alligevel har symptomer. 
% Loven om den totale sandsynlighed:
% P(S1) = P(S1|C1) * P(C1) + P(S1|C1c) * P(C1c)
P_S1 = P_S1_givet_C1 * P_C1 + P_S1_givet_C1c * (1 - P_C1)
% P_S1 = 0.0458


%% e
% Bayes' formel:
% P(C1|S1) = P(S1|C1)*P(C1)/P(S1)
P_C1_givet_S1 = P_S1_givet_C1 * P_C1 / P_S1
% P_C1_givet_S1 = 0.1722

