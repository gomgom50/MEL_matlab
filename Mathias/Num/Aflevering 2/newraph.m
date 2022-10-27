function [root,ea,iter]=newtraph(func,xr,es,maxit) 
% newtraph: Newton-Raphson root location zeroes 
%   [root,ea,iter]=newtraph(func,xr,es,maxit): 
%   uses Newton-Raphson method to find the root of func 
% input: 
%   func = name of function symbolic
%   xr = initial guess 
%   es = desired relative error (default = 0.0001%) 
%   maxit = maximum allowable iterations (default = 50) 
% output: 
%   root = real root 
%   ea = approximate relative error (%) 
%   iter = number of iterations 

if nargin<2 %Hvis der er mindre end 2 input gives der en advarsel
    error('at least 2 input arguments required')
end 

if nargin<3||isempty(es) %sætter default value hvis ikke intastes
    es=0.0001; 
end 

if nargin<4||isempty(maxit) %sætter default value hvis ikke intastes
    maxit=50; 
end 

iter = 0; %antal iteration starter på 0
%laver tomme arrays til tabel udskrift
Resultat = [];
f_list = [];
df_list = [];
Error = [];

%differentier funktionen symbolsk og laver den numerisk igen
f = matlabFunction(func);
df = matlabFunction(diff(func)); 

while 1  %starter while loop
  xrold = xr; %gemmer den gamle xr værdi
  xr = xr - f(xr)/df(xr); %udregner roden.

%   syms T %sætter T som et symbol til visning af ligningen
%   f_show = xr - f(T)/df(T) %ligningen der bruges
  iter = iter + 1; % antal gange der er kørt igennem
  
  Resultat(end+1) = xr; %tilføjer roden til resultat listen
  f_list(end+1) = f(xrold); %tilføjer ligningen til lignings listen
  df_list(end+1) = df(xrold);

  if xr ~= 0 %Hvis xr ikke er 0 sættes en ny error således undgår vi at 
      % dividere med 0
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
tabel = table(Resultat', f_list', df_list', Error',...
    VariableNames={'Rod(xr)','f(xr)', 'df/dT (xr)', ...
    'Error(ea)'})
end
