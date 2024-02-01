function [t] = t_student(data,s,true_my)
%Udregner student t
%   output er t
% Input:
% data = dataen
% s = stikprøe varians
% true_my = den sande middelværdig 
% Output:
% t
n = length(data);
y = mean(data);
t = (y - true_my)/(s / sqrt(n));
end