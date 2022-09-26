function i = iomr(x,y)
if x < 2
  i = 'nej';
elseif (-x/2 + 4 <= y || y <= x/2 + 4) && (x <= 4 && x >= 2)
  i = 'ja';
elseif (y >= 2 || y <= -x^2 + 8*x - 10) && (x >= 4 && x <= 6)
  i = 'ja';
else
  i = 'nej';
end