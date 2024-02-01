function replacedEqn = replaceWithDotNotation_sym(eqn_sym)
    % REPLACEWITHDOTNOTATION_SYM Converts the time derivatives in a symbolic equation to dot notation.
    %
    % This function takes a symbolic equation and replaces all the time derivatives of the 
    % format 'diff(variable(t), t)' and 'diff(variable(t), t, t)' with 'variable_dot' and 'variable_ddot'
    % respectively. This helps in simplifying the symbolic equation and makes it easier to read 
    % and understand.
    %
    % Inputs:
    % - eqn_sym : A symbolic equation containing time derivatives.
    %
    % Outputs:
    % - replacedEqn : The input symbolic equation with time derivatives replaced by dot notation.
    %
    % Example:
    %    syms x(t)
    %    eqn = diff(x(t),t) == diff(x(t), t, t) + 5;
    %    new_eqn = replaceWithDotNotation_sym(eqn);
    %
    %    Now, new_eqn is 'x_dot == x_ddot + 5'
    %
    % Note:
    % This function assumes that the input equation is already in symbolic form and the time 
    % variable used is 't'.
    eqn = char(eqn_sym);

    % Use regex to find patterns of 'diff(variable(t), t)'
    pattern = 'diff\((\w+)\(t\), t\)';
    matches = regexp(eqn, pattern, 'tokens');

    % Use regex to find patterns of 'diff(variable(t), t, 2)'
    pattern_2nd_order = 'diff\((\w+)\(t\), t, t\)';
    matches_2nd_order = regexp(eqn, pattern_2nd_order, 'tokens');

    % If there were any 2nd order matches
    if ~isempty(matches_2nd_order)
        % Iterate through each match and replace 'diff(variable(t), t, 2)' with 'variable_ddot'
        for i = 1:length(matches_2nd_order)
            oldStr = ['diff(', matches_2nd_order{i}{1}, '(t), t, t)'];
            newStr = [matches_2nd_order{i}{1}, '_ddot'];
            eqn = strrep(eqn, oldStr, newStr);
        end
    end

    % If there were any 1st order matches
    if ~isempty(matches)
        % Iterate through each match and replace 'diff(variable(t), t)' with 'variable_dot'
        for i = 1:length(matches)
            oldStr = ['diff(', matches{i}{1}, '(t), t)'];
            newStr = [matches{i}{1}, '_dot'];
            eqn = strrep(eqn, oldStr, newStr);
        end
    end

    % Convert the string back to a symbolic equation
    replacedEqn = str2sym(eqn);
end