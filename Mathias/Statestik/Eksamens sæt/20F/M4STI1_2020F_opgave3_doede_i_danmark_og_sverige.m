%% Opgave 3 om udviklingen af d�dstal i Danmark og Sverige
clc; clear; close all; format compact;

D = xlsread('Data_M4STI1_2020F', 'A:C')
dagnr = D(:,1)
dk_total = D(:,2)  
se_total = D(:,3)


%% a. Samlet graf over udviklingen af d�de i DK og SE
figure(1)
hold on;
plot(dagnr, dk_total, 'rx-')
plot(dagnr, se_total, 'bo-')
hold off;
title('Samlet antal d�de med Covid-19')
xlabel('Dagnummer')
ylabel('Antal d�de')
legend('Danmark', 'Sverige', 'Location', 'northwest')


%% b. Justering af data
pop_dk = 5.8                % Antal millioner indbyggere i Danmark
pop_se = 10.3               % Antal millioner indbyggere i Sverige
dk_mio = D(:,2)./pop_dk     % Antal d�de med Covid-19 pr million i DK
se_mio = D(:,3)./pop_se     % Antal d�de med Covid-19 pr million i SE

startdag = 11               % Smid data for de f�rste 10 dage v�k
slutdag = size(dagnr,1)
dk_mio2 = dk_mio(startdag:slutdag)
se_mio2 = se_mio(startdag:slutdag)
dagnr2  = dagnr(startdag:slutdag)

figure(2)
hold on;
plot(dagnr2, dk_mio2, 'rx-')
plot(dagnr2, se_mio2, 'bo-')
hold off;
title('Samlet antal d�de med Covid-19 pr. million indbyggere')
xlabel('Dagnummer')
ylabel('Antal d�de pr. million indbyggere')
legend('Danmark', 'Sverige', 'Location', 'northwest')


%% c. Line�re modeller for DK og SE
% Line�r model
mdl_lin_dk = fitlm(dagnr2, dk_mio2)
mdl_lin_se = fitlm(dagnr2, se_mio2)

% C_lin_dk = -180.35 + 2.1735*t
% C_lin_se = -394.07 + 4.6168*t


%% d. Er det gode modeller?
% Begge line�re modeller er gode, if�lge statistikkerne for den line�re
% regression. Koefficienterne i begge modeller er signifikant forskellige
% fra nul med meget lave p-v�rdier (st�rste p-v�rdi er 2.1e-14, alts� meget
% t�t p� 0). Den danske model beskriver variationen i data bedre end den
% svenske, da R-squared er 0.982, mod 0.916 i den svenske. Adjusted
% R-squared er t�t p� R-squared for begge modeller med hhv. 0.981 og 0.912,
% s� modellerne overfitter ikke. 
% Grafen fra delsp�rgsm�l b. viser dog, at begge kurver ikke forl�ber
% line�rt. Is�r viser kurven for Sverige et stigende forl�b, s� m�ske er en
% polynomiel eller en eksponentiel model bedre.


%% e. Hvorn�r n�s 1000 d�de?
% For en line�r funktion y = b0 + b1*x kan vi isolere x:
% x = (y - b0)/b1
% Derfor g�lder for den danske model:
t_lin_dk = (1000 + 180.35)/2.1735
% ... og for den svenske:
t_lin_se = (1000 + 394.07)/4.6168
% Danmark forventes at runde 1000 d�de pr. million p� dag nummer 543 (inden
% dag nummer 544), mens Sverige g�r det allerede p� dag nummer 301 (lige
% inden starten af dag 302).


%% f. Unormale punkter
% Studentiserede residualer og hatdiagonal for den danske model
rst_lin_dk = mdl_lin_dk.Residuals.Studentized
lev_lin_dk = mdl_lin_dk.Diagnostics.Leverage

% Studentiserede residualer og hatdiagonal for den svenske model
rst_lin_se = mdl_lin_se.Residuals.Studentized
lev_lin_se = mdl_lin_se.Diagnostics.Leverage

% Gr�nsev�rdi for l�ftestangspunkt beregnes:
k = 1                       % Antal regressorvariable i hver model
n = size(dagnr2,1)           % Antal observationer bag hver model
lev_limit = 2*(k+1)/n       % Gr�nsev�rdi lev_limit = 0.1429

% Test for om der er outliers i den danske model. 
% Hvis den absolutte v�rdi af det studentiserede residual er over 3, s� er
% det en outlier. Jeg bruger denne kode i stedet for at g� tallene igennem
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

% Test for om der er l�ftestangspunkter i den danske model. Hvis et punkts
% hatdiagonal er over gr�nsev�rdien lev_limit, er det et l�ftestangspunkt.
if any(lev_lin_dk > lev_limit)
    disp('Der er mindst et l�ftestangspunkt i den danske model')
else
    disp('Der er ingen l�ftestangspunkter i den danske model')
end

% Test for om der er l�ftestangspunkter i den svenske model. 
if any(lev_lin_se > lev_limit)
    disp('Der er mindst et l�ftestangspunkt i den svenske model')
else
    disp('Der er ingen l�ftestangspunkter i den svenske model')
end

% Der er ingen unormale punkter, hverken outliers eller l�ftestangspunkter,
% og derfor heller ingen inflydelsespunkter. Det g�lder for begge modeller. 


%% g. Eksponentiel model for Danmark og Sverige
% Hvis modellen er eksponentiel, bliver den line�r ved at tage logaritmen
% C = B*exp(A*t) => log(C) = log(B) + A*t
% En line�r regression vil alts� give koefficienterne log(B) og A, hvor
% log(B) er sk�ring med andenaksen og A er h�ldningkoefficienten.

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
% Jeg vil gerne plotte den line�re og den eksponentielle model mod data for
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
title('Samlet antal d�de med Covid-19 pr. million indbyggere')
xlabel('Dagnummer')
ylabel('Antal d�de pr. million indbyggere')
legend('Danmark data', 'Danmark line�r model', 'Danmark eksponentiel model', ...
    'Sverige data', 'Sverige line�r model', 'Sverige eksponentiel model', ...
    'Location', 'northwest')


%% h. Hvilken model er bedst for de to lande? 
% If�lge statistikkerne for lin�r regression er b�de den line�re og den
% eksponentielle model gode til at beskrive udviklingen af antal d�de pr.
% million indbyggere for b�de Danmark og Sverige. I alle fire modeller er
% R-squared over 0.90, s� en stor del af variationen i data beskrives af
% modellerne. Adjusted R-squared er i alle tilf�lde en anelse mindre end
% R-squared, og alle koefficienter er signifikante med meget sm� p-v�rdier.
% S� alle fire modeller er gode.

% Dog er det tydeligt fra figuren fra delsp�rgsm�l b., at udviklingen ser
% mest line�r ud i Danmark og mest eksponentiel ud i Sverige.

% Vi kan ogs� se af R-squared, at det forholder sig s�dan. For Danmark er
% R-squared = 0.98 for den line�re model mod 0.92 for den eksponentielle.
% For Sverige er det den eksponentielle model, der beskriver variationen i
% data lidt bedre end den line�re, da R-squared er 0.96 for den
% eksponentielle og 0.92 for den line�re.

% Derfor vil jeg v�lge den line�re model for Danmark og den eksponentielle
% model for Sverige. Det kunne v�re en teori, at forskellene i udvikling
% skyldes forskellene i bek�mpelsesstrategi, hvor den danske regering har
% indf�rt mere restriktive tiltag for at reducere en for voldsom
% smittespredning.
