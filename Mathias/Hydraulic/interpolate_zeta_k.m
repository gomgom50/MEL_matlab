function zeta_k = interpolate_zeta_k(D, d)
    % Calculate D/d
    Dd_ratio = D / d;
    
    % Manually extracted points from the graph (D/d, zeta_k)
    Dd_values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];  % Example values, adjust based on the graph
    zeta_k_values = [1.2, 0.55, 0.375, 0.3, 0.275, 0.25, 0.25, 0.26, 0.265, 0.3];  % Corresponding zeta_k values
    
    % Interpolation for the given D/d ratio
    zeta_k = interp1(Dd_values, zeta_k_values, Dd_ratio, 'linear', 'extrap');
end
