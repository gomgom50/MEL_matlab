function [root,ea,iter]=newtraph(func,dfunc,xr,es,maxit) 
% newtraph: Newton-Raphson root location zeroes 
%   [root,ea,iter]=newtraph(func,dfunc,xr,es,maxit): 
%   uses Newton-Raphson method to find the root of func 
% input: 
%   func = name of function 
%   dfunc = name of derivative of function 
%   xr = initial guess 
%   es = desired relative error (default = 0.0001%) 
%   maxit = maximum allowable iterations (default = 50) 
% output: 
%   root = real root 
%   ea = approximate relative error (%) 
%   iter = number of iterations 

if nargin<3 %Hvis der er mindre end 3 input gives der en advarsel
    error('at least 3 input arguments required')
end 

if nargin<4||isempty(es) %sætter default value hvis ikke intastes
    es=0.0001; 
end 

if nargin<5||isempty(maxit) %sætter default value hvis ikke intastes
    maxit=50; 
end 

iter = 0; %antal iteration starter på 0
%laver tomme arrays til tabel udskrift
Resultat = [];
Ligning = [];
Error = [];

while 1  %starter while loop
  xrold = xr; %gemmer den gamle xr værdi
  xr = xr - func(xr)/dfunc(xr); %udregner roden.

  syms T %sætter T som et symbol til visning af ligningen
  f_show = xr - func(T)/dfunc(T); %ligningen der bruges
  iter = iter + 1; % antal gange der er kørt igennem
  
  Resultat(end+1) = xr; %tilføjer roden til resultat listen
  Ligning(end+1) = iter; %tilføjer ligningen til lignings listen
  
  if xr ~= 0 %Hvis xr ikke er 0 sættes en ny error
      ea = abs((xr - xrold)/xr) * 100; 
  end 
  Error(end+1) = ea;  %tilføjer error til resultat error listen

  %while loopet stoppes hvis vi når inden for vores satte stat error eller
  %vi når det maximale antal iterrationer
  if ea <= es || iter >= maxit
      break
  end 
end
%Slut værdierne udprintes
root = xr
ea
iter

%Der laves en tabel med alle værdierne der er opnået
tabel = table(Resultat', Ligning', Error',...
    VariableNames={'Resultat(xr)','Ligning', 'Error(ea)'})
end
