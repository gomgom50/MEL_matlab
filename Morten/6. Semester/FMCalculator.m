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
            
            syms Pressure Density Temperature GC

            IGLeq = Pressure == Density*GC*Temperature;

            UnkCalc(IGLeq,optional)



        end


        function sol = UnkCalc(equation, inputs)
            equation
            inputs

            % fns = fieldnames(inputs);
            % 
            % DependVars = [];
            % 
            % for i = 1:length(fns)
            %     if isnan(inputs.(fns{i}))
            %         SolVar = sym(fns{i});
            %     else
            %         DependVars(end+1) = sym(fns{i});
            %     end
            % end

            % sol = solve(equation, SolVar)


        end


    end
    % 
    % methods
    % 
    %     function sol = UnkCalc(equation, inputs)
    % 
    %         fns = fieldnames(inputs);
    % 
    %         DependVars = [];
    % 
    %         for i = 1:length(fns)
    %             if isnan(inputs.(fns{i}))
    %                 SolVar = sym(fns{i});
    %             else
    %                 DependVars(end+1) = sym(fns{i});
    %             end
    %         end
    % 
    %         sol = solve(equation, SolVar)
    % 
    % 
    %     end
    % 
    % 
    % 
    % end
end