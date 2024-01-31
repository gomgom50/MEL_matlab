function afstand = ruteafstand(bynr)
% ruteafstand - afstand imellem byer
% Kald: afstand = ruteafstand(bynr)
% Input:
% bynr = By nr under byen du starter i samt by nr på byerne
% du vil igennem i rækkefølge.
% Output:
% afstand = afstanden der skal rejses på ruten
atbl = [ 0 307 168 417 298 336 232 266 237 35
307 0 145 119 165 39 99 52 72 273
168 145 0 255 136 174 70 105 75 134
417 119 255 0 274 80 208 161 181 382
298 165 136 274 0 195 72 125 96 264
336 39 174 80 195 0 129 81 102 302
232 99 70 208 72 129 0 59 29 197
266 52 105 161 125 81 59 0 29 230
237 72 75 181 96 102 29 29 0 206
35 273 134 382 264 302 197 230 206 0];

n = length(bynr);
afstand = 0;
for i = 1:n-1
    afstand = afstand + atbl(bynr(i),bynr(i+1));
end