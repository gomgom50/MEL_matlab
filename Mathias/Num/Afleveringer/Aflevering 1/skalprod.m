function sp = skalprod(a,b)
% skalprod - skalar produktet af 2 vektorer
% Kald: sp = skalprod(a,b)
% Input:
% a = Første vektor
% b = Anden vektor
% Output:
% sp = skalar, prik eller indre produktet af de to vektorer 
m = length(a); n = length(b);
if m ~= n, error('Vektorerne skal være af samme størrelse'); end
    sp = 0;
for i = 1:n
    sp = sp + a(i) * b(i);
end