classdef FMCalculator < FluidMechanics
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % FluidProprties
    end

    methods
        function obj = FMCalculator(FluidType, KnownProperties)
            % KnownProperties must be a struct containing known properties
            % of a fluid such as Density, Temperature etc.

            obj@FluidMechanics(FluidType, KnownProperties);

            FPfns = fieldnames(KnownProperties);

            for i = 1:length(FPfns)
                obj.FluidProperties.(FPfns{i}) = KnownProperties.(FPfns{i});
            end

        end

        function obj = IdealGasLaw(obj, optional)

            arguments
                obj

                optional.Pressure       = nan;
                optional.Density        = nan;
                optional.Temperature    = nan;
                optional.GC             = nan;
            end
          

            % Write optionals to FP
            optional = obj.OptFProps(optional);

            SolvedVar = FMCalculator.FindSolVar(optional);

            OPTfns = fieldnames(optional);

            syms Pressure Density Temperature GC

            IGLeq = Pressure == Density*GC*Temperature;

            ResultIGL = FMCalculator.UnkCalc(IGLeq, optional);

            % fprintf("Solved for: " + SolvedVar + " = %.3f", ResultIGL)

            for i = 1:length(OPTfns)
                if isnan(optional.(OPTfns{i}))
                    obj.FluidProperties.(SolvedVar) = ResultIGL;
                else
                    obj.FluidProperties.(OPTfns{i}) = optional.(OPTfns{i});
                end

            end

        end

        function obj = Density_pmV(obj, optional)
            arguments
                obj

                optional.Density        = nan;
                optional.Mass           = nan;
                optional.Volume         = nan;
            end

            % Write optionals to FP

            
            optional = obj.OptFProps(optional);

            SolvedVar = FMCalculator.FindSolVar(optional);

            OPTfns = fieldnames(optional);

            syms Density Mass Volume

            PMVeq = Density == Mass/Volume;

            ResultIGL = FMCalculator.UnkCalc(PMVeq, optional);


            for i = 1:length(OPTfns)
                if isnan(optional.(OPTfns{i}))
                    obj.FluidProperties.(SolvedVar) = ResultIGL;
                else
                    obj.FluidProperties.(OPTfns{i}) = optional.(OPTfns{i});
                end

            end

        end

        function obj = Specific_Weight(obj, optional)
            arguments
                obj

                optional.Gamma      = nan;
                optional.Weight     = nan;
                optional.Volume     = nan;
                optional.Density    = nan;
            end

            % Write optionals to F

            grav = 9.81; % Make constants an inherent trait of the class

            
            optional = obj.OptFProps(optional);

            SolvedVar = FMCalculator.FindSolVar(optional);

            OPTfns = fieldnames(optional);

            syms Weight Volume Density Gamma

            if isnan(optional.Weight) || isnan(optional.Volume)
                SWeq = Gamma == Weight/Volume;
            else
                SWeq = Gamma == Density*grav;
            end

            ResultIGL = FMCalculator.UnkCalc(SWeq, optional);


            for i = 1:length(OPTfns)
                if isnan(optional.(OPTfns{i}))
                    obj.FluidProperties.(SolvedVar) = ResultIGL;
                else
                    obj.FluidProperties.(OPTfns{i}) = optional.(OPTfns{i});
                end

            end
            
        end

        % Technicality functions

        function optional = OptFProps(obj, OptStruct)
            OPTfns = fieldnames(OptStruct);
            % FPfns = fieldnames(obj.FluidProperties);

            for i = 1:length(OPTfns)
                if isfield(obj.FluidProperties, OPTfns{i})
                    optional.(OPTfns{i}) = obj.FluidProperties.(OPTfns{i});
                elseif ~isnan(OptStruct.(OPTfns{i}))
                    optional.(OPTfns{i}) = OptStruct.(OPTfns{i});
                    obj.FluidProperties.(OPTfns{i}) = OptStruct.(OPTfns{i});
                else
                    optional.(OPTfns{i}) = nan;
                end

            end

        end



        end

        methods(Static)

            function sol = UnkCalc(equation, inputs)

                fns = fieldnames(inputs);

                DependVarsVals = [];
                DependVars = sym.empty;

                for i = 1:length(fns)
                    if isnan(inputs.(fns{i}))
                        SolVar = sym(fns{i});
                    else
                        DependVars(end+1) = sym((fns{i}));
                        DependVarsVals(end+1) = inputs.(fns{i});
                    end
                end


                EQsol = solve(equation, SolVar);
                sol = double(subs(EQsol, DependVars, DependVarsVals));
            end

            function SolvedVar = FindSolVar(OPTstruct)

                OPTfns = fieldnames(OPTstruct);

                for i = 1:length(OPTfns)
                    if isnan(OPTstruct.(OPTfns{i}))
                        SolvedVar = string(OPTfns{i});
                    end
                end
            end


        end
    end