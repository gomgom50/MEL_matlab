%% Opgave 3 om udviklingen af dødstal i Danmark og Sverige
clc; clear; close all; format compact;

D = xlsread('Data_M4STI1_2020F', 'A:C')
dagnr = D(:,1)
dk_total = D(:,2)  
se_total = D(:,3)


%% a. Samlet graf over udviklingen af døde i DK og SE
figure(1)
hold on;
plot(dagnr, dk_total, 'rx-')
plot(dagnr, se_total, 'bo-')
hold off;
title('Samlet antal døde med Covid-19')
xlabel('Dagnummer')
ylabel('Antal døde')
legend('Danmark', 'Sverige', 'Location', 'northwest')


%% b. Justering af data
pop_dk = 5.8                % Antal millioner indbyggere i Danmark
pop_se = 10.3               % Antal millioner indbyggere i Sverige
dk_mio = D(:,2)./pop_dk     % Antal døde med Covid-19 pr million i DK
se_mio = D(:,3)./pop_se     % Antal døde med Covid-19 pr million i SE

startdag = 11               % Smid data for de første 10 dage væk
slutdag = size(dagnr,1)
dk_mio2 = dk_mio(startdag:slutdag)
se_mio2 = se_mio(startdag:slutdag)
dagnr2  = dagnr(startdag:slutdag)

figure(2)
hold on;
plot(dagnr2, dk_mio2, 'rx-')
plot(dagnr2, se_mio2, 'bo-')
hold off;
title('Samlet antal døde med Covid-19 pr. million indbyggere')
xlabel('Dagnummer')
ylabel('Antal døde pr. million indbyggere')
legend('Danmark', 'Sverige', 'Location', 'northwest')


%% c. Lineære modeller for DK og SE
% Lineær model
mdl_lin_dk = fitlm(dagnr2, dk_mio2)
mdl_lin_se = fitlm(dagnr2, se_mio2)

% C_lin_dk = -180.35 + 2.1735*t
% C_lin_se = -394.07 + 4.6168*t


%% d. Er det gode modeller?
% Begge lineære modeller er gode, ifølge statistikkerne for den lineære
% regression. Koefficienterne i begge modeller er signifikant forskellige
% fra nul med meget lave p-værdier (største p-værdi er 2.1e-14, altså meget
% tæt på 0). Den danske model beskriver variationen i data bedre end den
% svenske, da R-squared er 0.982, mod 0.916 i den svenske. Adjusted
% R-squared er tæt på R-squared for begge modeller med hhv. 0.981 og 0.912,
% så modellerne overfitter ikke. 
% Grafen fra delspørgsmål b. viser dog, at begge kurver ikke forløber
% lineært. Især viser kurven for Sverige et stigende forløb, så måske er en
% polynomiel eller en eksponentiel model bedre.


%% e. Hvornår nås 1000 døde?
% For en lineær funktion y = b0 + b1*x kan vi isolere x:
% x = (y - b0)/b1
% Derfor gælder for den danske model:
t_lin_dk = (1000 + 180.35)/2.1735
% ... og for den svenske:
t_lin_se = (1000 + 394.07)/4.6168
% Danmark forventes at runde 1000 døde pr. million på dag nummer 543 (inden
% dag nummer 544), mens Sverige gør det allerede på dag nummer 301 (lige
% inden starten af dag 302).


%% f. Unormale punkter
% Studentiserede residualer og hatdiagonal for den danske model
rst_lin_dk = mdl_lin_dk.Residuals.Studentized
lev_lin_dk = mdl_lin_dk.Diagnostics.Leverage

% Studentiserede residualer og hatdiagonal for den svenske model
rst_lin_se = mdl_lin_se.Residuals.Studentized
lev_lin_se = mdl_lin_se.Diagnostics.Leverage

% Grænseværdi for løftestangspunkt beregnes:
k = 1                       % Antal regressorvariable i hver model
n = size(dagnr2,1)           % Antal observationer bag hver model
lev_limit = 2*(k+1)/n       % Grænseværdi lev_limit = 0.1429

% Test for om der er outliers i den danske model. 
% Hvis den absolutte værdi af det studentiserede residual er over 3, så er
% det en outlier. Jeg bruger denne kode i stedet for at gå tallene igennem
% manuelt
if any(abs(rst_lin_dk) > 3)
    disp('Der er mindst en outlier i den danske model')
else
    disp('Der er ingen outliers i den danske model')
end

