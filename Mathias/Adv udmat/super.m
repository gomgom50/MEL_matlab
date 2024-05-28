function res = super(C, N, S, m)
% super: Euler ODE solver
%   res = super(C, N, S, m)
%           Finder C, N eller S alt efter input
%           Bruges til at finde SN kurve parametre
% input:
%   C = hældnings coefficenten på SN kurven
%   N = antal cycles
%   S = Stress at cycles % unit depends on SN curve
%   m = exponenten typisk 5 eller 3
% output:
%   res = den varaible der ikke er indsat af C, N, S
if nargin<3,error('at least 3 input arguments required'),end

% sym_check = [class(C), class(N), class(S), class(m)];
% [GC,GR] = groupcounts(sym_check);

% if length(GR) > 3
%     error('Only one variable can be solved');
% end

if isa(C, 'sym')
    res = N * S^m;
elseif isa(N, 'sym')
    res_eq = C == N * S^m;
    res = solve(res_eq, N,'Real',true);
elseif isa(S, 'sym')
    res_eq = C == N * S^m;
    res = solve(res_eq, S,'Real',true);
else
    error("One of the inputs (C, N, S) must be a symbolic variable");
end
res = double(res)


