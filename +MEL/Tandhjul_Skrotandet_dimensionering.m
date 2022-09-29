classdef Tandhjul_Skrotandet_dimensionering
    % Class_Demo Beskriv hvad denne class indeholder. 
    %   Giv en detalijeret beskrivelse af denne klasse. 
    methods (Static)
        function svar = Udregning_psi_via_phit_phin (psi_deg, phi_t_deg, phi_n_deg)
            % Udregning_psi_via_phit_phin: Udregner psi i grader, via phi_t og phi_n i grader
            % indtats manglende variable med []
            % cosd(psi_deg) == (tand(phi_n_deg))/(tand(phi_t_deg))
            % Input:
            % psi = skraavinkel
            % psi_t = angrevbsvinkel tangential 
            % psi_n = angrevsvinkel 
            % Output:
            % Svaret kommer an på manglende inputs. 
            if isempty(psi_deg)
                syms psi_deg
                disp("Udregner psi_deg via phi_t_deg og phi_n_deg") 
                eq = cosd(psi_deg) == (tand(phi_n_deg))/(tand(phi_t_deg)); 
                displayFormula("cosd(psi) == (tand(phi_n_deg))/(tand(phi_t_deg))")
                svar = solve(eq, psi_deg);
            elseif isempty(phi_t_deg)
                syms phi_t_deg
                disp("Udregner phi_t_deg via psi_deg og phi_n_deg") 
                eq = cosd(psi_deg) == (tand(phi_n_deg))/(tand(phi_t_deg)); 
                displayFormula("cosd(psi) == (tand(phi_n_deg))/(tand(phi_t_deg))")
                svar = solve(eq, phi_t_deg);
            elseif isempty(phi_n_deg)
                syms phi_n_deg
                disp("Udregner phi_n_deg via psi_deg og phi_n_deg") 
                eq = cosd(psi_deg) == (tand(phi_n_deg))/(tand(phi_t_deg)); 
                displayFormula("cosd(psi) == (tand(phi_n_deg))/(tand(phi_t_deg))")
                svar = solve(eq, phi_n_deg);    
            end         
        end

        function svar = Udregning_psi_via_mn_mt (psi_deg, mn, mt)
            % Udregning_psi_via_mn_mt: psi_deg, mn og mt ud fra manglende
            % indtats manglende variable med []
            % cosd(psi_deg) == mn/mt
            % Input:
            % psi = skraavinkel
            % mn = modul
            % mt = modul tangential  
            % Output:
            % Svaret kommer an på manglende inputs. 
            if isempty(psi_deg)
                syms psi_deg
                disp("Udregner psi_deg via mn og mt") 
                eq = cosd(psi_deg) == mn/mt; 
                displayFormula("cosd(psi_deg) == mn/mt")
                svar = solve(eq, psi_deg);
            elseif isempty(mn)
                syms mn
                disp("Udregner mn via psi_deg og mt") 
                eq = cosd(psi_deg) == mn/mt; 
                displayFormula("cosd(psi_deg) == mn/mt")
                svar = solve(eq, mn);   
            elseif isempty(mt)
                syms mt
                disp("Udregner mt via psi_deg og mn") 
                eq = cosd(psi_deg) == mn/mt; 
                displayFormula("cosd(psi_deg) == mn/mt")
                svar = solve(eq, mt); 
            end         
        end

        function svar = Delecirkeldiameter_via_N_mt (d, mt, N)
            % Delecirkeldiameter_via_N_mt: delcirkel diameter ud fra modul
            % tangental og tandandtal 
            % indtats manglende variable med []
            % d == N * mt
            % Input:
            % d = Delecirkeldiameter
            % N = tand andtal
            % mt = modul tangential  
            % Output:
            % Svaret kommer an på manglende inputs. 
            if isempty(d)
                syms d
                disp("Udregner d via mt og N") 
                eq = d == N * mt; 
                displayFormula("d == N * mt")
                svar = solve(eq, d);
            elseif isempty(mt)
                syms mt
                disp("Udregner mt via d og N") 
                eq = d == N * mt; 
                displayFormula("d == N * mt")
                svar = solve(eq, mt);
            elseif isempty(N)
                syms N
                disp("Udregner N via mt og d") 
                eq = d == N * mt; 
                displayFormula("d == N * mt")
                svar = solve(eq, N);
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

        function svar = Tandtopdiameter_via_d_m(d_a, d, mn) 
            % Tandfodsdiameter: kan udregne Tandfodsdiameter,
            % Delecirkeldiameter eller modul, Indsæt [] på manglende værdigs plads 
            % variabler
            % d_a == d + 2 * m
            % Input:
            % d_f = Tandfodsdiameter
            % d = Delecirkeldiameter
            % m = modul
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(d_a) 
                syms d_a
                disp("Udregner d_f via d og m") 
                eq = d_a == d + 2 * mn; 
                displayFormula("d_a == d + 2 * m")
                svar = solve(eq, d_a);   
            elseif isempty(d) 
                syms d
                disp("Udregner d via d_f og m") 
                eq = d_a == d + 2 * mn; 
                displayFormula("d_a == d + 2 * m")
                svar = solve(eq, d);   

            elseif isempty(mn) 
                syms mn
                disp("Udregner m via d_f og d") 
                eq = d_a == d + 2 * mn; 
                displayFormula("d_a == d + 2 * m")
                svar = solve(eq, mn); 
            end
        end

        function svar = Tandfodsdiameter_via_d_m(d_f, d, mn) 
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
                eq = d_f == d - 2.5 * mn; 
                displayFormula("d_f == d - 2.5 * m")
                svar = solve(eq, d_f);   
            elseif isempty(d) 
                syms d
                disp("Udregner d via d_f og m") 
                eq = d_f == d - 2.5 * mn; 
                displayFormula("d_f == d - 2.5 * m")
                svar = solve(eq, d);   

            elseif isempty(mn) 
                syms mn
                disp("Udregner m via d_f og d") 
                eq = d_f == d - 2.5 * mn; 
                displayFormula("d_f == d - 2.5 * m")
                svar = solve(eq, mn); 
            end
        end

        function svar = Tandfodsdiameter_via_d_b(d_f, d, b) 
            % Tandtopdiameter: kan udregne Tandtopdiameter,
            % Delecirkeldiameter eller Tandtophøjde , Indsæt [] på manglende værdigs plads 
            % variabler
            % d_f == d - 2 * b
            % Input:
            % d_a = Tandtopdiameter
            % d = Delecirkeldiameter
            % a = Tandtophøjde
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(d_f) 
                syms d_f 
                disp("Udregner d_f via d og a") 
                eq = d_f == d - 2 * b; 
                displayFormula("d_f == d - 2 * b")
                svar = solve(eq, d_f);
            elseif isempty(d) 
                syms d 
                disp("Udregner d via d_a og a") 
                eq = d_f == d - 2 * b; 
                displayFormula("d_f == d - 2 * b")
                svar = solve(eq, d);                
            elseif isempty(b) 
                syms b
                disp("Udregner b via d_a og d") 
                eq = d_f == d - 2 * b; 
                displayFormula("d_f == d - 2 * b")
                svar = solve(eq, b);    
            end
        end    

        function svar = Grundcirkel_Diameter_via_d_phit(d_b, d, phi_t_deg) 
            % Grundcirkel_Diameter: kan udregne Grundcirkeldiameter,
            % delcirkeldiameter og angrebsvinkel. Indsæt [] på manglende værdigs plads 
            % variabler
            % d_b == dcd * cosd(phi_t)
            % Input:
            % d_b = Grundcirkel_Diameter
            % dcd = delecirkeldiameter
            % phi = angrebsvinkel i grader
            % Output:
            % Outputter ud efter hvad er tomt.
            if isempty(d_b) 
                syms d_b 
                disp("Udregner d_b via dcd og phi_deg") 
                eq = d_b == d * cosd(phi_t_deg); 
                displayFormula("d_b == dcd * cosd(phi_deg)")
                svar = solve(eq, d_b); 

            elseif isempty(d) 
                syms d 
                disp("Udregner dcd via d_b og phi_deg") 
                eq = d_b == d * cosd(phi_t_deg); 
                displayFormula("d_b == dcd * cosd(phi_deg)")
                svar = solve(eq, d); 

            elseif isempty(phi_t_deg) 
                syms phi_t_deg 
                disp("Udregner phi via d_b og dcd") 
                eq = d_b == d * cosd(phi_t_deg); 
                displayFormula("d_b == dcd * cosd(phi_deg)")
                svar = solve(eq, phi_t_deg); 

            end
        end



    end
end