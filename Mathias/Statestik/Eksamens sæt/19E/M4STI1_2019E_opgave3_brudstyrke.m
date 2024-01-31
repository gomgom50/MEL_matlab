%% Opgave 3: Eksperiment med tre faktorer for optimering af brudstyrke
clc; clear; close all; format compact; 


%% Indlæs data
D = xlsread('Data_M4STI1_2019E', 'D:G')

x = D(:,1:3)
y = D(:,4)
Hastighed = x(:,1)
Tykkelse = x(:,2)
Temperatur = x(:,3)
n = 6   % Der er 6 gentagelser


%% a: Parallelle boksplots
figure(1)
boxplot(y, Hastighed, 'labels', {'1: 50 mm/s'; '2: 100 mm/s'})
title('Brudstyrke for forskellige printhastigheder af 3D printeren')
ylabel('Brudstyrke (N/mm^2)')
% De to boksplots for printhastighed ser nogenlunde ensartede ud. De har nogenlunde lige store kasser (interkvartil range) og ensartede koste. Måske er der en tendens til højere brudstyrke og mindre variation med den langsomme printhastighed.

figure(2)
boxplot(y, Tykkelse, 'labels', {'1: 1.75 mm'; '2: 2.85 mm'})
title('Brudstyrke for forskellige trådtykkelser af filamentet')
ylabel('Brudstyrke (N/mm^2)')
% De to boksplots for trådtykkelser ser også nogenlunde ensartede ud. Måske er der en tendens til højere brudstyrke og mindre variation med den tynde trådtykkelse.


figure(3)
boxplot(y, Temperatur, 'labels', {'175 C'; '200 C'; '225 C'})
title('Brudstyrke for forskellige printtemperaturer')
ylabel('Brudstyrke (N/mm^2)')
% De tre boksplots for printtemperataur ser også nogenlunde ensartede ud. Her er der en tendens til højere brudstyrke ved 200 grader. Medianen for 225 grader ligger over medianen for 175 grader, men de to har ensartede koste og interkvartile ranges.

%% b: Anova
[p,table,stats,terms] = anovan(y, x, 'model','full',...
    'varnames',{'Hastighed','Tykkelse','Temperatur'})

% Der er signifikant forskel på hastighederne       (p = 0.0428 < 0.05)
% Der er ikke signifikant forskel på tykkelserne    (p = 0.0782 > 0.05)
% Der er signifikant forskel på temperaturerne      (p = 0.0039 < 0.05)
% Der er hverken 2-faktor eller 3-faktor interaktioner, idet alle
% p-værdierne for disse tests er klart over signifikansniveauet på 5 %


%% c: Parvis sammenligning for temperatur
% Jeg skal bruge multcompare på den tredje faktor, temperatur, så 
% 'Dimension' skal være [3]:
[c,m] = multcompare(stats, 'Alpha',0.05, 'CType','lsd', 'Dimension',[3])

% Temperatur 2 (200 C) giver signifikant højere brudstyrke end begge de
% andre temperaturer. Brudstyrken er ikke signifikant forskellig for
% temperatur 1 (175 C) og temperatur 3 (225 C). 
% 95% konfidensintervaller for forskelle mellem temperaturer er:
% 1 og 2:   (-83.5; -21.8)
% 1 og 3:   (-47.5; 14.13)
% 2 og 3:   (5.1; 66.8)
% Vi ser at den sande forskel i brudstyrke mellem temperatur 1 og 3 kan
% være 0, da 0 er i konfidensintervallet (-47.5; 14.13). Den tilhørende
% p-værdi er 0.2828. 


%% d: Bedste og dårligste kombination
[c,m] = multcompare(stats,'Alpha',0.05, 'CType','lsd', 'Dimension', [1,2,3])

% Grafikken fra multcompare viser, at den bedste kombination er 
% hastighed 1, tykkelse 1 og temperatur 2. I matricen m, som er output fra
% multcompare kan jeg aflæse, at den kombination har en forventet 
% (gennemsnitlig) brudstyrke på 598.7 N/mm2, hvilket er den højeste værdi.
% 
% Den dårligste kombination er hastighed 2, tykkelse 2 og temperatur 1 med
% en gennemsnitlig brudstyrke på 493.5 N/mm2. 
% Grafikken viser også, at de to kombinationer er signifikant forskellige.
% P-værdien i sammenligningen af disse to kombinationer (4 og 5) er 0.0012.



%% e: Antagelser
% Vi har antaget, at residualerne er normalfordelte med middelværdi 0 og 
% med samme varians for hver faktor (varianshomogenitet). 
% Residualer findes i stats objektet, lavet af anovan
resid = stats.resid

figure(4)
normplot(resid)
% Residualerne ligger nogenlunde på en ret linje (dog ikke den røde linje i 
% grafikken), så de lader til at være normalfordelte, som antaget

figure(5)
scatter(Hastighed, resid, 'filled')
xlabel('Printerhastighed')
ylabel('Residualer')
title('Brudstyrke for forskellige printerhastigheder')
axis([0.5 2.5 -200 200])

figure(6)
scatter(Tykkelse, resid, 'filled')
xlabel('Tykkelse af filament')
ylabel('Residualer')
title('Brudstyrke for forskellige tykkelser af filament')
axis([0.5 2.5 -200 200])

figure(7)
scatter(Temperatur, resid, 'filled')
xlabel('Printertemperatur')
ylabel('Residualer')
title('Brudstyrke for forskellige printertemperaturer')
axis([0.5 3.5 -200 200])

% Alle tre residualplots er nogenlunde ensartede, så antagelsen om 
% varianshomogenitet lader til at være opfyldt.

% Alternativ:
% Vi kan lave en Bartlett's test for hver faktor 
vartestn(y, Hastighed)
vartestn(y, Tykkelse)
vartestn(y, Temperatur)
% For hver test er p-værdien over 5%, så vi kan ikke forkaste nulhypotesen,
% som siger, at variansen er ens. Vi kan således gå ud fra, at variansen er
% ens for alle faktorniveauer, som vi har antaget. De visuelle forskelle
% fra plots er ikke store nok til at være signifikante. 

