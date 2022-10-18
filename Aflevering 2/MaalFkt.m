function MV = MaalFkt(Pl,Tr,Dst)
N = length(Tr)


MV = 0

for i = 1:3
    calc = dot(Dst(:,i), Tr(:,Pl(i)))
    MV =+ MV + calc 
end



% MV_test2 = Dst .* Tr