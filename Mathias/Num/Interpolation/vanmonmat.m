function A = vanmonmat(x)
% vanmonint: build Vandermonde coefficent matrix
% A = vanmonint(x): build Vandermonde coefficient matrix A
% from given x vector.
% Input:
% x = vector containing n x-values
% Output
% A = Vandermonde coefficient matrix
n = length(x);
A = zeros(n,n)
for i = 1:n
 for j = 1:n
 A(i,j) = x(i).^(n-j);
 end
end
A
end