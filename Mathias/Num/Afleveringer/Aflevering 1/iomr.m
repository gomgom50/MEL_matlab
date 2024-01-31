function i = iomr(x,y)
% iomr - Bestemmelse om punktet er i vores område
% Kald: i = iomr(x,y)
% Input:
% x = x-koordinat
% y = y-koordinat
% Output:
% i = 'ja' hvis punktet er i vores område
% i = 'nej' hvis punktet er uden for området


if x < 2
i = 'nej';
elseif (-x/2+4 <= y && y <= x/2+4) && (2 <= x && x < 4)
    i = 'ja';
elseif (2 <= y && y <= -x^2 +8*x - 10) && (4 <= x && x <= 6)
    i = 'ja';
else
    i = 'nej';
end


% if x < 2
% i = 'nej';
% elseif (-x/2+4 <= y || y <= x/2+4) && (2 <= x && x < 4)
%     i = 'ja';
% elseif (2 <= y || y <= -x^2 +8*x - 10) && (4 <= x && x <= 6)
%     i = 'ja';
% else
%     i = 'nej';
% end