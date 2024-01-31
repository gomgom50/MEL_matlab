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
% Begge koefficienter har en meget lille p-v�rdi t�t p� 0. Der er
% utvivlsomt en sammenh�ng mellem middeltemperaturen i forsommeren og
% h�jsommeren. Anova testens F-v�rdi og den tilh�rende p-v�rdi siger det
% samme. Dog er b�de R2 og Adjusted R2 temmelig lave, kun omkring 0.4. 
% Modellen forudsiger kun 40% af variationen i data. Det fort�ller os, 
% at der er meget usikkerhed i modellen. Trods en signifikant
% sammenh�ng mellem regressor og respons kan modellen ikke forudsige det
% kommende vejr s�rligt pr�cist


%% c
y_2015 = 7.2963 + 0.63605*11.25
% y_2015 = 14.4519


%% d
y_hat = 7.2963 + 0.63605*x

figure(1);
hold on;
scatter(x,y,'filled');
plot(x, y_hat)
title('�rlig gennemsnitstemperatur');
xlabel('Forsommer');
ylabel('H�jsommer');
hold off;

% Alternativ figur med den indbyggede matlabfunktion plot:
figure(2);
plot(mdl);
title('�rlig gennemsnitstemperatur');
xlabel('Forsommer');
ylabel('H�jsommer');

%% e
% Brug enten almindelige residualer e eller studentiserede r (bedst)
e = y - y_hat
r = mdl.Residuals.Studentized

figure(3);
scatter(aar, e);
title('Tidsplot');
xlabel('�rstal');
ylabel('Residual e');
% Residualerne fordeler sig tilf�ldigt over tid

figure(4);
scatter(x, r);
title('Residualplot r vs. x');
xlabel('Temperatur forsommer');
ylabel('Studentiseret residual r');
% Residualerne er uafh�ngige af x, dog er der m�ske en tendens til st�rre
% residualer i midteromr�det. 

figure(5);
scatter(y_hat, r);
title('Residualplot r vs. y_{hat}');
xlabel('Estimeret temperatur');
ylabel('Studentiseret residual r');
% Residualerne er uafh�ngige af y_hat, dog er der m�ske en tendens til st�rre
% residualer i midteromr�det. 

figure(6);
normplot(r);
title('Normalfordelingsplot for studentiserede residualer');
% Residualerne kommer fra en 'p�n' fordeling, da de ligger nogenlunde p� en
% ret linje i normalfordelingsplottet. 

stemleafplot(r, -1)

figure(7); 
histogram(r,7)
% B�de stem-and-leaf plot og histogram viser at residualerne kommer fra en
% 'p�n' fordeling med et toppunkt og hurtigt udd�ende haler. Nogenlunde
% symmmetrisk. 