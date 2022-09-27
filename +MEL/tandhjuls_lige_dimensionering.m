classdef tandhjuls_lige_dimensionering
    %Dimensionerings udregninger for LIGE tandhjul
    % Denne class indeholder kun udregninger som har med lige tandhjul at
    % gøre. Skråtandet tandhjuls findes i en anden class. 

    properties
    end

    methods (Static)
        function svar = delecirkeldiameter_via_m_N(d, N, mn) %ændre return værdig ti lat være mere global og putter dcd ind som indput, fjerner også phi som input for og seperere den i en ny ligning
            % delecirkeldiameter_via_modul: kan udregne Delcirkel diameter,
            % Tandantal og modul. Indsæt [] på manglende værdigs plads 
            % variabler
            % dcd == N * mn
            % Input:
            % dcd = delecirkeldiameter
            % N = Tandantal
            % mn = modul
            % Output:
            % Outputter ud efter hvad er tomt. 
            if isempty(d) %dcd er tomt så vi udregner dcd 
                syms d 
                disp("Udregner dcd via N og modul") 
                eq = d == N * mn; %dette er den eneste værdig vi bruger, der er farligt at sætte en variabel = med nået i en function da den kan usynligt overskrive en anden variabel med samme navn
                displayFormula("d1 == N * mn") %
                svar = solve(eq, d); %svar som er vores return værdig sættes lig svaret. 
                
            elseif isempty(N)
                syms N 
                disp("Udregner N via dcd og modul") 
                eq = d == N * mn; 
                displayFormula("d1 == N * mn") 
                svar = solve(eq, N); 

            elseif isempty(mn)
                syms mn 
                disp("Udregner modul via dcd og N") 
                eq = d == N * mn; 
                displayFormula("d1 == N * mn") 
                svar = solve(eq, mn);
 
            end
        end

        function svar = Grundcirkel_Diameter_via_d_phi(d_b, d, phi_deg) 
            % Grundcirkel_Diameter: kan udregne Grundcirkeldiameter,
            % delcirkeldiameter og angrebsvinkel. Indsæt [] på manglende værdigs plads 
            % variabler
            % d_b == dcd * cosd(phi)
            % Input:
            % d_b = Grundcirkel_Diameter
            % dcd = delecirkeldiameter
            % phi = angrebsvinkel i grader
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(d_b) 
                syms d_b 
                disp("Udregner d_b via dcd og phi_deg") 
                eq = d_b == d * cosd(phi_deg); 
                displayFormula("d_b == dcd * cosd(phi_deg)")
                svar = solve(eq, d_b); 

            elseif isempty(d) 
                syms d 
                disp("Udregner dcd via d_b og phi_deg") 
                eq = d_b == d * cosd(phi_deg); 
                displayFormula("d_b == dcd * cosd(phi_deg)")
                svar = solve(eq, d); 

            elseif isempty(phi_deg) 
                syms phi_deg 
                disp("Udregner phi via d_b og dcd") 
                eq = d_b == d * cosd(phi_deg); 
                displayFormula("d_b == dcd * cosd(phi_deg)")
                svar = solve(eq, phi_deg); 

            end
        end

        function svar = center_akse_afstand_via_dcd1_dcd2(dcd1, dcd2, C) 
            % center_akse_afstand: kan udregne centerakse afstand,
            % delcirkel 1 og delcirkel 2. Indsæt [] på manglende værdigs plads 
            % variabler
            % C == (d1 + d2)/2
            % Input:
            % dcd1 = delecirkeldiameter1
            % dcd2 = delecirkeldiameter2
            % C = centerakse afstand
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(C) 
                syms C 
                disp("Udregner C via dcd1 og dcd2") 
                eq = C == (dcd1 + dcd2)/2; 
                displayFormula("C == (dcd1 + dcd2)/2")
                svar = solve(eq, C); 
            elseif isempty(dcd1) 
                syms dcd1 
                disp("Udregner dcd1 via C og dcd2") 
                eq = C == (dcd1 + dcd2)/2; 
                displayFormula("C == (dcd1 + dcd2)/2")
                svar = solve(eq, dcd1); 
            elseif isempty(dcd2) 
                syms dcd2 
                disp("Udregner dcd2 via C og dcd1") 
                eq = C == (dcd1 + dcd2)/2; 
                displayFormula("C == (dcd1 + dcd2)/2")
                svar = solve(eq, dcd2);                
            end
        end

        function svar = Tandtophoejde_addendum_via_m(a, m) 
            % Tandtophoejde_addendum: kan udregne modul eller
            % tandtophøjde/addendum, Indsæt [] på manglende værdigs plads 
            % variabler
            % a == m
            % Input:
            % a = Tandtophoejde_addendum
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(a) 
                syms a 
                disp("Udregner a via m") 
                eq = a == m; 
                displayFormula("a == m")
                svar = solve(eq, a);
            elseif isempty(m) 
                syms m 
                disp("Udregner m via a") 
                eq = a == m; 
                displayFormula("a == m")
                svar = solve(eq, m);                         
            end
        end
        
        function svar = Tandfodshoejde_dedendum_via_m(b, m) 
            % Tandfodshoejde_dedendum: kan udregne modul eller
            % Tandfodshoejde/dedendum, Indsæt [] på manglende værdigs plads 
            % variabler
            % b == 1.25 * m
            % Input:
            % b = Tandfodshoejde_dedendum
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(b) 
                syms b 
                disp("Udregner b via m") 
                eq = b == 1.25 * m; 
                displayFormula("b == 1.25 * m")
                svar = solve(eq, b);
            elseif isempty(m) 
                syms m 
                disp("Udregner m via b") 
                eq = b == 1.25 * m; 
                displayFormula("b == 1.25 * m")
                svar = solve(eq, m);                         
            end
        end

        function svar = Deling_pitch_via_m(p, m) 
            % Deling_pitch: kan udregne modul eller Deling/pitch, Indsæt [] på manglende værdigs plads 
            % variabler
            % p == m * pi
            % Input:
            % p = Deling/pitch
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(p) 
                syms p 
                disp("Udregner p via m") 
                eq = p == m * pi; 
                displayFormula("p == m * pi")
                svar = solve(eq, p);
            elseif isempty(m) 
                syms m 
                disp("Udregner m via p") 
                eq = p == m * pi; 
                displayFormula("p == m * pi")
                svar = solve(eq, m);                         
            end
        end
        
        function svar = Frigang_via_m(c, m) 
            % Frigang: kan udregne modul eller Frigang, Indsæt [] på manglende værdigs plads 
            % variabler
            % c == 0.25 * m
            % Input:
            % c = Frigang
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(c) 
                syms c 
                disp("Udregner c via m") 
                eq = c == 0.25 * m; 
                displayFormula("c == 0.25 * m")
                svar = solve(eq, c);
            elseif isempty(m) 
                syms m 
                disp("Udregner m via c") 
                eq = c == 0.25 * m; 
                displayFormula("c == 0.25 * m")
                svar = solve(eq, m);                         
            end
        end

        function svar = Tandhoejde_via_a_b(h_t, a, b) 
            % Tandhoejde_via_a_b: kan udregne Tandhoejde, addendum/tandtophøjde, eller
            % dedendum/tandfordshøjde, Indsæt [] på manglende værdigs plads 
            % variabler
            % h_t == a + b
            % Input:
            % h_t = Tandhoejde
            % a = addendum/tandtophøjde
            % b = dedendum/tandfordshøjde
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(h_t) 
                syms h_t 
                disp("Udregner ht via a og b") 
                eq = h_t == a + b; 
                displayFormula("h_t == a + b")
                svar = solve(eq, h_t);
            elseif isempty(a) 
                syms a 
                disp("Udregner a via h_t og b") 
                eq = h_t == a + b; 
                displayFormula("h_t == a + b")
                svar = solve(eq, a);     
            elseif isempty(b) 
                syms b 
                disp("Udregner b via h_t og a") 
                eq = h_t == a + b; 
                displayFormula("h_t == a + b")
                svar = solve(eq, b);     
            end
        end

        function svar = Tandbredde_via_m(F, faktor_3til5, m) 
            % Tandbredde: kan udregne Tandbredde, eller modul, Indsæt [] på manglende værdigs plads 
            % variabler, 
            % F == faktor_3til5 * pi * m
            % Input:
            % F = Tandbredde
            % faktor_3til5 = en faktor som skal være imellem 3 - 5 
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(F) 
                syms F 
                disp("Udregner F via m") 
                eq = F == faktor_3til5 * pi * m; 
                displayFormula("F == faktor_3til5 * pi * m")
                svar = solve(eq, F);
            elseif isempty(m) 
                syms m 
                disp("Udregner m via F") 
                eq = F == faktor_3til5 * pi * m; 
                displayFormula("F == faktor_3til5 * pi * m")
                svar = solve(eq, m);
            end
        end

        function svar = Tandtopdiameter_via_d_a(d_a, d, a) 
            % Tandtopdiameter: kan udregne Tandtopdiameter,
            % Delecirkeldiameter eller Tandtophøjde , Indsæt [] på manglende værdigs plads 
            % variabler
            % d_a == d + 2 * a
            % Input:
            % d_a = Tandtopdiameter
            % d = Delecirkeldiameter
            % a = Tandtophøjde
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(d_a) 
                syms d_a 
                disp("Udregner d_a via d og a") 
                eq = d_a == d + 2 * a; 
                displayFormula("d_a == d + 2 * a")
                svar = solve(eq, d_a);
            elseif isempty(d) 
                syms d 
                disp("Udregner d via d_a og a") 
                eq = d_a == d + 2 * a; 
                displayFormula("d_a == d + 2 * a")
                svar = solve(eq, d);                
            elseif isempty(a) 
                syms a
                disp("Udregner a via d_a og d") 
                eq = d_a == d + 2 * a; 
                displayFormula("d_a == d + 2 * a")
                svar = solve(eq, a);    

            end
        end

        function svar = Tandfodsdiameter_via_d_m(d_f, d, m) 
            % Tandfodsdiameter: kan udregne Tandfodsdiameter,
            % Delecirkeldiameter eller modul, Indsæt [] på manglende værdigs plads 
            % variabler
            % d_f == d - 2.5 * m
            % Input:
            % d_f = Tandfodsdiameter
            % d = Delecirkeldiameter
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(d_f) 
                syms d_f
                disp("Udregner d_f via d og m") 
                eq = d_f == d - 2.5 * m; 
                displayFormula("d_f == d - 2.5 * m")
                svar = solve(eq, d_f);   
            elseif isempty(d) 
                syms d
                disp("Udregner d via d_f og m") 
                eq = d_f == d - 2.5 * m; 
                displayFormula("d_f == d - 2.5 * m")
                svar = solve(eq, d);   

            elseif isempty(m) 
                syms m
                disp("Udregner m via d_f og d") 
                eq = d_f == d - 2.5 * m; 
                displayFormula("d_f == d - 2.5 * m")
                svar = solve(eq, m); 
            end
        end
    end
end