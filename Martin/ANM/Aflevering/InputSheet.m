% Afleverings input sheet
%% Dette sheet er et test sheet, hvor samtlige inputs til command window er samlet i. 

% Tidligere eksamen E15 Opgave 2.A: Skalprod
%% Det er ment at funktion skal returnere skalarproduktet af to vektorer.
% Det færdige script er vedhæftet i afleveringen. 

a = [-0.8 -1.1 2.5 1.7 0.3];
b = [-1.3 -0.9 -0.2 0.8 -1.3];

% Vi tilføjer et tjek hvad ans burde være ved indførsel af matlab egen
% skalprod funktion.

C = dot(a,b);
Opgave2A = skalprod(a,b);
display(C)
display(Opgave2A)

% Tidligere eksamen E15 Opgave 2.B: billettakst
%% Det er ment at funktion skal returnere billettaksten på en billet.
% Det færdige script er vedhæftet i afleveringen. 

% Der er forsøgt med følgende setup i kommando vinduet.
zoner = 13;
billettype = 'kontant';
alder1 = 'barn';
Opgave2B1 = billettakst(zoner,billettype,alder1);
display(Opgave2B1);
%Resultat: 65 // Korrekt svar.

zoner = 10;
billettype = 'rejsekort';
alder2 = 'barn';
Opgave2B2 = billettakst(zoner,billettype,alder2);
display(Opgave2B2);
%Resultat = 28.75 // Korrektsvar

%% Denne del er kommenteret ud da koden ikke er gennemtænkt til brug i script.
%%% Den kan køres, men ødelægger det for resten af test kommandoerne for
%%% resten af afleveringsopgaverne.
%zoner = 27;
%billettype = 'kontant';
%alder3 = 'voksen';
%Opgave2B3 = billettakst(zoner,billettype,alder3);
%display(Opgave2B3);
% Error: 'Zoner skal være ml. 2 og 26'

% Tidligere eksamen E15 Opgave 2.C: numdiff
%% Det er ment at funktion skal returnere differentialkvotient
% Det færdige script er vedhæftet i afleveringen. 

% Der er forsøgt med følgende setup i kommando vinduet.
g = @(x) x^2+2*x-1;
Opgave2C = numdiff(g,2);
%Resultat = 6.0010
display(Opgave2C);

% Tidligere eksamen E18 Opgave 4.A: ruteafstand
%% Det er ment at funktion skal returnere ruteafstanden mellem ruterne.
% Det færdige script er vedhæftet i afleveringen.

Opgave4A =  ruteafstand([2 4 5 7 3 1 2]);
Opgave4A2 = ruteafstand(2);
display(Opgave4A);
display(Opgave4A2);