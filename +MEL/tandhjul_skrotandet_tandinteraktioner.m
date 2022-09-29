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


        function svar = ingrebsgraden_fuld_udledt (d_a1, d_a2, d_b1, d_b2, d_1, d_2, phi_t_deg, mt)
            % ingrebsgraden_fuld_udledt: Udregner ingrebsgraden fuld udledt: 
            % variabler
            % m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_t_deg))/(pi*mt*cosd(phi_t_deg))
            % Input:
            % d_a1 = Tandtopdiameter 1
            % d_a2 = Tandtopdiameter 2
            % d_b1 = Grundcirkeldiameter 1
            % d_b2 = Grundcirkeldiameter 2
            % d_1 = Delecirkeldiameter 1
            % d_2 = Delecirkeldiameter 2
            % phi_t_deg = angrebsvinkel i grader
            % m_t = transenstial modul 
            % Output:
            % m_c = ingrebsgraden skal være > 1.2 for tilstrækligt ingreb
            syms m_c %laver var1 til en symbolsk variabel. 
            disp("Udregner ingrebsgraden via givende værdiger.") %printer hvad vi gør
            eq = m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_t_deg))/(pi*mt*cosd(phi_t_deg)); %opskriv ligningen
            displayFormula("m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_t_deg))/(pi*mt*cosd(phi_t_deg))") %vis formlen
            svar = solve(eq, m_c); %solve for variablen
        end


        function svar = Mindste_andtal_tender (k, psi, m_G, phi_t)
            % Mindste_andtal_tender: Udregner mindste andtal tender for det
            % lille tandhjul. alle augmenter skal udfyldes 
            % variabler
            % N_P == (2*k*cos(psi))/((1+2*m_G)*sin(phi_t)^2) * (m_G + sqrt(m_G^2 + (1+2*m_G*sin(phi_t)^2)))
            % Input:
            % k = 1 for tender i fuld højde, 0.8 for afkortede tender. 
            % psi = skråvinklen
            % m_G = N_G/N_p >= 1, lig i ved opgearing lig 1/i ved
            % nedgearing
            % phi_t = angrebsvinklen trans 
            % Output:
            % N_P = Mindste_andtal_tender på det lille tandhjul 
            syms N_P %laver var1 til en symbolsk variabel. 
            disp("Udregner Mindste andtal tender via givende værdiger.") %printer hvad vi gør
            eq = N_P == (2*k*cos(psi))/((1+2*m_G)*sin(phi_t)^2) * (m_G + sqrt(m_G^2 + (1+2*m_G*sin(phi_t)^2))); %opskriv ligningen
            displayFormula("N_P == (2*k*cos(psi))/((1+2*m_G)*sin(phi_t)^2) * (m_G + sqrt(m_G^2 + (1+2*m_G*sin(phi_t)^2)))") %vis formlen
            svar = solve(eq, N_P); %solve for variablen
        end
    end
end

