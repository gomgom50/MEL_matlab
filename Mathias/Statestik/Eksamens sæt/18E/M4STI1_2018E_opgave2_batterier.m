%% M4STI1 2018E opgave 2: Variansanalyse af forskellige batteriers driftstid
clear; close all; clc; format compact; format shortG;

%% Indl�s og behandl data
M = xlsread('Data_M4STI1_2018E.xlsx','C:D')

batteritype = M(:,1)
driftstid  = M(:,2)

%% a: Parallelt boxplot for hver batteritype
figure(1)
boxplot(driftstid, batteritype)
title('M�lt driftstid af tre batterityper');
ylabel('Driftstid (sekunder)');

% Batteritype 1 og 3 har nogenlunde samme median, hvor type 2 ligger 
% tydeligt lavere.  
% Boxplottene for type 2 og 3 ser meget ensartede ud, bortset fra niveauet, 
% hvor type 3 ligger h�jere end type 2. Type 1 ligger p� niveau med type 3, 
% men lader til at have lidt st�rre variation. Der er dog ikke stor forskel
% p� afstanden imellem kostenes ender p� type 1 og 3.
% Da hvert boxplot er tegnet p� baggrund af kun 5 observationer er det
% sv�rt at konkludere, alene ud fra boxplottet, om der er reelle 
% forskelle p� de tre batterityper.


%% b: Variansanalyse (ANOVA)
[p,table,stats] = anovan(driftstid, batteritype)
% Variansanalysen har F = 2.9 og en tilh�rende p-v�rdi p� 0.0938. Det vil
% sige, at vi kan ikke afvise p� 5 % signifikansniveau, at alle 3
% batterityper opf�rer sig ens (da 0.0938 > 0.05). Med andre ord:  
% Bed�mt ud fra variansanalysen kan alle tre batterityper have samme 
% forventede driftstid. 


%% c: Parvis sammenligning af batterityperne med LSD metoden
% Signifikansniveau alfa:
alfa = 0.05
[c,m] = multcompare(stats,  'Alpha',alfa,  'CType','lsd')

% Type 1 er ikke forskellig fra hverken type 2 eller 3 
% Type 2 og type 3 er forskellige p� 5% signifikansniveau (p-v�rdi 0.0417)



%% d: Holder antagelserne for residualerne? 
% Det er en antagelse i variansanalysen, at residualerne er normalfordelte 
% med middelv�rdi 0 og med samme varians for alle batterityper. 
% Vi kan teste, om residualerne er normalfordelte med et
% normalfordelingsplot. Residualerne hentes i stats objektet, der er output
% fra anovan:
resid = stats.resid

figure(2)
normplot(resid)

% Residualerne ligger nogenlunde p� en ret linje, s� den antagelse ser ud
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

% Residualerne for type 2 og 3 er meget ensartede, men de er lidt st�rre
% for type 1. Vi kan unders�ge med en Bartlett's test, om der er
% signifikant forskel: 

vartestn(driftstid, batteritype)

% Bartlett's testen viser, at vi ikke kan forkaste nulhypotesen om at
% variansen er ens for de tre typer. P-v�rdien p� 0.65138 fort�ller, at vi
% kan forvente residualer som vores, eller mere ekstreme i 65% af
% tilf�ldene, hvis de tre batterityper har samme varians. Derfor
% konkluderer vi, at de har samme varians, s� antagelsen om 
% varianshomogenitet holder.


%% e: Min foretrukne type batteri
% For at beregne minimum, maksimum, median og middelv�rdi for hver 
% batteritype opdeler jeg data i array'et A med en kolonne for hver type:
A = [driftstid(1:5), driftstid(6:10), driftstid(11:15)]
maksimum = max(A,[],1)
medianer = median(A,1)
minimum = min(A,[],1)
middelv = mean(A,1)

% Valget st�r mellem type 1 og 3, der begge har h�je driftstider, 
% sammenlignet med type 2. 
% Type 1 har b�de det h�jeste maksimum (11453 s mod 11446 s for type 3) og
% den h�jeste median (10451 s mod 11446 s). Men type 1 har ogs� det laveste
% bundniveau sammenlignet med type 3 (8317 s mod 8968 s). 
% Forskellene i maksimum og median er dog meget sm�. 
% Type 3 har den h�jeste middelv�rdi (10311 mod 9997 for type 1). 
% Jeg ville v�lge type 3, fordi det lader til at give mere ensartet 
% driftstid end type 1. Bartlett's testen viste godt nok at denne forskel 
% i varians ikke var statistisk signifikant, men i mangel af bedre kriterier
% foretr�kker jeg batteritype 3. 
%


