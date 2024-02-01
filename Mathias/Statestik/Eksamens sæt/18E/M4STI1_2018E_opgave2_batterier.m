%% M4STI1 2018E opgave 2: Variansanalyse af forskellige batteriers driftstid
clear; close all; clc; format compact; format shortG;

%% Indlæs og behandl data
M = xlsread('Data_M4STI1_2018E.xlsx','C:D')

batteritype = M(:,1)
driftstid  = M(:,2)

%% a: Parallelt boxplot for hver batteritype
figure(1)
boxplot(driftstid, batteritype)
title('Målt driftstid af tre batterityper');
ylabel('Driftstid (sekunder)');

% Batteritype 1 og 3 har nogenlunde samme median, hvor type 2 ligger 
% tydeligt lavere.  
% Boxplottene for type 2 og 3 ser meget ensartede ud, bortset fra niveauet, 
% hvor type 3 ligger højere end type 2. Type 1 ligger på niveau med type 3, 
% men lader til at have lidt større variation. Der er dog ikke stor forskel
% på afstanden imellem kostenes ender på type 1 og 3.
% Da hvert boxplot er tegnet på baggrund af kun 5 observationer er det
% svært at konkludere, alene ud fra boxplottet, om der er reelle 
% forskelle på de tre batterityper.


%% b: Variansanalyse (ANOVA)
[p,table,stats] = anovan(driftstid, batteritype)
% Variansanalysen har F = 2.9 og en tilhørende p-værdi på 0.0938. Det vil
% sige, at vi kan ikke afvise på 5 % signifikansniveau, at alle 3
% batterityper opfører sig ens (da 0.0938 > 0.05). Med andre ord:  
% Bedømt ud fra variansanalysen kan alle tre batterityper have samme 
% forventede driftstid. 


%% c: Parvis sammenligning af batterityperne med LSD metoden
% Signifikansniveau alfa:
alfa = 0.05
[c,m] = multcompare(stats,  'Alpha',alfa,  'CType','lsd')

% Type 1 er ikke forskellig fra hverken type 2 eller 3 
% Type 2 og type 3 er forskellige på 5% signifikansniveau (p-værdi 0.0417)



%% d: Holder antagelserne for residualerne? 
% Det er en antagelse i variansanalysen, at residualerne er normalfordelte 
% med middelværdi 0 og med samme varians for alle batterityper. 
% Vi kan teste, om residualerne er normalfordelte med et
% normalfordelingsplot. Residualerne hentes i stats objektet, der er output
% fra anovan:
resid = stats.resid

figure(2)
normplot(resid)

% Residualerne ligger nogenlunde på en ret linje, så den antagelse ser ud
% til at holde. Antagelsen om varianshomogenitet kan vi teste visuelt med
% et plot af residualerne: 

figure(3)
hold on;
scatter(batteritype, resid, 'b', 'filled')
plot([0; 4], [0; 0], 'r')   % vandret referencelinje gennem (0,0)
title('Residualplot for batterityperne');
xlabel('Batteritype');
ylabel('Residualer');
axis([0 4 -2000 2000])
hold off;

% Residualerne for type 2 og 3 er meget ensartede, men de er lidt større
% for type 1. Vi kan undersøge med en Bartlett's test, om der er
% signifikant forskel: 

vartestn(driftstid, batteritype)

% Bartlett's testen viser, at vi ikke kan forkaste nulhypotesen om at
% variansen er ens for de tre typer. P-værdien på 0.65138 fortæller, at vi
% kan forvente residualer som vores, eller mere ekstreme i 65% af
% tilfældene, hvis de tre batterityper har samme varians. Derfor
% konkluderer vi, at de har samme varians, så antagelsen om 
% varianshomogenitet holder.


%% e: Min foretrukne type batteri
% For at beregne minimum, maksimum, median og middelværdi for hver 
% batteritype opdeler jeg data i array'et A med en kolonne for hver type:
A = [driftstid(1:5), driftstid(6:10), driftstid(11:15)]
maksimum = max(A,[],1)
medianer = median(A,1)
minimum = min(A,[],1)
middelv = mean(A,1)

% Valget står mellem type 1 og 3, der begge har høje driftstider, 
% sammenlignet med type 2. 
% Type 1 har både det højeste maksimum (11453 s mod 11446 s for type 3) og
% den højeste median (10451 s mod 11446 s). Men type 1 har også det laveste
% bundniveau sammenlignet med type 3 (8317 s mod 8968 s). 
% Forskellene i maksimum og median er dog meget små. 
% Type 3 har den højeste middelværdi (10311 mod 9997 for type 1). 
% Jeg ville vælge type 3, fordi det lader til at give mere ensartet 
% driftstid end type 1. Bartlett's testen viste godt nok at denne forskel 
% i varians ikke var statistisk signifikant, men i mangel af bedre kriterier
% foretrækker jeg batteritype 3. 
%


