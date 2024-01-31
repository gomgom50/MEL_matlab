clear
a = 0; b = 4; h = 0.4;
t = a:h:b;
y(1) = <UDFYLD>;
for i = 1:<UDFYLD>
  dydt = <UDFYLD>;
  y(i+1) = <UDFYLD>;
end
disp([t' y'])