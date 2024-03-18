function OP = StudentTestMiddel_Test2(data, H0, testtype, procentKI)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Deskriptorer

middel = vpa(mean(data),3);

varians = var(data);

stdafv = std(data);

alpha_ki = (1 - procentKI/100);

% test

if testtype == "right"

    [h,p,ci,stats] = ttest(data, H0,"Tail","right","Alpha", alpha_ki);
    test_val = tinv(procentKI/100, length(data) - 1);
    
    disp("H0 afvises, hvis t > t0 (hvor t0 er teststatistikken)")


elseif testtype == "left"

    [h,p,ci,stats] = ttest(data, H0,"Tail","left","Alpha", alpha_ki);
    test_val = tinv(1-procentKI/100, length(data) - 1);

    disp("H0 afvises, hvis t < t0 (hvor t0 er teststatistikken)")

elseif testtype == "both"

    [h,p,ci,stats] = ttest(data, H0,"Tail","both","Alpha", 0.025);
    test_val = tinv((alpha_ki/2), length(data) - 1);

    disp("H0 afvises, hvis t_nedre < t0 > t_øvre (hvor t0 er teststatistikken)")

end




%-------------------%
%----- Formler -----%
%-------------------%

disp("Stikprøvemiddelværdiens formel")
displayFormula("y_bar = Sigma*(y_i)/n")
disp("-----------------------------------------------------------------")
disp("Stikprøvevariansens formel")
displayFormula("s = n*(Sigma(y_i^2) - Sigma(y_i)^2)/(n*(n-1))")
disp("-----------------------------------------------------------------")
disp("Stikprøvestandardafvigelsens formel")
displayFormula("s = sqrt(n*(Sigma(y_i^2) - Sigma(y_i)^2)/(n*(n-1)))")
disp("-----------------------------------------------------------------")
disp("t-værdiens formel")

if testtype == "both"
    displayFormula("t_df_alpha/2 = tinv*(alpha/2 * n-1)")
else
    displayFormula("t_df_alpha = tinv*(alpha * n-1)")
end

disp("-----------------------------------------------------------------")
disp("Teststatistikkens formel")
displayFormula("t_0 = (y_bar - mu_0) / (s*sqrt(n))")


%--------------------%
%----- Tabeller -----%
%--------------------%

% Nøgleværdier
% Deskriptorer

disp("----------------------------------------------------------------------------------------------")

if testtype == "both"

    varnames1 = ["Datanavn","Middelværdi","Varians","Standardafv.","Datapunkter"];
    navn = {inputname(1)};
    n = length(data);

    disp(table(cell2table(navn), round(middel,3), round(varians,3), round(stdafv,3), n, VariableNames=varnames1))


    varnames2 = ["Frihedsgrader","Nedre grænse","Øvre grænse","Teststatistikken","p-værdi","h-værdi"];

    disp(table(stats.df,test_val,-test_val, vpa(stats.tstat,4),p,h, VariableNames=varnames2))

else
    varnames1 = ["Datanavn","Middelværdi","Varians","Standardafv.","Datapunkter"];
    navn = {inputname(1)};
    n = length(data);

    disp(table(cell2table(navn), round(middel,3), round(varians,3), round(stdafv,3), n, VariableNames=varnames1))


    varnames2 = ["Frihedsgrader","Grænse","Teststatistikken","p-værdi","h-værdi"];

    disp(table(stats.df, test_val, vpa(stats.tstat,4),p,h, VariableNames=varnames2))
end

%----------------%
%----- Plot -----%
%----------------%


xs = linspace(-15, 15, 300);
pd = tpdf(xs, stats.df);

tvalpdf = tpdf(stats.tstat, stats.df);

figure("Visible","on")
plot(xs, pd, "DisplayName","Students t-fordeling")
hold on
if testtype == "right" || testtype == "left"
    xline(test_val, '--', "DisplayName","Kritiske grænse")


elseif testtype == "both"
    xline(-abs(test_val), '-.', "DisplayName","Kritiske nedre grænse")
    xline(abs(test_val), '--', "DisplayName","Kritiske øvre grænse")

end

title("Visualisering af t-fordelingen og kritisk(e) grænse(r)")
scatter(stats.tstat, tvalpdf,"filled", "DisplayName","t_0")
legend('show', 'location','best')

hold off

%-------------------%
%----- h-værdi -----%
%-------------------%

if h == 1

    disp("Da h = 1 forkastes nulhypotesen")
    disp("Ydermere ses det også at t-værdien " + stats.tstat + " overstiger den kritiske grænse på " + test_val)
    %disp("Samt at p-værdien på " + p + " overstiger " + alpha_ki)
else

    disp("Da h = 0 forkastes nulhypotesen ikke")
    disp("Ydermere ses det også at t-værdien " + stats.tstat + " ikke overstiger den kritiske grænse på " + test_val)
    %disp("Samt at p-værdien på " + p + " ikke overstiger " + alpha_ki)

end

% if h == 1
%
%     disp("Da h = 1 forkastes nulhypytesen")
%     disp("Ydermere ses det også at t-værdien " + stats.tstat + " overstiger den kritiske grænse på " + test_val)
% else
%
%     disp("Da h = 0 forkastes nulhypytesen ikke")
%     disp("Vi er altså " + procentKI + "% overbeviste om at populationsmiddelværdien " + ...
%         "ligger mellem " + ci(1) + " og " + ci(2))
% end

end
