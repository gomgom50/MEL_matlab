classdef Krafter_pa_tandhjul_W
    % Krafter_på_tandhjul(W) indeholder udregninger af de 4 forskellige
    % krafter der er imellem tandhjulene
    %   Husk at når der er en kraft fra det ene tandhjul på det andet
    %   så er der en lige s
    methods (Static)
        function svar = Tangial_kraften_Wt(W_t, T, d)
            % Tangial_kraften_Wt: Udregner W_t, T og d ud fra manglende
            % variabler
            % W_t == T/(d/2)
            % Input:
            % T = Torsions momentet for akslen
            % d = Delcirkel diameteren (pitch diameter)
            % Output:
            % Svaret kommer an på givende variabler. 
            if isempty(W_t)
                disp("W_t er tom")
                disp("løs for manglende variabel her")
                
                syms W_t %laver var1 til en symbolsk variabel. 
                disp("Udregner W_t via T, d") %printer hvad vi gør
                eq = W_t == T/(d/2)
                displayFormula("W_t == T/(d/2)") %vis formlen
                svar = solve(eq, W_t); %solve for variablen

            elseif isempty(T)
                disp("T er tom")
                disp("løs for manglende variabel her")
                
                syms T %laver T til en symbolsk variabel. 
                disp("Udregner T via W_t, d") %printer hvad vi gør
                eq = W_t == T/(d/2)
                displayFormula("W_t == T/(d/2)") %vis formlen
                svar = solve(eq, T); %solve for variablen
                
            elseif isempty(var3)
                disp("d er tom")
                disp("løs for manglende variabel her")
                
                syms d %laver d til en symbolsk variabel. 
                disp("Udregner d via W_t, T") %printer hvad vi gør
                eq = W_t == T/(d/2)
                displayFormula("W_t == T/(d/2)") %vis formlen
                svar = solve(eq, d); %solve for variablen
            end
        end

        function svar = Total_kraften_W(W_t, T, d, phi_n=20, psi=0)
            % Total_kraften_W: Udregner W, T, d, phi_n og psi ud fra manglende
            % variabler
            %  W == W_t / (cos(phi_n) * cos(psi))
            % Input:
            % T = Torsions momentet for akslen
            % d = Delcirkel diameteren (pitch diameter)
            % phi_n = Angrebsvinklen typisk 20 grader
            % psi = skråvinklen på tænderne -- er 0 hvis vi har lige tænder
            % Output:
            % Svaret kommer an på givende variabler. 
            if isempty(W)
                disp("W er tom")
                disp("løs for manglende variabel her")
                
                syms W %laver W til en symbolsk variabel. 
                disp("Udregner W via W_t, phi_n og psi") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, W); %solve for variablen


            elseif isempty(W_t)
                disp("W_t er tom")
                disp("løs for manglende variabel her")
                
                syms W_t %laver W_t til en symbolsk variabel. 
                disp("Udregner W_t via W, phi_n og psi") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, W_t); %solve for variablen

            elseif isempty(phi_n)
                disp("phi_n er tom")
                disp("løs for manglende variabel her")
                
                syms phi_n %laver phi_n til en symbolsk variabel. 
                disp("Udregner phi_n via W, W_t og psi") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, phi_n); %solve for variablen
             
            elseif isempty(psi)
                disp("psi er tom")
                disp("løs for manglende variabel her")
                
                syms psi %laver psi til en symbolsk variabel. 
                disp("Udregner psi via W, W_t og phi_n") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, psi); %solve for variablen            
            end
        end

        function svar = Radial_kraften_Wr(W_r, W, phi_n=20)
            % Radial_kraften_Wr: Udregner W_r, W, phi_n ud fra manglende
            % variabler
            % W_r == W * sin(phi_n)
            % Input:
            % W =  Total kraften fra et tandhjul på det andet
            % phi_n = Angrebsvinklen typisk 20 grader
            % Output:
            % Svaret kommer an på givende variabler. 
            if isempty(W_r)
                disp("W_r er tom")
                disp("løs for manglende variabel her")
                
                syms W %laver W til en symbolsk variabel. 
                disp("Udregner W via W_t, phi_n og psi") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, W); %solve for variablen


            elseif isempty(W_t)
                disp("W_t er tom")
                disp("løs for manglende variabel her")
                
                syms W_t %laver W_t til en symbolsk variabel. 
                disp("Udregner W_t via W, phi_n og psi") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, W_t); %solve for variablen

            elseif isempty(phi_n)
                disp("phi_n er tom")
                disp("løs for manglende variabel her")
                
                syms phi_n %laver phi_n til en symbolsk variabel. 
                disp("Udregner phi_n via W, W_t og psi") %printer hvad vi gør
                eq = W == W_t / (dcos(phi_n) * dcos(psi))
                displayFormula("W == W_t / (cos(phi_n) * cos(psi))") %vis formlen
                svar = solve(eq, phi_n); %solve for variablen
            end
        end


    end
end