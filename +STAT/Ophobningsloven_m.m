function [y, u_y] = Ophobningsloven_m(f, vars_and_u)
% Kald:  [y, u_y] = Ophobningsloven_m(f, vars_and_u)
%
% input:
%   f = symbolsk version af funktionen
%   vars_and_u = 2d array med symboler, måleværdier og usikkerheder 
%   
%   eksempel:
%   syms A k T Delta_x
%   f = k * A * T / Delta_x;
%   vars_and_u = [[A, A_val, u_A];
%                 [k, k_val, u_k];
%                 [T, T_val, u_T_2];
%                 [Delta_x, Delta_x_val, u_Delta_x]];
%
% output:
%   en string med funktions værdien +- usikkerheden
%   y = værdien af funktionen (double)
%   u_y = usikkerheden på funktionsværdien (double)

bidrag_sum = 0;
n = size(vars_and_u,1);

for i = 1:n
    f_new = f;

    for j = 1:n
        if i ~= j
            f_sub = subs(f_new, vars_and_u(j,1), vars_and_u(j,2));
            f_new = f_sub;
        end
    end

    diff_f = diff(f_new, vars_and_u(i,1));
    bidrag = (subs(diff_f, vars_and_u(i,1), vars_and_u(i,2)) * vars_and_u(i,3))^2;
    bidrag_sum = bidrag + bidrag_sum;
end

u_y = double(sqrt(bidrag_sum));
y = double(subs(f, vars_and_u(:,1), vars_and_u(:,2)));

pmchar=char(177);
fprintf(['%.8f' pmchar '%.8f'],y, u_y)
end