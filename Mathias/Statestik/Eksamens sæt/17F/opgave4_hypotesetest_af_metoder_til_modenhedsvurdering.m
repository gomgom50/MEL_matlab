%% Opgave 4: Hypetest af metoder til vurdering af �blers modenhed
clc; clear; close all; 

%% Indl�s og behandl data
D = xlsread('Data_M4STI1_2017F.xlsx','D:F')
Hue_ab = D(:,2)
a_stjerne = D(:,3)


%% a: Boxplot
figure(1)
boxplot([Hue_ab, a_stjerne], 'labels',{'Hue_ab','a*'})
title('Boxplot af to metoder til at vurdere �blers modenhed');
ylabel('Modenhedsscore [0-100]');

% Det parallelle boxplot viser meget ensartede boxplots for de to metoder. 
% Kasserne, kostene og kvartilerne er nogenlunde de samme, m�ske ligger
% kassen for a_stjerne en anelse lavere og har lidt mere variation. 
% Begge boxplots har en outlier, men det er bare et udtryk for, at der er 
% umodne �bler blandt de 24 udvalgte. Det lader til at begge metoder
% bed�mmer dem som umodne, s� det er ikke noget problem.


%% b-d Hypotesetest med to afh�ngige stikpr�ver med ukendt varians
% Bagrundsoplysninger
alfa = 0.05
n = 24

% Det samme �ble er m�lt med begge metoder. Derfor er m�lingerne ikke uafh�ngige. 
% Vi foretager derfor hypotesetest p� forskellen p� de to m�lemetoder. 
% Vi beregner d som forskellen p� metoderne og bruger d som en stikpr�ve. 
d = Hue_ab - a_stjerne

% Hvis metoderne er statistisk ens vil forskellen i gennemsnit v�re 0. 
% Vi lader delta betegne forskellen i populations-middelv�rdi for de to metoder. 


%% b: Skridt 1, Opstilling af hypoteser
% H0: delta = delta_0 = 0
% Ha: delta <> 0 (<> betyder 'forskellig fra', s� det er en to-sidet test) 


%% c: Skridt 2, formel for teststatistikken
% d_0 = d_streg/(s_d/sqrt(n))
% hvor d_streg er gennemsnit af forskellen p� de to stikpr�ver, dvs. 
% d_streg er middelv�rdien af d, s_d er standardafvigelsen af d og n er
% stikpr�vest�rrelsen. 
% Teststatistikken d_0 er t-fordelt med n-1 frihedsgrader.


%% d: Skridt 3-5
% Skridt 3: kritisk region
% Da det er en to-sidet test forkaster vi nulhypotesen, hvis 
% |d_0| > t_alfahalve
% hvor t_alfahalve er den v�rdi, hvor P(t>t_alfahalve) = alfa/2
t_alfahalve = tinv(1 - alfa/2, n-1)

% Skridt 4: Beregning af testst�rrelsen
d_streg = mean(d)   % Stikpr�vemiddelv�rdi
s_d = std(d,0)      % Stikpr�ve-standardafvigelse
d_0 = d_streg/(s_d/sqrt(n))

% Alternativt kan stikpr�ve-standardafvigelsen beregnes 'manuelt':
% s_d = sqrt((n*d'*d - sum(d,1)^2)/(n*(n-1)))

% Skridt 5: Konklusion
% Vi kan se, at d_streg = 2.1250, s� i gennemsnit bed�mmer metoden Hue_ab
% �blerne 2 enheder h�jdere end a_stjerne. Er denne forskel statistisk 
% signifikant? Da teststatistikken d_0 = 3.0237 er st�rre end den �vre 
% kritiske gr�nse p� t_alfahalve = 2.0687 kan vi forkaste nulhypotesen om,
% at der ikke er forskel p� metoderne. 
% Vi kan beregne p-v�rdien: 
pvalue = 2*(1 - tcdf(d_0, n-1))
% P-v�rdien er 0.0060, s� hvis der ikke var forskel p� metoderne, s� ville
% vi tilf�ldigvis f� en stikpr�ve med den observerede forskel, eller mere,
% i 0.6% af tilf�ldene. Med andre ord: Vores hypotesetest viser, at der er
% forskel p� de to metoder. Testen siger ikke noget om, hvilken metode, der
% er bedst. 


%% e: 95% konfidensinterval
ki_bredde = t_alfahalve*s_d/sqrt(n)
ki = [d_streg - ki_bredde, d_streg + ki_bredde]


%% f: Diskussion
% Selv om forskellen p� de to metoder ser ud til at v�re minimal p� de
% parallelle boxplots, s� viser hypotesetesten, at forskellen er
% signifikant p� 5% signifikansniveau. 95% konfidensintervallet viser, at
% forskellen p� metoderne ligger imellem 0.6712 og 3.5788 med 95%
% sikkerhed. Da 0 ikke ligger i konfidensintervallet er dette en alternativ
% m�de at vise, at der er forskel p� de to metoder. 


%% g: Antagelser
% Vores antagelse om, at teststatistikken d_0 f�lger en t-fordeling med n-1
% frihedsgrader, kommer af den centrale gr�nsev�rdis�tning. Den holder
% uanset hvilken fordeling stikpr�ven kommer fra, hvis stikpr�vest�rrelsen
% n er tilstr�kkeligt stor, typisk over 30. Da n=24 skal vi unders�ge om
% stikpr�ven kommer fra en 'p�n' fordeling, helst symmetrisk med et enkelt 
% toppunkt og hurtigt udd�ende haler

stemleafplot(d,-1)

figure(2)
histogram(d,6)

figure(3)
normplot(d)

% Stem-and-leaf plot og histogram viser en nogenlunde symmetrisk fordeling 
% med hurtigt udd�ende haler. Der er lidt tvivl om den har flere toppunkter, 
% men det kan skyldes tilf�ldigheder. 
% Normalfordelingsplottet er nogenlunde line�rt. Heldigvis betyder den ret 
% h�je stikpr�vest�rrelse p� 24, at den centrale gr�nsev�rdis�tning holder, 
% ogs� selv om fordelingen ikke er s� �p�n�, som vi kunne �nske. 
% Vi kan alts� roligt g� ud fra, at antagelsen holder.