function OP = NormalTestMiddel(data, H0, testtype, procentKI)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Deskriptorer

middel = vpa(mean(data),3);

varians = var(data);

stdafv = std(data);

alpha_ki = (1 - procentKI/100);

% test

if testtype == "right"

    [h,p,ci,stats] = ztest(data, H0,stdafv,"Tail","right","Alpha", alpha_ki);
    test_val = norminv(procentKI/100, middel,stdafv);
    



elseif testtype == "left"

    [h,p,ci,stats] = ztest(data, H0,"Tail","left","Alpha", alpha_ki);
    test_val = norminv(1-procentKI/100, middel,stdafv);

elseif testtype == "both"

    [h,p,ci,stats] = ztest(data, H0,"Tail","both","Alpha", 0.025);
    test_val = norminv((alpha_ki/2), middel,stdafv);

    
    
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
disp("z-værdiens formel")

if testtype == "both"
    displayFormula("z_df_alpha/2 = norminv*(alpha/2 * n-1)")
else
    displayFormula("z_df_alpha = norminv*(alpha * n-1)")
end

disp("-----------------------------------------------------------------")
disp("Teststørrelsens formel")
displayFormula("z = (y_bar - mu_0) / (sigma*sqrt(n))")


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


    varnames2 = ["Nedre grænse","Øvre grænse","Teststatistikken","p-værdi","h-værdi"];

    disp(table(test_val,-test_val, vpa(stats,4),p,h, VariableNames=varnames2))

else
    varnames1 = ["Datanavn","Middelværdi","Varians","Standardafv.","Datapunkter"];
    navn = {inputname(1)};
    n = length(data);

    disp(table(cell2table(navn), round(middel,3), round(varians,3), round(stdafv,3), n, VariableNames=varnames1))


    varnames2 = ["Grænse","Teststatistikken","p-værdi","h-værdi"];

    disp(table(round(test_val,4), vpa(stats,4),p,h, VariableNames=varnames2))
end

%----------------%
%----- Plot -----%
%----------------%


xs = linspace(min(data)*0.95, max(data)*1.05, 300);
pd = normpdf(xs, middel,stdafv);

tvalpdf = normpdf(stats,middel,stdafv);

figure
plot(xs, pd, "DisplayName","Normal-fordeling")
hold on
if testtype == "right" || testtype == "left"
    xline(double(test_val), '--', "DisplayName","Kritiske grænse")


elseif testtype == "both"
    xline(-abs(double(test_val)), '-.', "DisplayName","Kritiske nedre grænse")
    xline(abs(double(test_val)), '--', "DisplayName","Kritiske øvre grænse")

end

title("Visualisering af t-fordelingen og kritisk(e) grænse(r)")
scatter(stats, tvalpdf,"filled", "DisplayName","z-statistik")
legend('show', 'location','best')

hold off

%-------------------%
%----- h-værdi -----%
%-------------------%

if h == 1

    disp("Da h = 1 forkastes nulhypotesen")
    disp("Ydermere ses det også at z-værdien " + double(stats) + " overstiger den kritiske grænse på " + double(test_val))
    %disp("Samt at p-værdien på " + p + " overstiger " + alpha_ki)
else

    disp("Da h = 0 forkastes nulhypotesen ikke")
    disp("Ydermere ses det også at z-værdien " + double(stats) + " ikke overstiger den kritiske grænse på " + double(test_val))
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
