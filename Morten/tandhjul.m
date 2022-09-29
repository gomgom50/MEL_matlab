classdef tandhjul
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
    end

    methods (Static)
        function dcd = delecirkeldiameter(N, mn, phi)
            
            if isempty(phi) && length(N)==2
                d1 = N(1) * mn
                d2 = N(2) * mn
                
            elseif ~isempty(phi) && length(N)==2
                d1 = N(1) * mn
                d2 = N(2) * mn
                
                dg1 = d1 * cosd(phi)
                dg2 = d2 * cosd(phi)
            end
        end

        function caa = center_akse_afstand(d1, d2, C)
            
            if ~isempty(d1) && ~isempty(d2) && isempty(C)
            C = (d1 + d2)/2
            disp("Udregner centerakseafstanden")
            return
            
            elseif isempty(d1)
                syms d1
                d1 = solve((d1 + d2)/2)
                disp("Udregner d1 ud fra d2 og C")
                return
            end
        end

    end
end