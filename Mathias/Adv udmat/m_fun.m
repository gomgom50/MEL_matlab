function m = m_fun(sigma,N)
% m: linear regression to find stress slope
%   m = m_fun(sigma,N):
%   uses a linear regreassion to calculated the downward slope of
%   the stresses towards the knee (N_D)
% input:
%   sigma = a vector of the stresses
%   N = fatigue lifetime total
% output:
%   m = downward slope of the stresses
if nargin<2, error('at least 2 input arguments required'), end

n = length(N);

m = -( sum(log10(sigma) .* log10(N)) - 1/n * sum(log10(sigma)) .* sum(log10(N)) )/...
    (sum(log10(sigma).^2) - 1/n * sum(log10(sigma))^2);