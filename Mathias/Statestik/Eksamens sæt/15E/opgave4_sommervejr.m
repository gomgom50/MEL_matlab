%% M4STI E2015 opgave 4 om prognose af sommervejr
clc; clear all; close all;

%% a
M = xlsread('M4STI1_2015E_data.xlsx', 'G:I')

aar = M(:,1);
x = M(:,2);
y = M(:,3);

mdl = fitlm(x,y)
anova_sti(mdl)
% y = 7.2963 + 0.63605*x


%% b
% Begge koefficienter har en meget lille p-værdi tæt på 0. Der er
% utvivlsomt en sammenhæng mellem middeltemperaturen i forsommeren og
% højsommeren. Anova testens F-værdi og den tilhørende p-værdi siger det
% samme. Dog er både R2 og Adjusted R2 temmelig lave, kun omkring 0.4. 
% Modellen forudsiger kun 40% af variationen i data. Det fortæller os, 
% at der er meget usikkerhed i modellen. Trods en signifikant
% sammenhæng mellem regressor og respons kan modellen ikke forudsige det
% kommende vejr særligt præcist


%% c
y_2015 = 7.2963 + 0.63605*11.25
% y_2015 = 14.4519


%% d
y_hat = 7.2963 + 0.63605*x

figure(1);
hold on;
scatter(x,y,'filled');
plot(x, y_hat)
title('Årlig gennemsnitstemperatur');
xlabel('Forsommer');
ylabel('Højsommer');
hold off;

% Alternativ figur med den indbyggede matlabfunktion plot:
figure(2);
plot(mdl);
title('Årlig gennemsnitstemperatur');
xlabel('Forsommer');
ylabel('Højsommer');

%% e
% Brug enten almindelige residualer e eller studentiserede r (bedst)
e = y - y_hat
r = mdl.Residuals.Studentized

figure(3);
scatter(aar, e);
title('Tidsplot');
xlabel('Årstal');
ylabel('Residual e');
% Residualerne fordeler sig tilfældigt over tid

figure(4);
scatter(x, r);
title('Residualplot r vs. x');
xlabel('Temperatur forsommer');
ylabel('Studentiseret residual r');
% Residualerne er uafhængige af x, dog er der måske en tendens til større
% residualer i midterområdet. 

figure(5);
scatter(y_hat, r);
title('Residualplot r vs. y_{hat}');
xlabel('Estimeret temperatur');
ylabel('Studentiseret residual r');
% Residualerne er uafhængige af y_hat, dog er der måske en tendens til større
% residualer i midterområdet. 

figure(6);
normplot(r);
title('Normalfordelingsplot for studentiserede residualer');
% Residualerne kommer fra en 'pæn' fordeling, da de ligger nogenlunde på en
% ret linje i normalfordelingsplottet. 

stemleafplot(r, -1)

figure(7); 
histogram(r,7)
% Både stem-and-leaf plot og histogram viser at residualerne kommer fra en
% 'pæn' fordeling med et toppunkt og hurtigt uddøende haler. Nogenlunde
% symmmetrisk. 