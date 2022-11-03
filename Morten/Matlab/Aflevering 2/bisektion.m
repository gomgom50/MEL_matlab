f = @(T) 0.0002374*T^3 - 0.05304*T^2 + 4.591*T + 1450.59 - <UDFYLD>;
Tl = 10;      % Nedre intervalendepunkt (grader C)
Tu = 15;      % �vre intervalendepunkt (grader C)
es = 0.01;    % �nsket n�jagtighed af rod (%)
maksit = 20;  % Maksimal antal iterationer
it = 0;       % Startv�rdi for iterationst�lleren it
while 1
  Tr = (<UDFYLD>)/2;
  ea = abs(Tr-Tl)/Tr*100;
  it = it + <UDFYLD>;
  if f(Tl)*f(Tr) > 0
    <UDFYLD> = Tr;
  elseif f(Tl)*f(Tr) < 0
    <UDFYLD> = Tr;
  else
    ea = 0;
  end
  if <UDFYLD> <= es || it >= <UDFYLD>, break, end
end
T1500 = Tr
ea
it