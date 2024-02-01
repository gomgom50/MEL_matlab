% Opgave 2

%% a Hypotesetest
%  skridt 1
mu0 = 21.8
%  H0:  my = mu0
%  Ha:  my <> mu0
% Der er ingen oplysninger om at man formoder tykkkelsen er større
% eller mindre end mu0, så vi vælger tosidet alternativ hypotese, Ha:  my <> mu0

% Skridt 2
% t = (y_streg - mu0)/(s/sqrt(n))
% t er t-fordelt med n-1 frihedsgrader 

% skridt 3
alpha = 0.05;
n = 25;
% Kritisk værdi t0 ved 2-sidet hypotesetest:
t0 = -tinv(alpha/2, n-1)

% skridt 4
% Nu kan vi indlæse data og beregne teststørrelsen
y = xlsread('M4STI_2015_data.xlsx','A:A') 

y_streg = mean(y)
sumy2 = sum(y .* y)
s2 = (n*sumy2 - (sum(y))^2)/(n*(n-1)) % Stikprøve varians
s = sqrt(s2)        % Stikprøve spredning
t = (y_streg - mu0)/(s/sqrt(n))     % Teststørrelsen

% Skridt 5
% teststørrelsen |t| = 2.1072 er  større end den øvre kritiske grænse,
% t0 = 2.0639, så vi kan forkaste H0 på baggrund af stikprøven. 

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


