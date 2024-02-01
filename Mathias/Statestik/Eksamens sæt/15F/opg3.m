%% Opgave 3

M = xlsread('M4STI_2015_data.xlsx','C:D') 

Legering = M(:,1)   % Behandlinger
Styrke = M(:,2)   % Respons


%% a
figure(1)
boxplot(Styrke, Legering)

%% b
[p,table,stats] = anova1(Styrke, Legering)

%% c
[c,m,h,gnames] = multcompare(stats,  'Alpha',0.05,  'CType','lsd')

%% d
% 1 og 2 har begge sammenligneligt højt niveau, men 2 har mindre varians,
% så jeg vælger legerning 2