% Test for om der er outliers i den svenske model.
if any(abs(rst_lin_se) > 3)
    disp('Der er mindst en outlier i den svenske model')
else
    disp('Der er ingen outliers i den svenske model')
end

% Test for om der er løftestangspunkter i den danske model. Hvis et punkts
% hatdiagonal er over grænseværdien lev_limit, er det et løftestangspunkt.
if any(lev_lin_dk > lev_limit)
    disp('Der er mindst et løftestangspunkt i den danske model')
else
    disp('Der er ingen løftestangspunkter i den danske model')
end

% Test for om der er løftestangspunkter i den svenske model. 
if any(lev_lin_se > lev_limit)
    disp('Der er mindst et løftestangspunkt i den svenske model')
else
    disp('Der er ingen løftestangspunkter i den svenske model')
end

% Der er ingen unormale punkter, hverken outliers eller løftestangspunkter,
% og derfor heller ingen inflydelsespunkter. Det gælder for begge modeller. 


%% g. Eksponentiel model for Danmark og Sverige
% Hvis modellen er eksponentiel, bliver den lineær ved at tage logaritmen
% C = B*exp(A*t) => log(C) = log(B) + A*t
% En lineær regression vil altså give koefficienterne log(B) og A, hvor
% log(B) er skæring med andenaksen og A er hældningkoefficienten.

log_dk = log(dk_mio2)
log_se = log(se_mio2)

mdl_exp_dk = fitlm(dagnr2, log_dk)
mdl_exp_se = fitlm(dagnr2, log_se)

% Dansk eksponentiel model:
% log(C_exp_dk) = -8.9644 + 0.12465*t
% C_exp_dk = exp(-8.9644 + 0.12465*t)
% C_exp_dk = exp(-8.9644)*exp(0.12465*t) = (1.2788e-04)*exp(0.12465*t)

% Svensk eksponentiel model:
% C_exp_se = exp(-12.904)*exp(0.16878*t) = (2.4881e-06)*exp(0.16878*t)

%% Ekstra - ikke en del af opgaven.
% Jeg vil gerne plotte den lineære og den eksponentielle model mod data for
% de to lande:
C_lin_dk = -180.35 + 2.1735*dagnr2
C_lin_se = -394.07 + 4.6168*dagnr2
C_exp_dk = 1.2788e-04*exp(0.12465*dagnr2)
C_exp_se = (2.4881e-06)*exp(0.16878*dagnr2)

figure(3)
hold on;
plot(dagnr2, dk_mio2, 'rx')
plot(dagnr2, C_lin_dk, 'r--')
plot(dagnr2, C_exp_dk, 'r-')
plot(dagnr2, se_mio2, 'bo')
plot(dagnr2, C_lin_se, 'b--')
plot(dagnr2, C_exp_se, 'b-')
hold off;
title('Samlet antal døde med Covid-19 pr. million indbyggere')
xlabel('Dagnummer')
ylabel('Antal døde pr. million indbyggere')
legend('Danmark data', 'Danmark lineær model', 'Danmark eksponentiel model', ...
    'Sverige data', 'Sverige lineær model', 'Sverige eksponentiel model', ...
    'Location', 'northwest')


%% h. Hvilken model er bedst for de to lande? 
% Ifølge statistikkerne for linær regression er både den lineære og den
% eksponentielle model gode til at beskrive udviklingen af antal døde pr.
% million indbyggere for både Danmark og Sverige. I alle fire modeller er
% R-squared over 0.90, så en stor del af variationen i data beskrives af
% modellerne. Adjusted R-squared er i alle tilfælde en anelse mindre end
% R-squared, og alle koefficienter er signifikante med meget små p-værdier.
% Så alle fire modeller er gode.

% Dog er det tydeligt fra figuren fra delspørgsmål b., at udviklingen ser
% mest lineær ud i Danmark og mest eksponentiel ud i Sverige.

% Vi kan også se af R-squared, at det forholder sig sådan. For Danmark er
% R-squared = 0.98 for den lineære model mod 0.92 for den eksponentielle.
% For Sverige er det den eksponentielle model, der beskriver variationen i
% data lidt bedre end den lineære, da R-squared er 0.96 for den
% eksponentielle og 0.92 for den lineære.

% Derfor vil jeg vælge den lineære model for Danmark og den eksponentielle
% model for Sverige. Det kunne være en teori, at forskellene i udvikling
% skyldes forskellene i bekæmpelsesstrategi, hvor den danske regering har
% indført mere restriktive tiltag for at reducere en for voldsom
% smittespredning.
