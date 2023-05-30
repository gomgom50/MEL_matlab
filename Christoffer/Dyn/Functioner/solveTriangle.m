function triangle = solveTriangle(pyCommand)
    % This MATLAB function wraps the execution of Python code which solves a triangle problem.
    % 
    % Inputs:
    % pyCommand - A string containing the Python command to be executed. The command should be written for 
    % the trianglesolver's solve function and should include values for two
    % or three sides, two angles and so on. *degree has to be used when in
    % degrees, otherwise use radians. 
    % Example: 'a=0.3, c=0.2, B=120*degree'
    % 
    % Outputs:
    % triangle - A struct that contains six fields (a, b, c, A, B, C) representing the sides and angles
    % of the triangle. 

    % Call the Python interpreter using pyrun
    pyCommandFull = ["from trianglesolver import solve, degree", sprintf("a, b, c, A, B, C = solve(%s)", pyCommand), "list = [a, b, c, A, B, C]"];
    list = pyrun(pyCommandFull, "list");
    
    % Convert the output into double format
    list = double(list);
    
    % Create a struct to hold the output
    triangle = struct('a', list(1), 'b', list(2), 'c', list(3), ...
                      'A', list(4), 'B', list(5), 'C', list(6));
    
end
