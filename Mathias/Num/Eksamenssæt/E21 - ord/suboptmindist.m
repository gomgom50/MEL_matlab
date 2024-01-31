function [m,d] = suboptmindist(m0,r)
m = m0;
n = length(m);
d = massemidtdist(m,r); % Kald funktion fra delopg. (a)
while 1
  dmin = d; % Gem mindste afstand fundet indtil videre
  for i = 1:n-1
    for j = i+1:n
      mtest = m;
      mtest(i) = m(j); %i rettes til j
      mtest(j) = m(i); %j rettes til i
      dtest = massemidtdist(mtest,r); % Kald funktion fra delopg. (a) 
      % m rettes til mtest
      if dtest < d
        m = mtest;
        d = dtest;
      end
    end
  end
  if d == dmin
    break
  end
end