function [m,d] = suboptmindist(m0,r)
m = m0;
n = length(m);
d = massemidtdist(m,r); % Kald funktion fra delopg. (a)
while 1
  dmin = d; % Gem mindste afstand fundet indtil videre
  for i = 1:n-1
    for j = i+1:n
      mtest = m;
      mtest(i) = m(i);
      mtest(j) = m(j);
      dtest = massemidtdist(m,r); % Kald funktion fra delopg. (a)
      if dtest > d
        mtest = m;
        dtest = d;
      end
    end
  end
  if d == dmin
    break
  end
end