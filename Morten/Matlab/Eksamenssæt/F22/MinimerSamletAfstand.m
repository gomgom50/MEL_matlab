AfstandeTeknikereKunder;        % Definér afstandsmatricen afstande
n = length(afstande);
tildelingsmuligh = perms(1:n);  % Generér alle tildelingsmuligheder
N = factorial(n);               % Antal tildelingsmuligheder = n!
minsamletafstand = +inf;        % Initialværdi
for i = 1:N
  kundetildelt = tildelingsmuligh(i,:);
  samletafstand = samletafst(kundetildelt,afstande);
  if samletafstand < minsamletafstand
    optkundetildelt = kundetildelt;
    minsamletafstand = samletafstand;
  end
end
optkundetildelt                 % Vis indhold af optkundetildelt
minsamletafstand                % Vis værdi af minsamletafstand