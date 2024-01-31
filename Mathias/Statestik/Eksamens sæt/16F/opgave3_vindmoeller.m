%% Opgave 3 (Vindm�ller)
close all; clear; clc; 


%% a 
% Vi kan antage, at m�llernes drift er uafh�ngig af hinanden, s� en m�lles 
% nedbrud ikke p�virker de andres. Derfor kan vindm�llernes drift
% modelleres med binomialfordelingen. Det er mest enkelt at lade 'succes'
% betegne, at en m�lle er ude af drift. Sandsynligheden for det er 
% p = P(Dc) = 1 - P(D) = 1 - 0.945 = 0.055. 

n = 91          % Antal vindm�ller
p = 1 - 0.945   % Sandsynligheden for at en vindm�lle er ude af drift

% Middelv�rdien for binomialfordelingen (gns. antal succes) er n*p:
gns_itu = n*p
% Der er i gennemsnit 5.005 m�ller, der er ude af drift p� Horns Rev 2


%% b
p_0itu = binopdf(0, n, p)
% Sandsynligheden for at ingen m�ller er ude af drift er 0.0058, alts� 
% meget sj�ldent 


%% c
% Sandsynligheden for 3 eller flere vindm�ller ude af drift svarer til 
% 1 minus sandsynligheden for 0 til 2 er ude af drift. Det kan beregnes 
% med den kumulative fordelingsfunktion (cdf): 
p_mindst3itu = 1 - binocdf(2, n, p)

% Alternativt:
p_mindst3itu_alt = 1 - binopdf(0, n, p) - binopdf(1, n, p) - binopdf(2, n, p)

% Der er mindst 3 m�ller ude af drift i 88.28% af dagene


%% d
% Oplyst i opgaven:
p_D_givet_H = 0.945
    % P(D|H) = 0.945, da sandsynligheden for at en havm�lle er i drift er
    % 94.5%
p_Dc_givet_H = 1 - p_D_givet_H
    % P(Dc|H) = 0.055, nemlig sandsynligheden for at en havm�lle ikke er i
    % drift

p_H = 91/(91+15)
    % P(H) = 0.8585, da 91 af ialt 91+15=106 m�ller er havm�ller
p_Hc = 1 - p_H
    % P(Hc) = 0.1415, da de m�ller, der ikke er havm�ller, er landm�ller.
    % Det svarer til 15/106
p_D_givet_Hc = 0.980
    % P(D|Hc) = 0.980, da landm�llerne er i drift 98.0% af dagene
p_Dc_givet_Hc = 1 - p_D_givet_Hc
    % P(Dc|Hc) = 0.020, da landm�llerne er ude af drift 2.0% af dagene

    
%% e
p_Dc = p_Dc_givet_H*p_H + p_Dc_givet_Hc*p_Hc
    % Loven om den totale sandsynlighed (Sandsynlighederne for at v�re ude 
    % af drift i de to parker v�gtes med antal m�ller i parkerne):
    % P(Dc) = P(Dc|H)*P(H) + P(Dc|Hc)*P(Hc) 
    %       = 0.055*0.8585 + 0.020*0.1415 = 0.0500
    % Sandsynligheden for at en m�lle er ude af drift er 0.05

