function anal = ResidualMorten(mdl, data,plot)
% Residual, tager en regressions model og data
% data skal være i x:y 
% input
% mdl = model data fra regression
% data = ens data i en x:2 matrice hvor x er collone 1 og y er collone 2
% plot enten "ja" eller "nej"
k = size(data, 2) - 1;
y = data(:,k+1);
n = size(data, 1);
x = data(:,1:k);
k = size(x,2);
n = size(x,1);

lev = mdl.Diagnostics.Leverage;
rst = mdl.Residuals.Studentized;

lev_limit = 2*(k+1)/n;
rst_limit = 3;

lev_limit_array = zeros(1, length(lev));
rst_limit_array = zeros(1, length(rst));


for i = 1:length(lev)
    if lev_limit < lev(i)
        lev_limit_array(i) = 1;
    end
end

for i = 1:length(rst)
    if rst_limit < rst(i)
        rst_limit_array(i) = 1;
    end
end

[yhat, yci] = predict(mdl, x);
resid = y - yhat;

if plot == "ja"
figure(1);
scatter(yhat, resid, 30, "filled");
ylabel("e");
xlabel("yhat");

figure(2)
scatter(x, resid, 30, "filled")
ylabel("e")
xlabel("x")
else
end

levrage = lev_limit_array';
outlier = rst_limit_array'; 


% anal.data = table(x(:,1),x(:,2), y, lev, rst, levrage, outlier, yhat, yci, resid);
varnames = ["Regressor 1","Regressor 2","Afhængig variabel","Hat-diagonal","R-student","Løftestangspunkter","Outliers"];
anal.data = table(x(:,1),x(:,2), y, lev, rst, levrage, outlier,VariableNames=varnames);

varnames2 = ["Regressorer","Datapunkter","Løftepunkt max","R-student max"];
anal.data2 = table(k,n,lev_limit,rst_limit,VariableNames=varnames2);

anal.k = k;
anal.n = n;
anal.lev_limit = lev_limit;
anal.levlimit_formel = "k*(k+1)/n";
anal.rst_limit = rst_limit;




