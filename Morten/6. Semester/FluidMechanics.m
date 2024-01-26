classdef FluidMechanics
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        FluidType
        ContainerType
        GasConstant
    end

    methods
        function obj = FluidMechanics(FluidType, ContainerType)
            %

            obj.FluidType       = FluidType;
            obj.ContainerType   = ContainerType;

            switch FluidType
                case "Helium"
                    obj.GasConstant = 2077;
                case "Argon"
                    obj.GasConstant = 1337;
            end
        end

        
    end
    
end