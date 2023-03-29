function output = OhmsLawCals(p, i, v, r)
% Funktion til beregning af alle ohm lov relationer

x = 0;

% Power - watts
while x < 2
    x = x+1;
if isempty(p) && ~isempty(v) && ~isempty(i)
    p = v.*i;
elseif isempty(p) && ~isempty(r) && ~isempty(i)
    p = i.^2 .* r;
elseif isempty(p) && ~isempty(r) && ~isempty(v)
    p = v.^2./r;
elseif ~isempty(p)
    p = p;
end

% I - current
if isempty(i) && ~isempty(v) && ~isempty(r)
    i = v./r;
elseif isempty(i) && ~isempty(p) && ~isempty(v)
    i = p./v;
elseif isempty(i) && ~isempty(r) && ~isempty(p)
    i = sqrt(p./r);
elseif ~isempty(i)
    i = i;
end

% R - resistance
if isempty(r) && ~isempty(v) && ~isempty(i)
    r = v./i;
elseif isempty(r) && ~isempty(p) && ~isempty(v)
    r = v.^2./p;
elseif isempty(r) && ~isempty(i) && ~isempty(p)
    r = p./i.^2;
elseif ~isempty(r)
    r = r;
end

% V - Voltage
if isempty(v) && ~isempty(i) && ~isempty(r)
    v = i.*r;
elseif isempty(v) && ~isempty(p) && ~isempty(i)
    v = p./i;
elseif isempty(v) && ~isempty(r) && ~isempty(p)
    v = sqrt(p.*r);
elseif ~isempty(v)
    v = v;
end

end

% if type == "parallel"
%     P = antal * p
%     V = i.*antal.*r
%     P_ledning = (antal.*i).^2.*r
% elseif type == "serie"
%     "noget"
% end

f1 = 'P';
f2 = 'I';
f3 = 'V';
f4 = 'R';

output = struct(f1,p,f2,i,f3,v,f4,r);


end