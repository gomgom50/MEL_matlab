function [s, ss] = stik_standard_afvigelse(data)
% Udregner stik varians (ss) og stik standard afvigelse (s)
% med data som input.
%
% Kald: [s, ss] = stik_standard_afvigelse(data)
% Input:
%   data = dataen
% Output:
%   s = stikprøve standard afvigelsen    
%   ss = stikprøve variansen   
data_op = data.^2;
n = length(data);
ss = (n*sum(data_op)-(sum(data))^2)/(n*(n-1));
s = sqrt(ss);
end