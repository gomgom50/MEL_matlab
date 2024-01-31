kommpot = xlsread("Data, pladser og personer.xlsx", "11 pladser-personer", "B14:L24");

pprv = xlsread("Data, pladser og personer.xlsx", "11 pladser-personer", "B29:L39");
[OptPl, OptMV] = OptPlacMaxMV(pprv, kommpot);