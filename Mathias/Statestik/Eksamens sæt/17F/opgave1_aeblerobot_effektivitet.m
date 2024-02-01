%% Opgave 1: Effektivitet af �bleplukningens delprocesser
clc; clear; close all; 

%% Basisoplysninger
Antal_Aebler = 975
Antal_Modne = 850
P_A = 0.90
P_B = 0.85
P_C = 0.92
P_D = 0.87


%% a
Antal_Genkendt = Antal_Modne*P_A 
Antal_Grebet = Antal_Genkendt*P_B
Antal_Plukket = Antal_Grebet*P_C
Antal_Pakket = Antal_Plukket*P_D

Effektivitet = Antal_Pakket/Antal_Modne
 

%% b 
% De modne �bler, der er tilbage p� tr�et efter plukningen, er dem, som 
% robotten ikke har genkendt, plus dem, den har genkendt, men ikke har 
% kunnet gribe. De �bler, som robotten har genkendt og grebet, men ikke har  
% kunnet plukke er faldet p� jorden, s� de sidder ikke tilbage p� tr�et

Antal_Ikke_Genkendt = Antal_Modne*(1 - P_A)
Antal_Ikke_Grebet = Antal_Genkendt*(1 - P_B)
Antal_Modne_Paa_Traeet = Antal_Ikke_Genkendt + Antal_Ikke_Grebet 

