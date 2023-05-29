%% Opgave 1: Fejl i printede emner
clc; clear; close all; format compact; 


%% Oplysninger i opgaven
n = 1000        % Antal testede emner
f = 45          % Antal fejl (revner)


%% a: Sandsynligheden for et fejlfrit emne
% Et tilfældigt emne kan indeholde flere fejl, der er ingen øvre grænse.
% Vi bruger Poissonfordelingen. 
% Lambda er det forventede antal fejl per emne. Det kan vi estimere som 
% Antal fejl delt med antal emner, altså: 
lambda = f/n    % lambda = 0.0450
P_0_fejl = poisspdf(0,lambda)
% P_0_fejl = 0.9560
    

%% b: Sandsynligheden for præcis 1 fejl i emnet
P_1_fejl = poisspdf(1,lambda)
% P_1_fejl = 0.0430
    

%% c: Sandsynligheden for 120 fejlfri ud af 120
% Nu skal vi bruge binomialfordelingen med 
N = 120
p = P_0_fejl
P_alle_fejlfri = binopdf(N, N, p)
% P_alle_fejlfri = 0.0045


%% d: Sandsynligheden for 110 eller flere fejlfri
% Det er 1 minus sandsynligheden for 109 eller færre fejlfri
P_mindst_110_fejlfri = 1 - binocdf(109, N, p)
% _mindst_110_fejlfri = 0.9829


%% e: Det forventede antal fejlfri emner ud af 120
fejlfri_middel = N*p
% fejlfri_middel = 114.7197

