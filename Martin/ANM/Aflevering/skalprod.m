function sp = skalprod(a,b)
m = length(a);
n = length(b);
if m ~= n, error('Vektorerne skal være af samme størrelse');
end
sp = 0;
for i = 1:n
    sp = sp + a(i) .* b(i);
end
end