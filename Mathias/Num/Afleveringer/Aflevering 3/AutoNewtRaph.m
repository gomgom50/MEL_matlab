% syms x y
% f1 = y + x^2 - x - 0.5
% f2 = y + 5*x*y - x^2
% 
% diff(f1, x)
% diff(f1, y)
% diff(f2, x)
% diff(f2, y)
% 
% x = [1.2;1.2];
% 
% for i = 1:5
%   f = [x(2) + x(1)^2 - x(1) - 0.5
%       x(2) + 5*x(1)*x(2) - x(1)^2];
% 
%   J = [2*x(1) - 1, 1
%        5*x(2) - 2*x(1),    5*x(1) + 1];
% 
%   x = x - inv(J)*f
% end


% syms x y z
% sym_list = [x y z];
% 
% f1 = x*y^2 - 4*y^2 + 3*x*z - 14;
% f2 = 3*x + 2*x*y*z - x^2*z + 33;
% f3 = 3*x - 2*y + 4*z - 21;
% 
% fs = [f1 f2 f3];
% J = [];
% help subs


% X = 1
% Y = 2
% Z = 3
% X = [1 2 3]
% 
% for i = 1:length(fs)
%     for j = 1:length(fs)
%         J_sym = diff(fs(i), sym_list(j))
%        
%         for k = 1:length(fs)
%            nummer = subs(J_sym, sym_list(j), X(k))
%         end
%         J(i,j) = nummer
%     end
% end
% J


syms x y z
sym_list = [x y z];

f1 = x*y^2 - 4*y^2 + 3*x*z - 14;
f2 = 3*x + 2*x*y*z - x^2*z + 33;
f3 = 3*x - 2*y + 4*z - 21;

fs = [f1 f2 f3];

x = [1 2 3]

% for i = 1:5
%   f = [x(2) + x(1)^2 - x(1) - 0.5
%       x(2) + 5*x(1)*x(2) - x(1)^2];
% 
%   J = [2*x(1) - 1, 1
%        5*x(2) - 2*x(1),    5*x(1) + 1];
% 
%   x = x - inv(J)*f
% end