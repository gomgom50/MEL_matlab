classdef FMCalculator < FluidMechanics
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Volume
    end

    methods
        function obj = FMCalculator(GasConstant, ContainerType)

            obj@FluidMechanics(GasConstant, ContainerType);
            
        end

        function obj = IdealGasLaw(obj, p, T)

            

        end


    end
end