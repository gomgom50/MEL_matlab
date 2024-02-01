classdef FluidMechanics
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        FluidType
        FluidProperties
    end

    methods
        function obj = FluidMechanics(FluidType, KnownProperties)


            obj.FluidType       = FluidType;

            switch FluidType
                case "Helium"
                    obj.FluidProperties.GC = 2077;
                case "Argon"
                    obj.FluidProperties.GC = 1337;
                case "Gasoline"
                    obj.FluidProperties.Density = 715;
                case "Ethyl"
                    obj.FluidProperties.Density = 789;
            end
        end

        
    end
    
end