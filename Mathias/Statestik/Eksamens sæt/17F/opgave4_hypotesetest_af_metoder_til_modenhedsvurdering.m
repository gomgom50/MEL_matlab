%% Opgave 4: Hypetest af metoder til vurdering af æblers modenhed
clc; clear; close all; 

%% Indlæs og behandl data
D = xlsread('Data_M4STI1_2017F.xlsx','D:F')
Hue_ab = D(:,2)
a_stjerne = D(:,3)


%% a: Boxplot
figure(1)
boxplot([Hue_ab, a_stjerne], 'labels',{'Hue_ab','a*'})
title('Boxplot af to metoder til at vurdere æblers modenhed');
ylabel('Modenhedsscore [0-100]');

% Det parallelle boxplot viser meget ensartede boxplots for de to metoder. 
% Kasserne, kostene og kvartilerne er nogenlunde de samme, måske ligger
% kassen for a_stjerne en anelse lavere og har lidt mere variation. 
% Begge boxplots har en outlier, men det er bare et udtryk for, at der er 
% umodne æbler blandt de 24 udvalgte. Det lader til at begge metoder
% bedømmer dem som umodne, så det er ikke noget problem.


%% b-d Hypotesetest med to afhængige stikprøver med ukendt varians
% Bagrundsoplysninger
alfa = 0.05
n = 24

% Det samme æble er målt med begge metoder. Derfor er målingerne ikke uafhængige. 
% Vi foretager derfor hypotesetest på forskellen på de to målemetoder. 
% Vi beregner d som forskellen på metoderne og bruger d som en stikprøve. 
d = Hue_ab - a_stjerne

% Hvis metoderne er statistisk ens vil forskellen i gennemsnit være 0. 
% Vi lader delta betegne forskellen i populations-middelværdi for de to metoder. 


%% b: Skridt 1, Opstilling af hypoteser
% H0: delta = delta_0 = 0
% Ha: delta <> 0 (<> betyder 'forskellig fra', så det er en to-sidet test) 


%% c: Skridt 2, formel for teststatistikken
% d_0 = d_streg/(s_d/sqrt(n))
% hvor d_streg er gennemsnit af forskellen på de to stikprøver, dvs. 
% d_streg er middelværdien af d, s_d er standardafvigelsen af d og n er
% stikprøvestørrelsen. 
% Teststatistikken d_0 er t-fordelt med n-1 frihedsgrader.


%% d: Skridt 3-5
% Skridt 3: kritisk region
% Da det er en to-sidet test forkaster vi nulhypotesen, hvis 
% |d_0| > t_alfahalve
% hvor t_alfahalve er den værdi, hvor P(t>t_alfahalve) = alfa/2
t_alfahalve = tinv(1 - alfa/2, n-1)

% Skridt 4: Beregning af teststørrelsen
d_streg = mean(d)   % Stikprøvemiddelværdi
s_d = std(d,0)      % Stikprøve-standardafvigelse
d_0 = d_streg/(s_d/sqrt(n))

% Alternativt kan stikprøve-standardafvigelsen beregnes 'manuelt':
% s_d = sqrt((n*d'*d - sum(d,1)^2)/(n*(n-1)))

% Skridt 5: Konklusion
% Vi kan se, at d_streg = 2.1250, så i gennemsnit bedømmer metoden Hue_ab
% æblerne 2 enheder højdere end a_stjerne. Er denne forskel statistisk 
% signifikant? Da teststatistikken d_0 = 3.0237 er større end den øvre 
% kritiske grænse på t_alfahalve = 2.0687 kan vi forkaste nulhypotesen om,
% at der ikke er forskel på metoderne. 
% Vi kan beregne p-værdien: 
pvalue = 2*(1 - tcdf(d_0, n-1))
% P-værdien er 0.0060, så hvis der ikke var forskel på metoderne, så ville
% vi tilfældigvis få en stikprøve med den observerede forskel, eller mere,
% i 0.6% af tilfældene. Med andre ord: Vores hypotesetest viser, at der er
% forskel på de to metoder. Testen siger ikke noget om, hvilken metode, der
% er bedst. 


%% e: 95% konfidensinterval
ki_bredde = t_alfahalve*s_d/sqrt(n)
ki = [d_streg - ki_bredde, d_streg + ki_bredde]


%% f: Diskussion
% Selv om forskellen på de to metoder ser ud til at være minimal på de
% parallelle boxplots, så viser hypotesetesten, at forskellen er
% signifikant på 5% signifikansniveau. 95% konfidensintervallet viser, at
% forskellen på metoderne ligger imellem 0.6712 og 3.5788 med 95%
% sikkerhed. Da 0 ikke ligger i konfidensintervallet er dette en alternativ
% måde at vise, at der er forskel på de to metoder. 


%% g: Antagelser
% Vores antagelse om, at teststatistikken d_0 følger en t-fordeling med n-1
% frihedsgrader, kommer af den centrale grænseværdisætning. Den holder
% uanset hvilken fordeling stikprøven kommer fra, hvis stikprøvestørrelsen
% n er tilstrækkeligt stor, typisk over 30. Da n=24 skal vi undersøge om
% stikprøven kommer fra en 'pæn' fordeling, helst symmetrisk med et enkelt 
% toppunkt og hurtigt uddøende haler

stemleafplot(d,-1)

figure(2)
histogram(d,6)

figure(3)
normplot(d)

% Stem-and-leaf plot og histogram viser en nogenlunde symmetrisk fordeling 
% med hurtigt uddøende haler. Der er lidt tvivl om den har flere toppunkter, 
% men det kan skyldes tilfældigheder. 
% Normalfordelingsplottet er nogenlunde lineært. Heldigvis betyder den ret 
% høje stikprøvestørrelse på 24, at den centrale grænseværdisætning holder, 
% også selv om fordelingen ikke er så ’pæn’, som vi kunne ønske. 
% Vi kan altså roligt gå ud fra, at antagelsen holder.