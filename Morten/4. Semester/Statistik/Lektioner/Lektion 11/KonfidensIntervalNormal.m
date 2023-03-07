function Output = KonfidensIntervalNormal(data, procentKI, std)
% Array af data, 1 række á n søjler
% Ønsket konfidensinterval
% Kendes populations-standardafvigelsen? popstd = 0 for nej = 1 for ja



if  ~isempty(std)
    disp("Da populations-standardafvigelsen er kendt, bruges følgende formel til " + ...
        "at udregne konfidensintervallet")
    displayFormula("y_bar + z_alpha/2 * sigma/sqrt(n)")
    displayFormula("y_bar - z_alpha/2 * sigma/sqrt(n)")
    x = data';

    alpha_ki = (1 - procentKI/100)/2;
    n = length(data);
    y_bar = 1/n * sum(data);

    pd_ki = makedist("Normal","mu",y_bar,"sigma",std);

    t_int = norminv(alpha_ki);
    
    upper_t = y_bar + t_int*std/sqrt(n);
    lower_t = y_bar - t_int*std/sqrt(n);

    ki_mu = [upper_t; lower_t];

    pd_ki = makedist("Normal","mu",y_bar,"sigma",std);

elseif isempty(std)
    % Hvis populations-standardafvigelsen ikke kendes, skal Students-t
    % fordeling benyttes
    disp("Da populations-standardafvigelsen er ukendt, bruges følgende formel til " + ...
        "at udregne konfidensintervallet")
    displayFormula("y_bar + t_df_alpha/2 * s/sqrt(n)")
    displayFormula("y_bar - t_df_alpha/2 * s/sqrt(n)")

    x = data;

    n = length(data);
    y_bar = 1/n * sum(data);

    % Stikprøvevarians
    s_2 = (n * sum(data.^2) - sum(data)^2)/(n*(n-1));
    s = sqrt(s_2);

    alpha_ki = (1 - procentKI/100)/2;

    t_int = -tinv(alpha_ki, n-1);

    upper_t = y_bar + t_int*s/sqrt(n);
    lower_t = y_bar - t_int*s/sqrt(n);

    ki_mu = [lower_t; upper_t];

    pd_ki = makedist("Normal","mu",y_bar,"sigma",s);

end


% Til plot

xs = min(x)*0.98:0.1:max(x)*1.02;

lower = find(xs < ki_mu(1));
upper = find(xs > ki_mu(2));

pd = pdf(pd_ki, xs);

plot(xs, pd, "DisplayName","Fordelingsplot"), grid()
hold on

area(xs(1:length(lower)), pd(1:length(lower)), "DisplayName","mindre end "+ki_mu(1))
area(xs(upper(1):end), pd(upper(1):end), "DisplayName","større end "+ki_mu(2))

alpha(0.5)
title(procentKI + "% konfidensinterval")
legend('show', 'location','best')
hold off

% Tabel med værdier

int_names = ["Nedre"; "Øvre"];

disp(table(int_names, round(ki_mu, 6), 'VariableNames',["Interval","Værdier"]))


end