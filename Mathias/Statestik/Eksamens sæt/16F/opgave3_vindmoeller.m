%% Opgave 3 (Vindmøller)
close all; clear; clc; 


%% a 
% Vi kan antage, at møllernes drift er uafhængig af hinanden, så en mølles 
% nedbrud ikke påvirker de andres. Derfor kan vindmøllernes drift
% modelleres med binomialfordelingen. Det er mest enkelt at lade 'succes'
% betegne, at en mølle er ude af drift. Sandsynligheden for det er 
% p = P(Dc) = 1 - P(D) = 1 - 0.945 = 0.055. 

n = 91          % Antal vindmøller
p = 1 - 0.945   % Sandsynligheden for at en vindmølle er ude af drift

% Middelværdien for binomialfordelingen (gns. antal succes) er n*p:
gns_itu = n*p
% Der er i gennemsnit 5.005 møller, der er ude af drift på Horns Rev 2


%% b
p_0itu = binopdf(0, n, p)
% Sandsynligheden for at ingen møller er ude af drift er 0.0058, altså 
% meget sjældent 


%% c
% Sandsynligheden for 3 eller flere vindmøller ude af drift svarer til 
% 1 minus sandsynligheden for 0 til 2 er ude af drift. Det kan beregnes 
% med den kumulative fordelingsfunktion (cdf): 
p_mindst3itu = 1 - binocdf(2, n, p)

% Alternativt:
p_mindst3itu_alt = 1 - binopdf(0, n, p) - binopdf(1, n, p) - binopdf(2, n, p)

% Der er mindst 3 møller ude af drift i 88.28% af dagene


%% d
% Oplyst i opgaven:
p_D_givet_H = 0.945
    % P(D|H) = 0.945, da sandsynligheden for at en havmølle er i drift er
    % 94.5%
p_Dc_givet_H = 1 - p_D_givet_H
    % P(Dc|H) = 0.055, nemlig sandsynligheden for at en havmølle ikke er i
    % drift

p_H = 91/(91+15)
    % P(H) = 0.8585, da 91 af ialt 91+15=106 møller er havmøller
p_Hc = 1 - p_H
    % P(Hc) = 0.1415, da de møller, der ikke er havmøller, er landmøller.
    % Det svarer til 15/106
p_D_givet_Hc = 0.980
    % P(D|Hc) = 0.980, da landmøllerne er i drift 98.0% af dagene
p_Dc_givet_Hc = 1 - p_D_givet_Hc
    % P(Dc|Hc) = 0.020, da landmøllerne er ude af drift 2.0% af dagene

    
%% e
p_Dc = p_Dc_givet_H*p_H + p_Dc_givet_Hc*p_Hc
    % Loven om den totale sandsynlighed (Sandsynlighederne for at være ude 
    % af drift i de to parker vægtes med antal møller i parkerne):
    % P(Dc) = P(Dc|H)*P(H) + P(Dc|Hc)*P(Hc) 
    %       = 0.055*0.8585 + 0.020*0.1415 = 0.0500
    % Sandsynligheden for at en mølle er ude af drift er 0.05

