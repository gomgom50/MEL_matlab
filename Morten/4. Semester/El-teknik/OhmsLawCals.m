function output = OhmsLawCals(p, i, v, r, UNITS)
% Funktion til beregning af alle ohm lov relationer
% UNITS "ja" eller "nej"

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

if UNITS == "ja"
p = vpa(unitConvert(p,"SI","Derived"), 6);
v = vpa(unitConvert(v,"SI","Derived"), 6);
i = vpa(unitConvert(i,"SI","Derived"), 6);
r = vpa(unitConvert(r,"SI","Derived"), 6);
else
p = vpa(p, 6);
v = vpa(v,6);
i = vpa(i, 6);
r = vpa(r, 6);
end

f1 = 'P';
f2 = 'I';
f3 = 'V';
f4 = 'R';

output = struct(f1,p,f2,i,f3,v,f4,r);


end