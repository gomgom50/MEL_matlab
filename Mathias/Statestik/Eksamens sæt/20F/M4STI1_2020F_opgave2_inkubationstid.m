%% Opgave 2 om undersøgelse af inkubationstiden for Covid-19
clear; close all; clc; format compact; 

% Den naturlige logaritme til inkubationstiden er normalfordelt med disse
% parametre:
mu = 1.6196             % Middelværdi 
sigma = 0.4187          % Standardafvigelse


%% a. Hvor stor en andel har inkubationstid på over 14 døgn?
inku_14 = 14
log_inku_14 = log(inku_14)
andel_inku_under_14 = normcdf(log_inku_14, mu, sigma)
andel_inku_over_14 = 1 - andel_inku_under_14
% andel_inku_over_14 = 0.0074497, så 0.7% har inkubationstid over 14 døgn


%% b. Median
% Først finder vi medianen på den normalfordelte skala, hvor vi har taget
% logaritmen til inkubationstiden. Medianen er den værdi, der deler arealet
% under kurven i to halvdele (medianen er lig med mu for symmetriske
% fordelinger som normalfordelingen):
log_medi = norminv(0.5, mu, sigma)
% Dernæst transformerer vi om til inkubationstid ved at tage exp()
medi = exp(log_medi)
% Medianen er 5.0511 døgn, hvilket kan rundes op til 5.1 døgn.


%% c. Hvornår har 95% af smittede udvist symptomer?
% Vi finder først den værdi på den normalfordelte, logaritmiske skala, der
% har et areal under kurven nedadtil på 0.95:
log_inku_95 = norminv(0.95, mu, sigma)
% Dernæst omregnes den til inkubationstid ved at tage exp():
inku_95 = exp(log_inku_95)
% Efter 10.0573 døgn har 95 pct af smittede udvist symptomer


%% d. Empirisk interval
% På den normalfordelte skala er det empiriske interval:
logEI_lav  = mu - 3*sigma
logEI_hoej = mu + 3*sigma

% Nu konverterer jeg grænserne for det empiriske interval til
% inkubationstider: 
EI_lav  = exp(logEI_lav)
EI_hoej = exp(logEI_hoej)

% Næsten alle patienter vil altså vise symptomer indenfor en periode af 1.4
% til 17.7 døgn


