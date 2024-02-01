%% Eksamen M4STI1 2019F opgave 1: Sorteringsmaskinen effektivitet
clear; close all; clc; format compact;

n_VH = 885              % Antal stykker h�rdt plastik, der skal sorteres
n_VB = 313              % Antal stykker bl�dt plastik, der skal sorteres
n_total = n_VH + n_VB   % Antal stykker plastik ialt. 
% n_total = 1198

n_SH = 738              % Antal stykker plastik, der blev sorteret som h�rdt
n_SB = n_total - n_SH   % Antal stykker plastik, der blev sorteret som bl�dt
% n_SB = 460

n_VH_n_SH = 732     % Antal stykker h�rdt plastik, der er sorteret som h�rdt 
                    % Jeg bruger n som tegnet for f�llesh�ndelse, s� (VH n SH) betyder 
                    % at plastikstykket er b�de h�rdt i virkeligheden og sorteret som h�rdt
n_VB_n_SB = 307     % Antal stykker bl�dt plastik, der ogs� er sorteret som bl�dt

%% a: Fordeling af bl�dt og h�rdt plastik f�r og efter sortering
P_VH = n_VH/n_total     % P_VH = 0.7387
P_VB = n_VB/n_total     % P_VB = 0.2613
P_SH = n_SH/n_total     % P_SH = 0.6160
P_SB = n_SB/n_total     % P_SB = 0.3840


%% b: Sandsynligheder for korrekt sortering
P_VH_givet_SH = n_VH_n_SH / n_SH     % P_VH_givet_SH = 0.9919
P_VB_givet_SB = n_VB_n_SB / n_SB     % P_VB_givet_SB = 0.6674


%% c: Sandsynligheder for forkert sortering
P_VB_givet_SH = 1 - P_VH_givet_SH     % P_VB_givet_SH = 0.0081
P_VH_givet_SB = 1 - P_VB_givet_SB     % P_VH_givet_SB = 0.3326


%% d: Andelen af h�rdt plastik i ny kasse
P_SH_ny = 0.78          % I den nye kasse bliver 78 % sorteret som h�rdt
P_SB_ny = 1 - P_SH_ny   % Dermed bliver 22 % sorteret som bl�dt

% If�lge loven om den totale sandsynlighed: Det plastik, der er h�rdt i
% virkeligheden best�r af det, der er sorteret korrekt som h�rdt plus det,
% der er sorteret forkert som bl�dt: 
% P_VH_ny = P_VH_givet_SH_ny * P_SH_ny + P_VH_givet_SB_ny * P_SB_ny
% Vi antager at de betingede sandsynligheder er de samme som for den gamle
% kasse:
% P_VH_givet_SH_ny = P_VH_givet_SH = 0.8960
% P_VH_givet_SB_ny = P_VH_givet_SB = 0.1942
% Derfor:
% P_VH_ny = P_VH_givet_SH * P_SH_ny + P_VH_givet_SB * P_SB_ny
P_VH_ny = P_VH_givet_SH * P_SH_ny + P_VH_givet_SB * P_SB_ny
% P_VH_ny = 0.8468


%% e: Sandsynligheden for korrekt sortering af h�rdt plastik
% Bayes' formel:
% Generel formel: P(A |B) = P(B | A) * P(A) / P(B)
% P_SH_givet_VH = P_VH_givet_SH * P_SH_ny / P_VH_ny
P_SH_givet_VH = P_VH_givet_SH * P_SH_ny / P_VH_ny   
% P_SH_givet_VH = 0.9136


