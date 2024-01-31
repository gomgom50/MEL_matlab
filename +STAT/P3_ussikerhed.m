function [korttids,stabilitet] = P3_ussikerhed(data, t)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%--------------------------------%
%---------- modeller ------------%
%--------------------------------%

mdl_5C_1 = fitlm(t,data)
mdl_5C_1.Coefficients.Estimate(1);
mdl_5C_1.Coefficients.Estimate(2);


%--------------------------------%
%-------- korttidsdrift ---------%
%--------------------------------%

syms x y
f(x) = mdl_5C_1.Coefficients.Estimate(1) + x * mdl_5C_1.Coefficients.Estimate(2);


%--------------------------------%
%---------- stabilitet ----------%
%--------------------------------%

stab_5C_1_affektor = vpa(data - f(t'), 10);
stab_5C_1 = data + stab_5C_1_affektor;
stab_5C_1 = double(stab_5C_1);

korttids = mdl_5C_1.Coefficients.Estimate(2);
stabilitet = std(stab_5C_1);

end