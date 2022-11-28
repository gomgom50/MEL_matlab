function ans = SimpleAutoSolve(eq)
%  SIMPLEAUTOSOLVE Solver automatisk for den variable som er en symbolks
%  variabel
% 
% Detailed explanation of this function.
    %Input ens equation, den værdig som er en sym værdig bliver løst for.
    ans = solve(eq, symvar(eq))
    fprintf("Solving for %s returns a value of %f", symvar(eq), ans)
end