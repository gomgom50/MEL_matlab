% Advanced Metal Fatigue: Solution for exercise 10
clear all; close all; clc

% crack length, initial and final
ai = 5;
af = 12;

% applied stress range (nominal / far field)
dS = 100000/(10*100); % MPa

% material data from IIW
A  = 5.21e-13;
n  = 3.0;

% starting conditions
N  = 0;
i  = 0;
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
    
    % store plot values
    i = i + 1;
    ap(i) = a;
    Np(i) = N;
        
end

fprintf('Cycles to failure Nf = %d \n',N)

figure
plot(Np,ap); hold on
ylabel('crack length, a [mm]')
xlabel('Fatigue life, N [cycles]')

figure
ap = linspace(5,10,100);
dK_ANSYS = 305; 
for i = 1:length(ap)
    dK(i) = calc_dK(ap(i),dS);
end
plot(ap,dK); hold on 
plot(ai,dK_ANSYS,'or')
legend('IIW','ANSYS')
xlabel('a');
ylabel('K')


function K = calc_dK(a,S)
% calculates the stress intensity factor for crack length 'a'
% and applied (nominal/far field) stress S. If stress range is 
% used as input, output will be SIF-range, dS -> dK.
%
% IIW version (from the slides)

    t = 10;
    H = sqrt(2)*5;
    w = H + t/2;
    x = H/t;

    A1 = 0.528 + 3.287*x - 4.361*x^2 + 3.696*x^3 - 1.875*x^4 + 0.415*x^5;
    A2 = 0.218 + 2.717*x -10.171*x^2 +13.122*x^3 - 7.755*x^4 + 1.783*x^5;

    K = (S*(A1+A2*a/w)*(pi*a*sec(pi*a/(2*w)))^(1/2))/(1+2*H/t);

end

