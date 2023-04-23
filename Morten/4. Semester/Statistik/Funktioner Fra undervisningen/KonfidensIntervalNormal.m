function Output = KonfidensIntervalNormal(data, procentKI, std, middel)
% Array af data, 1 række á n søjler
% Ønsket konfidensinterval



if  ~isempty(std)

    % Data der ikke skal displayes
    x = data';
    obs = length(data);

    disp("Da populations-standardafvigelsen er kendt, vides det pr. den")
    disp("centrale grænseværdi sætning at stikprøven er standard normalfordelt")



    disp("Først regnes stikprøvemiddelværdien")
    displayFormula("y_bar = Sigma*(y_i)/n")

    y_bar_x = 1/obs * sum(data)

    disp("Z værdien skal findes, vha. følgende formel")

    displayFormula("z_alpha/2 = norminv*(alpha/2)")

    alpha_ki = (1 - procentKI/100)/2;
    % Z-værdi
    z_alpha_halve = norminv(alpha_ki);
    test_vals = [z_alpha_halve; abs(z_alpha_halve)]

    test_names = ["Z nedre";" Z øvre"];


    pd_ki = makedist("Normal","mu",y_bar_x,"sigma",std);




    displayFormula("Upper = y_bar + z_alpha/2 * sigma/sqrt(n)")

    upper_t = y_bar_x + z_alpha_halve*std/sqrt(obs)

    displayFormula("Lower = y_bar - z_alpha/2 * sigma/sqrt(n)")
    lower_t = y_bar_x - z_alpha_halve*std/sqrt(obs)

    ki_mu = [upper_t; lower_t];

    pd_ki = makedist("Normal","mu",y_bar_x,"sigma",std);

    disk = ["y_bar", "sigma"]';

    disk_vals = [y_bar_x, std]';

    if ~isempty(middel)
        % Teststørrelse
        disp("Teststørrelsen udregnes, til sammenligning")
        displayFormula("z = y_bar - mu_0 / (sigma*sqrt(n))")
        test = (y_bar_x - middel) / (sigma/sqrt(obs))
    elseif isempty(middel)
        disp("Ingen sand middelværdi opgivet")
    end

elseif isempty(std)



    % Hvis populations-standardafvigelsen ikke kendes, skal Students-t
    % fordeling benyttes
    fprintf("Da populations-standardafvigelsen er ukendt, følger stikprøven")
    disp("Students-t fordeling, med n-1 frihedsgrader, hvor n er antal værdier i stikprøven")


    x = data;

    obs = length(data);

    c
    y_bar_x = 1/obs * sum(data)

    % Stikprøvevarians
    s_2 = (obs * sum(data.^2) - sum(data)^2)/(obs*(obs-1));

    disp("Stikprøvestandardafvigelsen beregnes")
    displayFormula("s = sqrt(n*(Sigma(y_i^2) - Sigma(y_i)^2)/(n*(n-1)))")
    s_val = sqrt(s_2)

    alpha_ki = (1 - procentKI/100);


    disp("t-værdien findes")
    displayFormula("t_df_alpha/2 = -tinv*(alpha/2 * n-1)")
    t_alpha2 = -tinv(alpha_ki, obs-1);
    test_vals = [-t_alpha2; t_alpha2]
    test_names = ["t nedre";"t øvre"];


    disp("Øvre konfidensinterval værdi")
    displayFormula("y_bar + t_df_alpha/2 * s/sqrt(n)")
    upper_t = y_bar_x + t_alpha2*s_val/sqrt(obs)

    disp("Nedre konfidensinterval værdi")
    displayFormula("y_bar - t_df_alpha/2 * s/sqrt(n)")
    lower_t = y_bar_x - t_alpha2*s_val/sqrt(obs)

    ki_mu = [lower_t; upper_t];

    pd_ki = makedist("Normal","mu",y_bar_x,"sigma",s_val);

    disk = ["y_bar", "s"]';

    disk_vals = [y_bar_x, s_val]';

    if ~isempty(middel)
        % Teststørrelse
        disp("Teststørrelsen udregnes, til sammenligning")
        displayFormula("t = (y_bar - mu_0) / (s*sqrt(n))")
        test = (y_bar_x - middel) / (s_val/sqrt(obs))
    elseif isempty(middel)
        disp("Ingen sand middelværdi opgivet")
    end

% Test til 2 stikprøver der er t-fordelte


end


% Tabel med værdier

int_names = ["Nedre"; "Øvre"];


disp(table(int_names, round(ki_mu, 4), test_names, test_vals, disk, disk_vals, 'VariableNames',["Interval","Værdier","Test type","Testværdier","Værdi", "Deskriptorer"]))

% Til plot
% 
% xs = min(x)*0.95:0.1:max(x)*1.05;
% 
% lower = find(xs < ki_mu(1))
% upper = find(xs > ki_mu(2))
% 
% pd = pdf(pd_ki, xs);
% 
% plot(xs, pd, "DisplayName","Fordelingsplot"), grid()
% hold on
% 
% area(xs(1:length(lower)), pd(1:length(lower)), "DisplayName","Nedre KI "+ki_mu(1))
% area(xs(upper(1):end), pd(upper(1):end), "DisplayName","Øvre KI "+ki_mu(2))
% 
% alpha(0.5)
% title(procentKI + "% konfidensinterval")
% legend('show', 'location','best')
% hold off
% 



end