f = @(T) 0.0002374*T^3 - 0.05304*T^2 + 4.591*T + 1450.59 - 1500;
Tl = 10; % Nedre intervalendepunkt (grader C)
Tu = 15; % Øvre intervalendepunkt (grader C)
es = 0.01; % Ønsket nøjagtighed af rod (%)
maksit = 20; % Maksimal antal iterationer
it = 0; % Startværdi for iterationstælleren it
while 1
    Tr = (Tl + Tu)/2; %T værdien i roden
    ea = abs(Tr - Tl)/Tr*100; %usikkerheden
    it = it + 1; %antal iterationer
    if f(Tl)*f(Tr) < 0 
        Tu = Tr; %Der sættes nyt upper limit
    elseif f(Tl)*f(Tr) > 0
        Tl = Tr; %Der sættes nyt lower limit
    else
        ea = 0; %usikkerheden er 0 da vi har ramt rigtigt
    end
    %Forloopet brydes hvis vi når et maksimalt antal forsøg eller vi kommer
    %indenfor usikkerheden.
    if ea <= es || it >= maksit
        break
    end
end
T1500 = Tr % Temperaturen printes
ea % Usikkerheden printes
it % Antal interationer der er gennemgået 