function output = chi2normal_Test_8_uafh(obs, forv, procentKI)
% obs og forv skal være i formatet obs(1, :)


%-------------------%
%----- Formler -----%
%-------------------%

disp("Formel for teststørrelsen")
displayFormula("chi_0^2 = (Sigma_i)^k*(Sigma_j)^k*((O_ij - E_ij)^2/E_ij)")
disp("-----------------------------------------------------------------")
disp("Antal frihedsgrader")
displayFormula("dfs = (r-1)*(c-1)")
disp("-----------------------------------------------------------------")
disp("Kritiske grænse - MATLAB kommando")
displayFormula("chi_alpha^2 = chi2inv*(alpha * dfs)")
disp("-----------------------------------------------------------------")



alpha_ki = (1 - procentKI/100);

procentKI = procentKI/100;


for i = 1:size(obs,1)
    for j = 1:size(forv,1)
        chi2_0(i,j) = ((obs(i,j) - forv(i,j)) .^ 2) ./ forv(i,j);
    end
end

chi2_0 = sum(sum(chi2_0));

df = (size(obs,1) - 1)*(size(obs,2)-1);

% Kritisk
chisqstat = chi2inv(procentKI, df);

xs = linspace(0, (chisqstat+6), 300);
pd = chi2pdf(xs, df);

tvalpdf = chi2pdf(chi2_0, df);


%Table
varnames = ["Signifikansniveau", "Frihedsgrader","Kritisk grænse","Teststørrelse"];
disp(table("%"+alpha_ki*100,df,chisqstat,chi2_0, VariableNames=varnames))



%plot
figure
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