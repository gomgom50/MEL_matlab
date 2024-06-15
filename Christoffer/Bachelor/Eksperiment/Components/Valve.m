classdef Valve < ComponentBase
    properties
        Type
        Size
    end
    
    methods
        % Constructor
        function obj = Valve(data)
            obj@ComponentBase(data);
            obj.Type = data.Type;
            obj.Size = data.Size;
        end
        
        % Method to display valve information
        function displayInfo(obj)
            fprintf('Manufacturer: %s\n', obj.Manufacturer);
            fprintf('Model: %s\n', obj.Model);
            fprintf('Type: %s\n', obj.Type);
            fprintf('Size: %d\n', obj.Size);
        end
        
        % Method to process fluid
        function fluid = processFluid(obj, fluid)
            % Modify the fluid's pressure
            change = -obj.Size * 0.1;
            fluid.changePressure(obj.Model, change);
        end
    end
end
