X = [2; 1; 1]
for i = 1:<UDFYLD>
  f = [2*(X(1)+3*X(2))^2*X(3)^2 - 18
       <UDFYLD>
       X(1) + 3*X(2) - 2*X(3) + 1];
  J = [4*(X(1)+3*X(2))*X(3)^2, 12*(X(1)+3*X(2))*X(3)^2, <UDFYLD>
       4*X(2)+2,               <UDFYLD>,                -12*X(3)^2
       <UDFYLD>,               3,                       -2];
  X = X - <UDFYLD>
end