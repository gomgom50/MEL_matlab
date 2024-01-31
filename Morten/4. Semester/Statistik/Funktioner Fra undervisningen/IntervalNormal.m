function Output = IntervalNormal(mu, sigma, mini, maxi, intervaller)

% Funktion til fill i arealer under plots
% Inputs er plottet, dets interval x, funktionsværdierne f(x), liste med
% navne over invervallernes værdier, og selve værdierne
% Inputs:
% Fordelingstype: Normal
% Sigma: Varians
% mu: Middelværdi
% Min og max værdier
% Intervaller: [[fra, til], [fra, til], ...] dobbelt [] ikke nødvendigt

% Genererer punkter
x = linspace(mini, maxi, 1000);

% Laver fordelingen
dist = makedist("Normal","mu",mu,"sigma",sigma);

% Genererer fordelingsværdier
pd = pdf(dist,x);

it = intervaller;

% kumulerede sandsynligheder
p_kum = [];
for i = 1:length(intervaller)
    p_kum(end+1) = normcdf(it(i), mu, sigma);
end

% Sandsynlighedsintervaller
p_int = [p_kum(1), ];
for j = 2:length(p_kum)
    p_int(end+1) = p_kum(j) - p_kum(j-1);
end


% Interval sandsynligheds array
p_int_f = [p_int, 1-p_kum(end)];
p_kum_f = [p_kum, 1-p_kum(end)];

% Displaynames
for l = 1:length(p_int_f)
    names(l) = "p"+l +" = " + round(p_int_f(l),4);
end


figure;
plot(x, pd, 'LineWidth',2, "DisplayName","Fordelingsgraf", Color="b"), xlim([mini, maxi]), grid();
hold on


% ranges
rs = [];
for d = 1:length(it)
    rs(end+1) = length(find(x<it(d)));
end
rs;
% Første areal
area(x(1, 1:rs(1)), pd(1, 1:rs(1)), "DisplayName", names(1), facecolor="r");

%Plot colors
colors = ["g","c","m","k","w"];


for k = 2:length(rs)

    area(x(1, rs(k-1):rs(k)), pd(1, rs(k-1):rs(k)), "DisplayName",names(k), facecolor=colors(k-1));

end

% Sidste areal
area(x(1, rs(end):end), pd(1, rs(end):end), "DisplayName", names(end), facecolor="y");
alpha(0.5);
legend('show','location','best')
hold off

% Table over værdier


% Name generator
if length(it) == 1
    internames = ["-inf -> " + num2str(it(1)), num2str(it(1)) + " -> inf", "Sum"]';
elseif length(it) > 1
    for g = 1:length(it)-1
        internames(g) = it(g) + " til " + it(g+1);
    end
    internames = ["-inf -> " + num2str(it(1)),internames, num2str(it(end)) + " -> inf", "Sum"]';
end

varnames = ["Interval", "Sandsynligheder", "I procent"];



intervals = round([p_int_f, sum(p_int_f)],4)';

intervals_procent = num2str(intervals*100) + "%";

disp(table(internames, intervals, intervals_procent, VariableNames=varnames))

Output.sshs = p_int_f;

end