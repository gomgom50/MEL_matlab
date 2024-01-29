classdef FMCalculator < FluidMechanics
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Volume
        FluidProperties
    end

    methods
        function obj = FMCalculator(FluidType, ContainerType)

            obj@FluidMechanics(FluidType, ContainerType);

        end

        function obj = IdealGasLaw(obj, optional)

            arguments
                obj

                optional.Pressure       = nan;
                optional.Density        = nan;
                optional.Temperature    = nan;
                optional.GC             = nan;
            end

            if ~isnan(obj.GasConstant)
                optional.GC = obj.GasConstant;
            end

            OPTfns = fieldnames(optional);
            for i = 1:length(OPTfns)
                if isnan(optional.(OPTfns{i}))
                    SolvedVar = string(OPTfns{i});
                end
            end

            syms Pressure Density Temperature GC

            IGLeq = Pressure == Density*GC*Temperature;

            inputs = optional;

            ResultIGL = FMCalculator.UnkCalc(IGLeq, inputs);

            fprintf("Solved for: " + SolvedVar + " = %.3f", ResultIGL)

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

                optional.Pressure       = nan;
                optional.Density        = nan;
                optional.Volume         = nan;
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


        end
    end