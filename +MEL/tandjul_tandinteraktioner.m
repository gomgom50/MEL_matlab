classdef tandjul_tandinteraktioner
    % Diverse tandinteraktioners udregninger 
    %   Nogle af disse funktioner er ikke fuldt dynamiske og udregner kun specifikke ting.  
    methods (Static)
        function svar = ingrebsgraden_fuld_udledt (d_a1, d_a2, d_b1, d_b2, d_1, d_2, phi_deg, mn)
            % ingrebsgraden_fuld_udledt: Udregner ingrebsgraden fuld udledt: 
            % variabler
            % m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_deg))/(pi*mn*cosd(phi_deg))
            % Input:
            % d_a1 = Tandtopdiameter 1
            % d_a2 = Tandtopdiameter 2
            % d_b1 = Grundcirkeldiameter 1
            % d_b2 = Grundcirkeldiameter 2
            % d_1 = Delecirkeldiameter 1
            % d_2 = Delecirkeldiameter 2
            % phi_deg = angrebsvinkel i grader
            % m = modul 
            % Output:
            % m_c = ingrebsgraden skal være > 1.2 for tilstrækligt ingreb
            syms m_c %laver var1 til en symbolsk variabel. 
            disp("Udregner ingrebsgraden via givende værdiger.") %printer hvad vi gør
            eq = m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_deg))/(pi*mn*cosd(phi_deg)); %opskriv ligningen
            displayFormula("m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_deg))/(pi*m*cosd(phi_deg))") %vis formlen
            svar = solve(eq, m_c); %solve for variablen
        end

        function svar = ingrebsgraden_med_p (d_a1, d_a2, d_b1, d_b2, d_1, d_2, p, phi_deg)
            % ingrebsgraden_fuld_udledt: Udregner ingrebsgraden med p: 
            % variabler
            % m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_deg))/(p*cosd(phi_deg))
            % Input:
            % d_a1 = Tandtopdiameter 1
            % d_a2 = Tandtopdiameter 2
            % d_b1 = Grundcirkeldiameter 1
            % d_b2 = Grundcirkeldiameter 2
            % d_1 = Delecirkeldiameter 1
            % d_2 = Delecirkeldiameter 2
            % phi_deg = phi i grader
            % p = deling / pitch
            % Output:
            % m_c = ingrebsgraden skal være > 1.2 for tilstrækligt ingreb
            syms m_c %laver var1 til en symbolsk variabel. 
            disp("Udregner ingrebsgraden via givende værdiger.") %printer hvad vi gør
            eq = m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_deg))/(p*cosd(phi_deg)); %opskriv ligningen
            displayFormula("m_c == (0.5*(sqrt(d_a1^2 - d_b1^2) + sqrt(d_a2^2 - d_b2^2))-((d_1+d_2)/2)*sind(phi_deg))/(p*cosd(phi_deg))") %vis formlen
            svar = solve(eq, m_c); %solve for variablen
        end

        function svar = ingrebsgraden_med_Lab (m_c, Lab, p, phi_deg)
            % ingrebsgraden_fuld_udledt: Udregner ingrebsgraden fuld udledt: 
            % variabler
            % m_c == (Lab)/(p*cos(phi_deg))
            % Input:
            % Lab = lab??
            % phi_deg = phi i grader
            % p = deling / pitch
            % Output:
            % m_c = ingrebsgraden skal være > 1.2 for tilstrækligt ingreb
            % ellers andet som ikke blivet givet. 
            if isempty(m_c)
                syms m_c %laver var1 til en symbolsk variabel. 
                disp("Udregner m_c via givende værdiger.") %printer hvad vi gør
                eq = m_c == (Lab)/(p*cos(phi_deg)); %opskriv ligningen
                displayFormula("m_c == (Lab)/(p*cos(phi_deg))") %vis formlen
                svar = solve(eq, m_c); %solve for variablen
            elseif isempty(Lab)
                syms Lab %laver var1 til en symbolsk variabel. 
                disp("Udregner Lab via givende værdiger.") %printer hvad vi gør
                eq = m_c == (Lab)/(p*cos(phi_deg)); %opskriv ligningen
                displayFormula("m_c == (Lab)/(p*cos(phi_deg))") %vis formlen
                svar = solve(eq, Lab); %solve for variablen
            elseif isempty(p)
                syms p %laver var1 til en symbolsk variabel. 
                disp("Udregner p via givende værdiger.") %printer hvad vi gør
                eq = m_c == (Lab)/(p*cos(phi_deg)); %opskriv ligningen
                displayFormula("m_c == (Lab)/(p*cos(phi_deg))") %vis formlen
                svar = solve(eq, p); %solve for variablen
            elseif isempty(phi_deg)
                syms phi_deg %laver var1 til en symbolsk variabel. 
                disp("Udregner phi_deg via givende værdiger.") %printer hvad vi gør
                eq = m_c == (Lab)/(p*cos(phi_deg)); %opskriv ligningen
                displayFormula("m_c == (Lab)/(p*cos(phi_deg))") %vis formlen
                svar = solve(eq, phi_deg); %solve for variablen
            end
        end

        function svar = minimum_antal_tender_ved_1til1_gearing (N_p, k, phi_deg)
            % minimum_antal_tender_ved_1til1_gearing: Udregner ingrebsgraden fuld udledt: 
            % variabler
            % N_p == (2*k)/(3*sin(phi_deg)^2) * (1 + sqrt(1+3*sin(phi_deg)^2))
            % Input:
            % N_p = minimums tand andtal
            % k = 1 (faktor) for tænder med fuld højde 0.8 for afkortede tænder
            % phi = angrebsvinkel i grader. 
            % Output:
            % Outputter ud efter hvad er tomt. Kan ikke udregne k da det er
            % en faktor
            if isempty(N_p)
                syms N_p %laver var1 til en symbolsk variabel. 
                disp("Udregner N_p via k og phi") %printer hvad vi gør
                eq = N_p == (2*k)/(3*sind(phi_deg)^2) * (1 + sqrt(1+3*sind(phi_deg)^2)); %opskriv ligningen
                displayFormula("N_p == (2*k)/(3*sind(phi_deg)^2) * (1 + sqrt(1+3*sind(phi_deg)^2))") %vis formlen
                svar = solve(eq, N_p); %solve for variablen
            elseif isempty(phi_deg)
                syms phi_deg %laver var1 til en symbolsk variabel. 
                disp("Udregner phi_deg via k og N_p") %printer hvad vi gør
                eq = N_p == (2*k)/(3*sind(phi_deg)^2) * (1 + sqrt(1+3*sind(phi_deg)^2)); %opskriv ligningen
                displayFormula("N_p == (2*k)/(3*sind(phi_deg)^2) * (1 + sqrt(1+3*sind(phi_deg)^2))") %vis formlen
                svar = solve(eq, phi_deg); %solve for variablen               
            end
        end

        function svar = minimum_antal_tender_tandjulspar (m_G, phi_deg, k)
            % minimum_antal_tender_tandjulspar: Udregner minimums andtal af
            % tænder på det mindste tandhjul i et tandhjuls par
            % variabler
            % N_P == (2*k)/((1+2*m_G)*sind(phi_deg)^2) * (m_G + sqrt(m_G^2 + (1+2*m_G)*sind(phi_deg)^2))
            % Input:
            % m_g = N_G/N_P >= 1 tandantal for stort og lille tandhjul, M_G
            % er enten lig i vis vi geare op eller 1/i vis vi geare ned. 
            % phi = angrebsvinkel i grader
            % k = 1 (faktor) for tænder med fuld højde 0.8 for afkortede tænder
            % Output:
            % N_P minimum_antal_tender på det lille hjul 
            syms N_P %laver var1 til en symbolsk variabel. 
            disp("Udregner minimum tandandtal på det lille tandhjul via givende værdiger.") %printer hvad vi gør
            eq = N_P == (2*k)/((1+2*m_G)*sind(phi_deg)^2) * (m_G + sqrt(m_G^2 + (1+2*m_G)*sind(phi_deg)^2)); %opskriv ligningen
            displayFormula("N_P == (2*k)/((1+2*m_G)*(sind(phi_deg))^2) * (m_G + sqrt(m_G^2 + (1+2*m_G)*sind(phi_deg)^2))") %vis formlen
            svar = solve(eq, N_P); %solve for variablen
        end
    end
end