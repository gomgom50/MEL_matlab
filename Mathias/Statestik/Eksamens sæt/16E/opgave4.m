%% E2016 Opg 4: Variansanalyse af forskellige batteriers opladningsgrad
clear all; close all; clc;

M = xlsread('Data_M4STI1_2016E.xlsx', 'G:H')

batteri = M(:,1)
opladn  = M(:,2)

%% a
figure(1)
boxplot(opladn, batteri)
title('Opladningsgrad af fire batterityper');

% Batteritype 1, 3 og 4 har nogenlunde ensartet form på boksplottet, mens 
% batteritype 2 har meget større variation. Type 2 har den højeste median,
% efterfulgt af henholdsvis 3, 1 og 4.


%% b
[p,table,stats] = anovan(opladn, batteri)
% Variansanalysen har F = 2.4 og en tilhørende p-værdi på 0.098. Det vil
% sige, at vi kan ikke afvise på 5% signifikansniveau, at alle 4
% batterityper opfører sig ens (da 0.098 > 0.05). 


%% c
[c,m] = multcompare(stats,  'Alpha',0.05,  'CType','lsd')

% Type 1 er ikke forskellig fra nogen andre
% Type 2 og type 4 er forskellige
% Type 3 og type 4 er forskellige
% Type 4 er forskellig fra type 2 og 3.


%% d
% Valget står mellem type 2 og type 3, selv om de to ikke er signifikant 
% forskellige. Type 2 har den højeste median, mens type 3 har det højeste 
% gruppegennemsnit på 41.0, mod type 2's 40.8. Det er ikke meget forskel,
% så når alt kommer til alt vælger jeg type 3, fordi det er mere ensartet,
% som man også kan se i det parallelle boksplot. 


%% e
% Det er en antagelse, at residualerne er normalfordelte med middelværdi 0
% og med samme varians for alle batterityper. 
% Vi kan teste, om residualerne er normalfordelte med et
% normalfordelingsplot. Residualerne hentes i stats objektet, der er output
% fra anovan:
resid = stats.resid

figure(2)
normplot(resid)

figure(3)
hold on;
scatter(batteri, resid, 'b', 'filled')
plot([0; 5], [0; 0], 'r')   % vandret referencelinje gennem (0,0)
title('Residualplot for batterityperne');
xlabel('Batteritype');
ylabel('Residualer');
axis([0 5 -7 6])
hold off;




