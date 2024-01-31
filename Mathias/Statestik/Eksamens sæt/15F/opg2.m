% Opgave 2

%% a Hypotesetest
%  skridt 1
mu0 = 21.8
%  H0:  my = mu0
%  Ha:  my <> mu0
% Der er ingen oplysninger om at man formoder tykkkelsen er st�rre
% eller mindre end mu0, s� vi v�lger tosidet alternativ hypotese, Ha:  my <> mu0

% Skridt 2
% t = (y_streg - mu0)/(s/sqrt(n))
% t er t-fordelt med n-1 frihedsgrader 

% skridt 3
alpha = 0.05;
n = 25;
% Kritisk v�rdi t0 ved 2-sidet hypotesetest:
t0 = -tinv(alpha/2, n-1)

% skridt 4
% Nu kan vi indl�se data og beregne testst�rrelsen
y = xlsread('M4STI_2015_data.xlsx','A:A') 

y_streg = mean(y)
sumy2 = sum(y .* y)
s2 = (n*sumy2 - (sum(y))^2)/(n*(n-1)) % Stikpr�ve varians
s = sqrt(s2)        % Stikpr�ve spredning
t = (y_streg - mu0)/(s/sqrt(n))     % Testst�rrelsen

% Skridt 5
% testst�rrelsen |t| = 2.1072 er  st�rre end den �vre kritiske gr�nse,
% t0 = 2.0639, s� vi kan forkaste H0 p� baggrund af stikpr�ven. 

%%% b.  95% konfidensinterval
CIbredde = tinv(1-alpha/2, n-1)*s/sqrt(n)
CI1 = y_streg - CIbredde
CI2 = y_streg + CIbredde
% 95% konfidensintervallet er (CI1, CI2) = (21.64, 21.79)
% mu0=21.8 er udenfor konfidensintervallet 

%%% c. 95% Prediktionsinterval
PIbredde = tinv(1-alpha/2, n-1)*s*sqrt(1+1/n)
PI1 = y_streg - PIbredde
PI2 = y_streg + PIbredde
% 95% prediktionsintervallet er (PI1, PI2) = (21.29, 22.14)


