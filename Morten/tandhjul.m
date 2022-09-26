classdef tandhjul
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
    end

    methods (Static)
        function dcd = delecirkeldiameter(N, mn, phi)
            
            if isempty(phi)
                d1 = N(1) * mn
                d2 = N(2) * mn
                fprintf("sd")
                C = (d1 + d2)/2
            elseif ~isempty(phi)
                d1 = N(1) * mn
                d2 = N(2) * mn
                
                dg1 = d1 * cosd(phi)
                dg2 = d2 * cosd(phi)
            end            
        end

    end
end