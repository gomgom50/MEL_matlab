classdef FluidMechanics
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        GasType
        ContainerType
        GasConstant
    end

    methods
        function obj = FluidMechanics(GasType, ContainerType)
            %UNTITLED3 Construct an instance of this class
            %   Detailed explanation goes here
            obj.GasType = GasType;
            obj.ContainerType = ContainerType;

            switch GasType
                case "Helium"
                    obj.GasConstant = 2077;
                case "Argon"
                    obj.GasConstant = 1337;
            end
        end

        
    end
end