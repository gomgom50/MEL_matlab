% Afleverings input sheet
%% Dette sheet er et test sheet, hvor samtlige inputs til command window er samlet i. 

% Tidligere eksamen E15 Opgave 2.A: Skalprod
%% Det er ment at funktion skal returnere skalarproduktet af to vektorer.
% Det færdige script er vedhæftet i afleveringen. 

a = [-0.8 -1.1 2.5 1.7 0.3];
b = [-1.3 -0.9 -0.2 0.8 -1.3];
bb = [-1.3 -0.9 -0.2 0.8];

% Vi tilføjer et tjek hvad ans burde være ved indførsel af matlab egen
% skalprod funktion.
% Hertil er "bb" blevet kommenteret ud da funktionen ikke er sat op til
% script kørsel.

C = dot(a,b);
Opgave2A = skalprod(a,b);
%Opgave2Aa = skalprod(a,bb);
display(C)
display(Opgave2A)
%display(Opgave2Aa)

% Tidligere eksamen E15 Opgave 2.B: billettakst
%% Det er ment at funktion skal returnere billettaksten på en billet.
% Det færdige script er vedhæftet i afleveringen. 
display("Det følgende er Billettakst opgaven:");

zoner = [5 7 6 30 9];
billettype = ["rejsekort" "kort" "kontant" "kontant" "rejsekort"];
alder = ["barn" "voksen" "voksen" "barn" "voksen"];

for i = 1:length(zoner)
    try %Vi vil gerne loope over inputs så vi kan få samtlige ans.
        Billetpris(i) = billettakst(zoner(i),billettype(i),alder(i));
        if Billetpris == 0
            Billetpris(i) = [];
        end
        display(Billetpris(i));
    catch ME
        ME
    end
end

% Svarene kommer ud som tal, ME, tal, ME, tal.
% Helt specifikt: 14.25, ME, 60, ME, 51.5.
% Dette var forventet, da fejl beskederne skulle komme når det for
% henholdvis zoner og billettypen overgik de satte parametre på:
% zoner: < 2 || zoner > 26, error('Zoner skal være ml. 2 og 26')
% billettakst: if strcmp(billettype,'kontant') .. elseif strcmp(billettype,'rejsekort')
% else -> error('Ugyldig billettype')

% Tidligere eksamen E15 Opgave 2.C: numdiff
%% Det er ment at funktion skal returnere differentialkvotient
% Det færdige script er vedhæftet i afleveringen. 

% Der er forsøgt med følgende setup i kommando vinduet.
g = @(x) x^2+2*x-1;
Opgave2C = numdiff(g,2);

% Tjek på res:
syms x;
f = x^2+2*x-1;
Opgave2CDiff = matlabFunction(diff(f,x));
Opgave2CTjek = Opgave2CDiff(2);

Forskel2C = Opgave2C - Opgave2CTjek;
ProcentAfvigelse = Forskel2C / Opgave2CTjek * 100;


%Resultat = 6.0010
display(Opgave2C);
display(Opgave2CTjek);
display(Forskel2C);
display(ProcentAfvigelse);

% Den absolute forskel er 0.001 hvoraf den procentvise afvigelse er 0.0167%

% Tidligere eksamen E18 Opgave 4.A: ruteafstand
%% Det er ment at funktion skal returnere ruteafstanden mellem ruterne.
% Det færdige script er vedhæftet i afleveringen.

Opgave4A =  ruteafstand([2 4 5 7 3 1 2]);
Opgave4A2 = ruteafstand([2]);
display(Opgave4A);
display(Opgave4A2);

% Tjek af res:
% Vores afstande til næste by er defineret som: atbl(bynr(i),bynr(i+1))
% Dette vil sige, hvis vi har input [2 4] så vil den tage første input som
% afstand 2 hen og 4 ned, hvilket i forhold til atbl giver 119.
% For vores input array [2 4 5 7 3 1 2], så får vi følgende afstande:
% 119 + 274 + 72 + 70 + 168 + 307 

TjekAfRuteLaengde = 119 + 274 + 72 + 70 + 168 + 307;
display(TjekAfRuteLaengde);

% Resultatet af ruteafstand([2]) giver nul, af den mangler et input for
% col, men da den kun får row, så giver res ikke 307, som man kunne
% forvente.

% Tidligere eksamen E18 Opgave 4.B: iomr
%% Det er ment at funktion skal returnere ruteafstanden mellem ruterne.
% Det færdige script er vedhæftet i afleveringen.
x = [1 3 3.5 5 5.2 5.7 6.2];
y = [1 2.5 5.8 3 4.6 3 2];

for i=1:length(x)
    xx = iomr(x(i),y(i));
    display(xx)
end

% Vores figur har ikke en x værdi, der er større end 6, hvilket er årsagen
% til, at vi har tilføjet elseif x > 6 && y <= 2, i = 'nej';.

