%% M4STI E2015 opgave 1 om stålbjælker
clc; clear all; close all;

%% Oplyst: 
p_R_givet_S = 0.87      
    % P(R|S) = 0.87, da 87 pct. af de svage (S) viser mønsteret R
p_Rc_givet_S = 1 - p_R_givet_S 
    % P(Rc|S) = 0.13. Vi ser kun på de svage (givet S). Af dem viser 87 pct. 
    % mønsteret, så resten (13 pct) viser det ikke

%% a
p_S = 0.1               
    % P(S) = 0.10, da 10 pct af stålbjælkerne er svage (S)
p_Sc = 1 - p_S        
    % P(Sc) = 0.90, da resten (90pct) er stærke
p_R_givet_Sc = 0.07    
    % P(R|Sc) = 0.07, da 7 pct. af de stærke (Sc) viser mønsteret R
p_Rc_givet_Sc = 1 - p_R_givet_Sc
    % P(Rc|Sc) =  0.93. Vi ser kun på de stærke (givet Sc). Af dem viser 7 pct 
    % mønsteret, så resten (93 pct) viser det ikke.
    
%% b 
% P(R) = P(R|S)*P(S) + P(R|Sc)*P(Sc)
p_R = p_R_givet_S*p_S + p_R_givet_Sc*p_Sc

%% c
% P(S|R) = P(R|S)*P(S)/P(R) (Bayes)
p_S_givet_R = p_R_givet_S * p_S / p_R

%% d
% P(S|Rc) = P(Rc|S)*P(S)/P(Rc) (Bayes)
%         = (1 - P(R|S))*P(S)/(1 - P(R))
p_S_givet_RC = (1 - p_R_givet_S) * p_S / (1 - p_R)



