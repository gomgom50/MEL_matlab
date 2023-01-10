clear
TransporterOgAfstande;       % Opret matricer Tr og Dst
MuligePl = perms(<UDFYLD>);  % Generér alle placeringsmuligheder
AntalPlIalt = <UDFYLD>;      % Antal placeringmuligheder i alt
MinTotDst = <UDFYLD>;
for i = <UDFYLD>
  Pl = MuligePl(i,:);
  TD = TotDst(Pl,Tr,Dst);    % Kald af funktionen TotDst fra delopgave (a)
  if <UDFYLD> < <UDFYLD>
    PlMinTotDst = Pl;
    MinTotDst = TD;
  end
end
PlMinTotDst % Vis plac. svarende t. minimum samlet tilbagel. transportafst.
MinTotDst   % Vis minimum samlet tilbagelagt transportafstand