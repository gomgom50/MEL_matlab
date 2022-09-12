classdef Udvekslingsforhold
    %Udregner w1 w2 eller i samt gear n1 og n2 og i_total ud for gear. 
    %   Input den de værdiger man har, til total regnig gives en liste i
    %   form af f.eks. n{1} = 20, n{2} = 40. bugstav ville der være n og
    %   gear mængde ville være 2. 
    properties
    end
    methods (Static)
        function val = Vinkelhastighed_Eller_hastighed(w1, w2, i)
        if ~isempty(w1)
            if ~isempty(w2)
                val = w1/w2;
                displayFormula("val = w1/w2")
                disp("Udregner i med w1 og w2")
                return
            end
            if ~isempty(i)
                syms w2
                val = solve(i==w1/w2, w2)
                disp("Udregner w2 med w1 og i")
                return
            end
        end
        if ~isempty(w2)
            if ~isempty(i)
                syms w1
                val = solve(i==w1/w2, w1)
                disp("Udregner w1 med w2 og i")
                return
            end
        end  
        end

        function val = geartandandtal(N1, N2, i)
        if ~isempty(N1)
            if ~isempty(N2)
                val = N2/N1;
                displayFormula("val = N2/N1;")
                disp("Udregner i med N1 og N2")
                return
            end
            if ~isempty(i)
                syms N2
                val = solve(i==N2/N1, N2)
                disp("Udregner N2 med N1 og i")
                return
            end
        end
        if ~isempty(N2)
            if ~isempty(i)
                syms N1
                val = solve(i==N2/N1, N1)
                disp("Udregner N1 med N2 og i")
                return
            end
        end  
        end

        function udvekslingTotal = Gear_Tandantal_Udveksling_Total(Bugstav, gearmengde)
            udvekslingTotaltemp = 1;
            for gear=1:2:gearmengde-1
            temp = Bugstav{gear};
            temp2 = Bugstav{gear + 1};
            udveksliing = Udvekslingsforhold.geartandandtal(temp,temp2,[]);
            udvekslingTotaltemp = udveksliing * udvekslingTotaltemp;
            end
            udvekslingTotal = udvekslingTotaltemp
        end
end
end
