classdef Inertimoment
    %INERTIMOMENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods (Static)

        function un = udregn_n_start(gear, lejetab, tandgrebtab)
            if gear == 1
                un = lejetab^2;
            else
                un = (lejetab^(2*gear)) * tandgrebtab^(gear - 1);
            end

        end

        function I_t = Inertimoment_start(Gearmegnde, n_array, Inerti_Array,w_array,w_observationsnr)
            displayFormula("temp = inerti*1/n*(w2/w1)^2")
            temp2 = 0
            for n = 1:1:Gearmegnde
            temp = Inerti_Array{n}*1/n_array{n}*(w_array{n}/w_array{w_observationsnr})^2
            temp2 = temp2 + temp
            end
            I_t = temp2
        end

        function un = udregn_n_stop(gear, lejetab, tandgrebtab)
            if gear == 1
                un = lejetab^2;
                disp("to lejer")
            else
                un = (lejetab^(2*gear)) * tandgrebtab^(gear - 1);
                disp("Flere lejer")
            end

        end

        function I_t = Inertimoment_stop(Gearmegnde, n_array, Inerti_Array,w_array, w_observationsnr)
            displayFormula("temp = inerti*1/n*(w2/w1)^2")
            temp2 = 0
            x = 1
            for n = Gearmegnde:-1:1
            temp = Inerti_Array{x}*n_array{x}*(w_array{x}/w_array{w_observationsnr})^2
            temp2 = temp2 + temp
            x = x + 1
            end
            I_t = temp2
        end
       
    end

end

