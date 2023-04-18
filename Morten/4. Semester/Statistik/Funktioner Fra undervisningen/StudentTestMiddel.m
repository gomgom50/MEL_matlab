function OP = StudentTestMiddel(data, H0, testtype, procentKI)
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

elseif testtype == "left"

    [h,p,ci,stats] = ttest(data, H0,"Tail","left","Alpha", alpha_ki);
    test_val = tinv(procentKI/100, length(data) - 1);

elseif testtype == "both"

    [h,p,ci,stats] = ttest(data, H0,"Tail","both","Alpha", alpha_ki/2);
    test_val = tinv((procentKI/100 + alpha_ki/2), length(data) - 1);

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
    displayFormula("t_df_alpha/2 = -tinv*(alpha/2 * n-1)")
else
displayFormula("t_df_alpha = -tinv*(alpha * n-1)")
end

disp("-----------------------------------------------------------------")
disp("Teststørrelsens formel")
displayFormula("t = (y_bar - mu_0) / (s*sqrt(n))")


%--------------------%
%----- Tabeller -----%
%--------------------%

% Nøgleværdier
% Deskriptorer

disp("----------------------------------------------------------------------------------------------")

varnames1 = ["Datanavn","Middelværdi","Spredning","Standardafv.","Datapunkter"];
navn = {inputname(1)};
n = length(data);

disp(table(cell2table(navn), middel, varians, stdafv, n, VariableNames=varnames1))


varnames2 = ["Frihedsgrader","Teststatistik","t0","p-værdi","h-værdi"];

disp(table(stats.df,vpa(stats.tstat,2),test_val,p,h, VariableNames=varnames2))

%----------------%
%----- Plot -----%
%----------------%


xs = linspace(-15, 15, 300);
pd = tpdf(xs, stats.df);

tvalpdf = tpdf(stats.tstat, stats.df);

plot(xs, pd, "DisplayName","Students t-fordeling")
hold on
if testtype == "right" || testtype == "left"
    xline(test_val, '--', "DisplayName","Kritiske grænse")


elseif testtype == "both"
    xline(-abs(test_val), '-.', "DisplayName","Kritiske nedre grænse")
    xline(abs(test_val), '--', "DisplayName","Kritiske øvre grænse")

end

title("Visualisering af t-fordelingen og kritisk(e) grænse(r)")
scatter(stats.tstat, tvalpdf,"filled", "DisplayName","t-statistik")
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
