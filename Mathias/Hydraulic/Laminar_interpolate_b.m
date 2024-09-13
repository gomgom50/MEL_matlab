function b = Laminar_interpolate_b(Re_input)
    % Data from the table
    Re_values = [2300, 2000, 1500, 1000, 750, 500, 250, 100, 50, 25, 10];
    b_values = [1, 1.05, 1.15, 1.25, 1.4, 1.5, 3, 7.5, 15, 30, 70];
    
    % Interpolation for the given Re_input
    b = interp1(Re_values, b_values, Re_input, 'linear', 'extrap');
end
