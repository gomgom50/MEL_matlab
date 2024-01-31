classdef Generelt
    %GENERELT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static)
        function Output = Numerisk_Skerings_Punkter(eq, startrange, incriment, endrange, plot_JaNej)
        A(1) = 0
        syms x
	        for x0 = startrange:incriment:endrange
	            xs = vpasolve(eq,x,[x0 x0+incriment]);
	            if ~isempty(xs)
		            Output = xs
                    if A(end) == 0
                        A(end) = xs
                    else
                        A(end + 1) = xs
                    end
                    
            end
        end
        if plot_JaNej == true
            hold off
            left = lhs(eq);
            right = rhs(eq);
            xrange = linspace(startrange-10, endrange+10, 10*endrange)
            plot(xrange,left(xrange))
            hold on
            plot(xrange, right(xrange))
            disp("plot")
            plot(A, left(A), "ro")
            hold on
        end
        end
    end
end

