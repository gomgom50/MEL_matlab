clear
z = @(x,y) 12.0 + 313*y - 1466*y^2 + 7.69*x - 126*x.*y ...
           + 878*x.*y^2 - 2.42*x^2 + 34.1*x^2.*y - 213*x^2.*y^2;
x = 1:0.01:4;
y = 0.03:0.001:0.23;
zmax = 100;
for i = 1:4
  for j = 3:23
    zny = z(x(i),y(j));
    if zny < zmax
      xmaxz = x;   % "Notér" aktuel x-værdi i xmaxz
      ymaxz = y;   % "Notér" aktuel y-værdi i ymaxz
      zmax = zny;  % "Notér" aktuel z-værdi i zmax
    end
  end
end
xmaxz, ymaxz, zmax  % Skriv funden løsning