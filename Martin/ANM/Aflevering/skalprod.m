function sp = skalprod(a,b)
m = length(a);
n = length(b);
if m ~= n, error('Vektorerne skal v�re af samme st�rrelse');
end
sp = 0;
for i = 1:n
    sp = sp + a(i) .* b(i);
end
end