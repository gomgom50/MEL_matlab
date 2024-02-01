%% M4STI1 2018F Opgave 1: B�lgers variabilitet
clc; clear; close all; format compact; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2018F.xlsx','A:C')

H_fra = D(:,1)      % Startv�rdi for interval af b�lgeh�jde
H_til = D(:,2)      % Slutv�rdi for interval af b�lgeh�jde
O = D(:,3)          % Observeret antal b�lger i intervallet
n = sum(O)          % Antal b�lger ialt 
k = size(O,1)       % Antal intervaller

%% a: Sandsynlighedsfordeling for b�lgeh�jder
P_hoejde = O/n              % Sandsynlighedsfordelingen af b�lgeh�jder
test = sum(P_hoejde)        % Summen skal v�re 1

res = [H_fra, H_til, P_hoejde]

H_midt = (H_fra + H_til)/2  % Midterv�rdier for intervallerne

figure(1)
bar(H_midt, P_hoejde)
title('Sandsynlighedsfordeling af b�lgers h�jde')
xlabel('H�jdeinterval (m)')
ylabel('Sandsynlighed')


%% b: Kumuleret sandsynlighedsfordeling 
P_kumul = zeros(k,1)                    % Initialisering med nuller
for i=1:k
    P_kumul(i) = sum(P_hoejde(1:i));    % Det i-te element i P_kumul er sum
end                                     % af de hidtidige sandsynligheder
P_kumul

res = [H_fra, H_til, P_kumul]

% Der bedes ikke om en grafisk pr�sentation, men her er den: 
figure(2)
bar(H_midt, P_kumul)
title('Kumuleret sandsynlighedsfordeling af b�lgers h�jde')
xlabel('H�jdeinterval (m)')
ylabel('Sandsynlighed')


%% c: Sandsynligheden for at en b�lge er over 1.0 m
% Dette findes som summen af sandsynligheder fra det sjette interval 
% (1.0 - 1.2) til det sidste interval: 
P_o1 = sum(P_hoejde(6:8,1))     % P_o1 = 0.1280
P_o1_alt = 1 - P_kumul(5,1)     % Alternativ beregning med den kumulerede 
                                % sandsynlighedsfordeling

                                
%% d: B�lgernes gennemsnitsh�jde
% Jeg har allerede beregnet intervallernes midterv�rdi:
% H_midt = (H_fra + H_til)/2
H_middel = (O'*H_midt)/n
% B�lgernes gennemsnitsh�jde beregnes til H_middel = 0.6159 m = 0.62 m

