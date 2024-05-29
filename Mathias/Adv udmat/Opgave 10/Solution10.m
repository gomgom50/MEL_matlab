% Advanced Metal Fatigue: Solution for exercise 10
clc; clear all; close all

% crack length, initial and final
ai = 5; %mm
af = 10;

% applied stress range (nominal / far field)
dS = 100000/(10*100); % MPa

% material data from IIW
A  = 5.21e-13; % works with MPa*sqrt(mm)
n  = 3.0;

% starting conditions
N  = 0;
a  = ai;

dN = 10; % cycle increments

while a<af
    
    % calculate dK at current crack length
    dK = calc_dK(a,dS);
    
    % crack length increament at current dK
    da = dN * A*dK^n; 
    
    % sum values
    a = a + da;
    N = N + dN;

end

fprintf('Estimated life N_est = %i cycles\n',N)
fprintf('Experimental life (Ps=97.7)) N_exp =~300,000 cycles\n')


function K = calc_dK(a,S)
% calculates the stress intensity factor for crack length 'a'
% and applied (nominal/far field) stress S. If stress range is 
% used as input, output will be SIF-range, dS -> dK.
%
% units  [mm] and [MPa]

    t = 10;
    H = sqrt(2)*5;
    w = H + t/2;
    x = H/t;

    A1 = 0.528 + 3.287*x - 4.361*x^2 + 3.696*x^3 - 1.875*x^4 + 0.415*x^5;
    A2 = 0.218 + 2.717*x -10.171*x^2 +13.122*x^3 - 7.755*x^4 + 1.783*x^5;

    K = (S*(A1+A2*a/w)*(pi*a*sec(pi*a/(2*w)))^(1/2))/(1+2*H/t);
    
end
