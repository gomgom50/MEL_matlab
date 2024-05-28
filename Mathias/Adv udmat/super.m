function res = super(C, N, S, m, SF)
% super: Euler ODE solver
%   res = super(C, N, S, m, SF) or super(C, N, S, m)
%           Finder C, N eller S alt efter input
%           Indsæt den variable der skal findes som fx sym('N')
%           Bruges til at finde SN kurve parametre
% input:
%   C = hældnings coefficenten på SN kurven
%   N = antal cycles
%   S = Stress at cycles % unit depends on SN curve
%   m = exponenten typisk 5 eller 3
%   SF = safty factor for stress default 1 (Use only to correct curve 
%   first time, since it is included in the following)
%   
% output:
%   res = den varaible der ikke er indsat af C, N, S

if nargin<3,error('at least 3 input arguments required'),end

if nargin < 5
   SF = 1;
end

if isa(C, 'sym')
    res = N * (S/SF)^m;
elseif isa(N, 'sym')
    res_eq = C == N * (S/SF)^m;
    res = solve(res_eq, N,'Real',true);
elseif isa(S, 'sym')
    res_eq = C == N * (S/SF)^m;
    res = solve(res_eq, S,'Real',true);
else
    error("One of the inputs (C, N, S) must be a symbolic variable");
end
res = double(res);


