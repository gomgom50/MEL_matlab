%% M4STI E2015 opgave 3 om missilsystemer
clc; clear all; close all;

M = xlsread('M4STI1_2015E_data.xlsx', 'C:E')

MissilSystem = M(:,1)   % Faktor 1
Braendstof = M(:,2)     % Faktor 2
Fremdriftskraft = M(:,3)   % Respons


%% a
figure(1)
boxplot(Fremdriftskraft, MissilSystem)
title('Fremdriftskraft for 3 missilsystemer')

figure(2)
boxplot(Fremdriftskraft, Braendstof)
title('Fremdriftskraft for 4 br�ndstoftyper')

%% b
[p,table,stats] = anovan(Fremdriftskraft, [MissilSystem,Braendstof], 'model',  'interaction', 'varnames',{'MissilSystem','Braendstof'})


%% c
%[c,m,h,gnames] = multcompare(stats,'Alpha',0.05, 'CType','lsd') 
figure(4)
[c,m] = multcompare(stats,'Alpha',0.05, 'CType','lsd', 'Dimension', [1])

figure(5)
[c,m] = multcompare(stats,'Alpha',0.05, 'CType','lsd', 'Dimension', [2])

%% d
figure(6)
boxplot(Fremdriftskraft, [MissilSystem,Braendstof])
title('Fremdriftskraft for kombinationer af missilsystemer og br�ndstoftyper')

figure(7)
[c,m] = multcompare(stats,'Alpha',0.05, 'CType','lsd', 'Dimension', [1,2])

% Svar: kombinationen af missilsystem 2 og br�ndstoftype 1 er bedst, b�de 
% med h�jeste median og med fhv. lille varians. 
% Men der er 5 andre kombinationer, som ikke er signifikant forskellige
%

%% e
% resudualer findes i stats objektet, lavet af anovan
resid = stats.resid

figure(8)
normplot(resid)

figure(9)
scatter(MissilSystem, resid, 'filled')
xlabel('Missilsystem')
ylabel('Residualer')

figure(10)
scatter(Braendstof, resid, 'filled')
xlabel('Br�ndstofsystem')
ylabel('Residualer')

y_hat = [Fremdriftskraft - resid]  
% For hver observation beregnes estimatet for fremdriftskraften

figure(11)
scatter(y_hat, resid, 'filled')
xlabel('Estimat')
ylabel('Residualer')

% Antagelserne er ikke s�rligt godt underbygget; Normplottet er ikke
% line�rt (fig. 8), residualerne er ikke ens for de enkelte faktorer (fig.
% 9 og 10, men residualerne lader dog ikke til at afh�nge af y_hat
% Det er tvivlsomt om eksperimentet kan bruge til at konkludere, 
% hvilken kombination af missilsystem og br�ndstoftype, der b�r v�lges.




