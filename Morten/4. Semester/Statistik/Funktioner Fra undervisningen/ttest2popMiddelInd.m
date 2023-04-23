function OP = ttest2popMiddelInd(data, data2, testtype, procentKI, deltaH0)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% Deskriptorer


ybar1 = mean(data);
ybar2 = mean(data2);

var1 = var(data);
var2 = var(data2);

std1 = std(data);
std2 = std(data2);

nn1 = length(data);
nn2 = length(data2);

dfs = nn1 + nn2 - 2;

S = ((nn1 - 1)*var1 + (nn2 - 1)*var2)/dfs;
sp = sqrt(S);


% test

alpha_ki = (1 - procentKI/100);

if testtype == "right"

    [h,p,ci,stats] = ttest2(data, data2,"Tail","right","Alpha", alpha_ki);
    t0 = tinv(procentKI/100, stats.df);

elseif testtype == "left"

    [h,p,ci,stats] = ttest2(data, data2,"Tail","left","Alpha", alpha_ki);
    t0 = tinv(procentKI/100, stats.df);

elseif testtype == "both"

    [h,p,ci,stats] = ttest2(data, data2,"Tail","both","Alpha", alpha_ki/2);
    t0 = tinv((procentKI/100 + alpha_ki/2), stats.df);

end



if isempty(deltaH0)
    t = stats.tstat;
elseif ~isempty(deltaH0)

    t = (ybar1 - ybar2 - deltaH0)/(sp * sqrt(1/nn1 + 1/nn2));
end


%-------------------%
%----- Formler -----%
%-------------------%

disp("Frihedsgradernes formel")
displayFormula("df = n_1 + n_2 - 2")
disp("-----------------------------------------------------------------")

disp("Stikprøvemiddelværdiernes formel")
displayFormula("y_bar = Sigma*(y_i)/n")
disp("-----------------------------------------------------------------")

disp("Stikprøvevariansernes formel")
displayFormula("s = n*(Sigma(y_i^2) - Sigma(y_i)^2)/(n*(n-1))")
disp("-----------------------------------------------------------------")

disp("Pooled standardafvigelsens formel")
displayFormula("s_p = sqrt(((n_1-1)*s_1^2 + (n_2 - 1)*s_2^2)/(n_1 + n_2 - 2))")
disp("-----------------------------------------------------------------")

disp("t-værdiens formel")

if testtype == "both"
    displayFormula("t_df_alpha/2 = -tinv*(alpha/2 * df)")
else
displayFormula("t_df_alpha = -tinv*(alpha * df)")
end
disp("-----------------------------------------------------------------")

disp("Teststørrelsens formel")

if isempty(deltaH0)
    displayFormula("t_val = (y_bar1 - y_bar2) / (s_p*sqrt((1/n1) * (1/n2)))")
else
    displayFormula("t_val = (y_bar1 - y_bar2 - delta) / (s_p*sqrt((1/n1) * (1/n2)))")
end
disp("-----------------------------------------------------------------")



%--------------------%
%----- Tabeller -----%
%--------------------%

% Nøgleværdier
% Deskriptorer
names = ["Input 1";"Input 2"];
ybars = [ybar1; ybar2];
vars = [var1; var2];
stds = [std1;std2];
ns = [nn1; nn2];

varnames1 = ["Datanavne","Middelværdier","Spredning","standardafv.","Datapunkter"];

disp(table(names, ybars, vars, stds, ns, VariableNames=varnames1))

% beregnede værdier
bvals = [dfs;S;sp;t;t0;p;h];

varnames2 = ["Frihedsgrader","Pooled varians","Pooled spredning","Teststatistik","t0","p-værdi","h-værdi"];

disp(table(dfs,S,sp,t,t0,p,h, VariableNames=varnames2))


%----------------%
%----- Plot -----%
%----------------%

xs = linspace(-15, 15, 300);
pd = tpdf(xs, stats.df);

tvalpdf = tpdf(t, stats.df);

plot(xs, pd, "DisplayName","Students t-fordeling")
hold on
if testtype == "right" || testtype == "left"
    xline(t0, '--', "DisplayName","Kritiske grænse")


elseif testtype == "both"
    xline(-abs(t0), '-.', "DisplayName","Kritiske nedre grænse")
    xline(abs(t0), '--', "DisplayName","Kritiske øvre grænse")

end

title("Visualisering af t-fordelingen og kritisk(e) grænse(r)")
xlabel("t-værdier"), ylabel("t-statistik sandsynligheder")
grid("on")
scatter(t, tvalpdf,"filled", "DisplayName","t-statistik")
legend('show', 'location','best')

hold off

%-------------------%
%----- h-værdi -----%
%-------------------%

if h == 1

    disp("Da h = 1 forkastes nulhypotesen")
    disp("Ydermere ses det også at t-værdien " + t + " overstiger den kritiske grænse på " + t0)
    %disp("Samt at p-værdien på " + p + " overstiger " + alpha_ki)
else

    disp("Da h = 0 forkastes nulhypotesen ikke")
    disp("Ydermere ses det også at t-værdien " + t + " ikke overstiger den kritiske grænse på " + t0)
    %disp("Samt at p-værdien på " + p + " ikke overstiger " + alpha_ki)
    
end

OP.stats = stats;
OP.p = p;
OP.ci = ci;

end
