function output = chi2normal(obs, forv, procentKI, params, kategorier)
% obs og forv skal være i formatet obs(1, :)


%-------------------%
%----- Formler -----%
%-------------------%

disp("Formel for teststørrelsen")
displayFormula("chi_0^2 = (Sigma_i)^k*((O_i - E_i)^2/E_i)")
disp("-----------------------------------------------------------------")
disp("Antal frihedsgrader")
displayFormula("dfs = k - p - 1")
disp("-----------------------------------------------------------------")
disp("Kritiske grænse - MATLAB kommando")
displayFormula("chi_alpha^2 = chi2inv*(alpha * dfs)")
disp("-----------------------------------------------------------------")



alpha_ki = (1 - procentKI/100);

procentKI = procentKI/100;


chi2_0 = sum(((obs - forv) .^ 2) ./ forv);

if nargin == 4 || isempty(kategorier)
    df =  length(obs) - params - 1;
elseif nargin == 5 || ~isempty(kategorier)
    df =  kategorier - params - 1;
end

chisqstat = chi2inv(procentKI, df);

xs = linspace(0, (chisqstat+10), 300);
pd = chi2pdf(xs, df);

tvalpdf = chi2pdf(chi2_0, df);


%Table
varnames = ["Signifikansniveau","Parametre", "Frihedsgrader","Kritisk grænse","Teststørrelse"];
disp(table("%"+alpha_ki*100,params,df,chisqstat,chi2_0, VariableNames=varnames))



%plot
plot(xs, pd, "DisplayName","Chi2-fordelingen"), grid("on")
hold on

scatter(chi2_0, tvalpdf,"filled", "DisplayName","teststørrelsen")

title("Visualisering af chi2-fordelingen og kritisk grænse")
xlabel('$\chi^2$','Interpreter','latex')
ylabel("Sandsynlighed")
xline(chisqstat,'--', "DisplayName","Kritisk grænse")
legend('show', 'location','best')

hold off





end