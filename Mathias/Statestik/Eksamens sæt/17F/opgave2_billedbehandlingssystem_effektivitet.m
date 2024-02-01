%% Opgave 2: Effektivitet af robottens billedbehandlingssystem
clc; clear; close all; 

%% Basisoplysninger
Antal_Aebler = 975
Antal_Modne = 850
Antal_Umodne = Antal_Aebler - Antal_Modne
P_mc_givet_M = 0.07                         % P(mc|M)
P_m_givet_Mc = 0.12                         % P(m|Mc)


%% a
P_M = Antal_Modne / Antal_Aebler            % P(M)
P_Mc = 1 - P_M                              % P(Mc)
P_m_givet_M = 1 - P_mc_givet_M              % P(m|M)
P_mc_givet_Mc = 1 - P_m_givet_Mc            % P(mc|Mc)


%% b
% Det er sandsynligheden for, at det tilf�ldige �ble er modent og systemet
% bed�mmer korrekt, plus sandsynligheden for at �blet er umodent og
% systemet fejlbed�mmer det som modent.
% Loven om den totale sandsynlighed:
% P(m) = P(m|M)*P(M) + P(m|Mc)*P(Mc)
P_m = P_m_givet_M * P_M + P_m_givet_Mc * P_Mc


%% c
% Alle �blerne i kassen er bed�mt modne. Vi skal bruge sandsynligheden for 
% at et �ble, der er bed�mt modent i virkeligheden er umodent: P(Mc|m). 
% Vi skal bruge Bayes' formel:
% P(Mc|m) = P(m|Mc) * P(Mc) / P(m)
P_Mc_givet_m = P_m_givet_Mc * P_Mc / P_m
Antal_I_Kassen = 50
Antal_Umodne_I_Kassen = Antal_I_Kassen * P_Mc_givet_m


%% d 
% Forkert bed�mte er de modne, der bed�mmes umodne plus de umodne, der
% bed�mmes modne:
Antal_Fejlbedoemte = Antal_Modne * P_mc_givet_M + Antal_Umodne * P_m_givet_Mc

