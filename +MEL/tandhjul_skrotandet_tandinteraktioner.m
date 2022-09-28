classdef tandhjul_skrotandet_tandinteraktioner
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods (Static)
        function svar = indgrebsgrad_mF_ud_fra_tandbredde(mF, F, psi, mn)
           
            % Der kan udregnes for hvilken som helst ubekendt
            % mF == F_sin(psi)/(pi*mn)
            % F = Tandbredde
            % psi = skråvinklen
            % mn = modul

            if isempty(mF)
                syms mF;
                disp("Udregner mF ud fra:")
                displayFormula("mF == F_sin(psi)/(pi*mn)")
                
                eq = mF == F*sind(psi)/(pi *mn);
                svar = solve(eq, mF);

            elseif isempty(F)
                syms F;
                disp("Udregner F ud fra:")
                displayFormula("mF == F_sin(psi)/(pi*mn)")

                eq = mF == F*sind(psi)/(pi *mn);
                svar = solve(eq, F);

            elseif isempty(psi)
                syms psi;
                disp("Udregner psi ud fra:")
                displayFormula("mF == F_sin(psi)/(pi*mn)")
                
                eq = mF == F*sind(psi)/(pi *mn);
                svar = solve(eq, psi);
            
            elseif isempty(mn)
                syms mn;
                disp("Udregner mn ud fra:")
                displayFormula("mF == F_sin(psi)/(pi*mn)")
                
                eq = mF == F*sind(psi)/(pi *mn);
                svar = solve(eq, mn);

            end
        end

    end
end

