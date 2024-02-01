clear, format long
f = @(x) x^3 - x^2 - 12*x + 2*log(x^2+2);
es = 0.01;
xl = -6; xu = -1;
while 1
  xr = (xl+xu)/2;
  Ea = (xu-xl)/2;
  ea = abs(Ea/xr*100);
  if (f(xl)<0 && <UDFYLD>) || (<UDFYLD> && <UDFYLD>)
    xl = xr;
  elseif (f(xu)<0 && f(xr)<0) || (<UDFYLD> && <UDFYLD>)
    xu = <UDFYLD>;
  end
  if ea <= es, break, end
end
xr, ea % Vis fundne rod og approks. procentisk fejl