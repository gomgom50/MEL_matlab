%% Opgave 2 om unders�gelse af inkubationstiden for Covid-19
clear; close all; clc; format compact; 

% Den naturlige logaritme til inkubationstiden er normalfordelt med disse
% parametre:
mu = 1.6196             % Middelv�rdi 
sigma = 0.4187          % Standardafvigelse


%% a. Hvor stor en andel har inkubationstid p� over 14 d�gn?
inku_14 = 14
log_inku_14 = log(inku_14)
andel_inku_under_14 = normcdf(log_inku_14, mu, sigma)
andel_inku_over_14 = 1 - andel_inku_under_14
% andel_inku_over_14 = 0.0074497, s� 0.7% har inkubationstid over 14 d�gn


%% b. Median
% F�rst finder vi medianen p� den normalfordelte skala, hvor vi har taget
% logaritmen til inkubationstiden. Medianen er den v�rdi, der deler arealet
% under kurven i to halvdele (medianen er lig med mu for symmetriske
% fordelinger som normalfordelingen):
log_medi = norminv(0.5, mu, sigma)
% Dern�st transformerer vi om til inkubationstid ved at tage exp()
medi = exp(log_medi)
% Medianen er 5.0511 d�gn, hvilket kan rundes op til 5.1 d�gn.


%% c. Hvorn�r har 95% af smittede udvist symptomer?
% Vi finder f�rst den v�rdi p� den normalfordelte, logaritmiske skala, der
% har et areal under kurven nedadtil p� 0.95:
log_inku_95 = norminv(0.95, mu, sigma)
% Dern�st omregnes den til inkubationstid ved at tage exp():
inku_95 = exp(log_inku_95)
% Efter 10.0573 d�gn har 95 pct af smittede udvist symptomer


%% d. Empirisk interval
% P� den normalfordelte skala er det empiriske interval:
logEI_lav  = mu - 3*sigma
logEI_hoej = mu + 3*sigma

% Nu konverterer jeg gr�nserne for det empiriske interval til
% inkubationstider: 
EI_lav  = exp(logEI_lav)
EI_hoej = exp(logEI_hoej)

% N�sten alle patienter vil alts� vise symptomer indenfor en periode af 1.4
% til 17.7 d�gn


