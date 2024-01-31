classdef Tortion_og_Effect
    %UNTITLED8 Udregner Tortion og effekt
    %   De forskellige udregnere burde være nogen lunde til at forstår,
    %   alle skal maksium have en ukendt for at virke. 

    properties
    end

    methods (Static)
        function svar = Tortion_Uden_Tab_med_i(T1, T2, i)
            if ~isempty(T2)
                if ~isempty(i)
                    disp("Udregner T1 med T2 og i")
                    T1 = T2*1/i;
                    displayFormula("T1 == T2*(1/i)")
                    svar = T1;
                    return
                elseif ~isempty(T1)
                    disp("udregner i med T1 og T2")
                    syms i 
                    eq = T1 == T2*1/i
                    svar = solve(eq, i);
                    return
                end
            else
                disp("Udrenger T2 via i og T1")
                syms T2
                eq = T1 == T2*1/i
                svar = solve(eq, T2);
                return
            end
        end
        function svar = Tortion_Med_Tab_Simpel(T1, T2, i, n)
            if ~isempty(T2)
                if ~isempty(i)
                    if ~isempty(n)
                        disp("Udregner T1 via T2, i og n")
                        T1 = T2*(1/i)*(1/n);
                        displayFormula("T2*(1/i)*(1/n)")
                        svar = T1;
                        return
                    elseif ~isempty(T1)
                        disp("Udregner n via T2, i og T1")
                        syms n
                        eq = T1 == T2*(1/i)*(1/n)
                        svar = solve(eq, n);
                        return
                    end
                else
                    disp("Udregner i via T2, n og T1")
                    syms i
                    eq = T1 == T2*(1/i)*(1/n)
                    svar = solve(eq, i);
                    return
                end
            else
                disp("Udregner T2 via n, i og T1")
                syms T2
                eq = T1 == T2*(1/i)*(1/n)
                svar = solve(eq, T2);
                return
            end
        end    

        function svar = Tortion_Med_Tab_Enginoer(TNorm, TLast, iTot, nTot)
            if ~isempty(TLast)
                if ~isempty(iTot)
                    if ~isempty(nTot)
                        disp("Udregner T1 via T2, i og n")
                        TNorm = TLast*1/(iTot*nTot);
                        displayFormula("TLast*1/(iTot*nTot)")
                        svar = TNorm;
                        return
                    elseif ~isempty(TNorm)
                        disp("Udregner n via T2, i og T1")
                        syms nTot
                        eq = TNorm == TLast*1/(iTot*nTot)
                        svar = solve(eq, nTot);
                        return
                    end
                else
                    disp("Udregner i via T2, n og T1")
                    syms iTot
                    eq = TNorm == TLast*1/(iTot*nTot)
                    svar = solve(eq, iTot);
                    return
                end
            else
                disp("Udregner T2 via n, i og T1")
                syms TLast
                eq = TNorm == TLast*1/(iTot*nTot)
                svar = solve(eq, TLast);
                return
            end
        end

        function svar = Effekt(P, T, w)
            if ~isempty(T)
                if ~isempty(w)
                    disp("Udregner p via T og w")
                    P = T * w;
                    displayFormula("P=T*w")
                    svar = T * w; 
                    return
                else
                    disp("Udregner w via P og T")
                    syms w
                    eq = P == T * w 
                    svar = solve(eq, w);
                end
            else
                disp("Udregner T via P og w")
                syms T
                eq = P == T * w 
                svar = solve(eq, T);
            end
        end 

        function ntot = Udregn_n_Total(n_tandindgrreb, mengde_tandindgreb, n_lejer, mengde_lejer)
            n_tandindgrreb_temp = n_tandindgrreb^mengde_tandindgreb;
            n_lejer_temp = n_lejer^mengde_lejer;
            ntot = n_tandindgrreb_temp * n_lejer_temp;
        end

        function svar = Tstart_med_T_norm(T_norm, I_t, a, T_start)
            if ~isempty(T_norm) && ~isempty(I_t) && ~isempty(a)
                disp("udregner Tstart")
                displayFormula("Tstart = T_norm+I_t*a")
                svar = T_norm + I_t * a;
            elseif ~isempty(T_norm) && ~isempty(I_t) && ~isempty(T_start)
                syms a
                disp ("udregner acceleration via Tnorm, It og Tstart")
                eq = T_start == T_norm + I_t * a
                svar = solve(eq, a);
            elseif ~isempty(T_norm) && ~isempty(a) && ~isempty(T_start)
                syms I_t    
                disp ("udregner Inertimomment via Tnorm, a og Tstart")
                eq = T_start == T_norm + I_t * a
                svar = solve(eq, I_t);
            elseif ~isempty(I_t) && ~isempty(a) && ~isempty(T_start)
                syms T_norm   
                disp ("udregner T_norm via I_t, a og Tstart")
                eq = T_start == T_norm + I_t * a
                svar = solve(eq, T_norm);
            end
        end 

        function svar = Tstart_med_T_last(T_last, i_tot, n_tot, I_t, a, T_start)
            if ~isempty(T_last) && ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(a)
                disp("Udregner Tstart")
                displayFormula("T_start = T_last * 1/(i_tot * n_tot) + I_t * a")
                svar = T_last*1/(i_tot * n_tot)+I_t*a;
            elseif ~isempty(T_last) && ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(T_start)
                syms a
                disp("Udregner a via tlast, itot, ntot, I_t og T_start")
                eq = T_start == T_last*1/(i_tot * n_tot)+I_t*a
                svar = solve(eq, a);
            elseif ~isempty(T_last) && ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(a) && ~isempty(T_start)
                syms I_t
                disp("Udregner I_t via tlast, itot, ntot, a, og T_start")
                eq = T_start == T_last*1/(i_tot * n_tot)+I_t*a
                svar = solve(eq, I_t);
            elseif ~isempty(T_last) && ~isempty(i_tot) && ~isempty(I_t) && ~isempty(a) && ~isempty(T_start)
                syms n_tot
                disp("Udregner n_tot via tlast, itot, I_t, a, og T_start")
                eq = T_start == T_last*1/(i_tot * n_tot)+I_t*a
                svar = solve(eq, n_tot);
            elseif ~isempty(T_last) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(a) && ~isempty(T_start)
                syms i_tot
                disp("Udregner i_tot via tlast, n_tot, I_t, a, og T_start")
                eq = T_start == T_last*1/(i_tot * n_tot)+I_t*a
                svar = solve(eq, i_tot);
            elseif ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(a) && ~isempty(T_start)
                syms T_last
                disp("Udregner T_last via i_tot, n_tot, I_t, a, og T_start")
                eq = T_start == T_last*1/(i_tot * n_tot)+I_t*a
                svar = solve(eq, T_last);
            end
        end

        function svar = Acceleration(a, w1_i_1_over_s_radianer, ts_tid)
            w1 = w1_i_1_over_s_radianer;
            if ~isempty(w1) && ~isempty(ts_tid)
                disp("udregner a")
                displayFormula("a = w1/ts")
                svar = w1/ts_tid
            elseif ~isempty(w1) && ~isempty(a)
                syms ts_tid
                disp ("udregner ts (tid) via a og w1")
                eq = a == w1/ts_tid
                svar = solve(eq, ts_tid);
            elseif ~isempty(ts_tid) && ~isempty(a)
                syms w1
                disp ("udregner w1 via a og ts")
                eq = a == w1/ts_tid
                svar = solve(eq, w1);
            end
        end


        function svar = Tbrems_med_T_last(T_last, i_tot, n_tot, I_t, a, T_brems)
            if ~isempty(T_last) && ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(a)
                disp("Udregner Tbrems")
                displayFormula("T_brems = -T_last*1/(n_tot * i_tot)+I_t*a")
                svar = -T_last*1/(n_tot * i_tot)+I_t*a;
            elseif ~isempty(T_last) && ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(T_brems)
                syms a
                disp("Udregner a via tlast, itot, ntot, I_t og T_start")
                eq = T_brems == -T_last*1/(n_tot * i_tot)+I_t*a
                svar = solve(eq, a);
            elseif ~isempty(T_last) && ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(a) && ~isempty(T_brems)
                syms I_t
                disp("Udregner I_t via tlast, itot, ntot, a, og T_start")
                eq = T_brems == -T_last*1/(n_tot * i_tot)+I_t*a
                svar = solve(eq, I_t);
            elseif ~isempty(T_last) && ~isempty(i_tot) && ~isempty(I_t) && ~isempty(a) && ~isempty(T_brems)
                syms n_tot
                disp("Udregner n_tot via tlast, itot, I_t, a, og T_start")
                eq = T_brems == -T_last*1/(n_tot * i_tot)+I_t*a
                svar = solve(eq, n_tot);
            elseif ~isempty(T_last) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(a) && ~isempty(T_brems)
                syms i_tot
                disp("Udregner i_tot via tlast, n_tot, I_t, a, og T_start")
                eq = T_brems == -T_last*1/(n_tot * i_tot)+I_t*a
                svar = solve(eq, i_tot);
            elseif ~isempty(i_tot) && ~isempty(n_tot) && ~isempty(I_t) && ~isempty(a) && ~isempty(T_brems)
                syms T_last
                disp("Udregner T_last via i_tot, n_tot, I_t, a, og T_start")
                eq = T_brems == -T_last*1/(n_tot * i_tot)+I_t*a
                svar = solve(eq, T_last);
            end
        end



    end
end