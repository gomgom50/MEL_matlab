function [s] = stik_standard_afvigelse(data)
%Udregner stik varians (s) med data som input
data_op = data.^2;
n = length(data);
ss = (n*sum(data_op)-(sum(data))^2)/(n*(n-1));
s = sqrt(ss);
end