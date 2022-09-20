classdef trail
    %Trail Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Property1
    end

    methods (Static)
        function Vol = Volumen(x,y) 
    if y < 0
        Vol = 0;
    elseif y < x
        Vol  = pi.*{x.^2}.*y;
    elseif y > x
        Vol = (pi.*{x.^2}.*x./3) + ((pi.*{x.^2}.*y)-pi.*(x.^2).*x);
    elseif y > 3*x
        Vol = pi.*(x.^2).*2.*pi.*(x.^2).*y;
    end
        end
    end
end