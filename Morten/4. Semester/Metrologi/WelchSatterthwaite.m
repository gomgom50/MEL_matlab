function Veff = WelchSatterthwaite(U, u, ns)
% U er den propagerede usikkerhed
% u er den enkelte målings usikkerhed
% ns er antal målinger for de individuelle usikkerheder


for i = 1:length(u)
   WS(i) = u(i)^4/(ns(i)-1);
end

Veff = U^4/sum(WS);




end