classdef Class_Demo
    % Class_Demo Beskriv hvad denne class indeholder. 
    %   Giv en detalijeret beskrivelse af denne klasse. 
    methods (Static)
        function svar = Funktion1 (var1, var2, var3)
            % Funktion1: Udregner var1, var2 og var3 ud fra manglende
            % variabler
            % var1 == var2 + var3
            % Input:
            % var1 = beskrivelse af var1
            % var2 = beskrivelse af var2
            % var3 = beskrivelse af var3
            % Output:
            % Svaret kommer an på givende variabler. 
            if isempty(var1)
                disp("var 1 er tom")
                disp("løs for manglende variabel her")
                
                %Eksempel på en solve: 

                syms var1 %laver var1 til en symbolsk variabel. 
                disp("Udregner var1 via var2 og var3") %printer hvad vi gør
                eq = var1 == var2 + var3 %opskriv ligningen
                displayFormula("var1 == var2 + var3") %vis formlen
                svar = solve(eq, var1); %solve for variablen

            elseif isempty(var2)
                disp("var 2 er tom")
                disp("løs for manglende variabel her")
                svar = "manglende variabel";
            elseif isempty(var3)
                disp("var 1 er tom")
                disp("løs for manglende variabel her")
                svar = "manglende variabel";
            end
        end

        function svar = Funktion2 (var1, var2, var3)
            % Funktion2: Udregner var1, var2 og var3 ud fra manglende
            % variabler
            % var1 == var2 + var3
            % Input:
            % var1 = beskrivelse af var1
            % var2 = beskrivelse af var2
            % var3 = beskrivelse af var3
            % Output:
            % Svaret kommer an på givende variabler. 
            if isempty(var1)
                disp("var 1 er tom")
                disp("løs for manglende variabel her")
                svar = "manglende variabel";
            elseif isempty(var2)
                disp("var 2 er tom")
                disp("løs for manglende variabel her")
                svar = "manglende variabel";
            elseif isempty(var3)
                disp("var 1 er tom")
                disp("løs for manglende variabel her")
                svar = "manglende variabel";
            end
        end

    end
end