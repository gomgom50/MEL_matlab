classdef ComponentBase
    properties
        Manufacturer
        Model
    end
    
    methods
        % Constructor
        function obj = ComponentBase(data)
            obj.Manufacturer = data.Manufacturer;
            obj.Model = data.Model;
        end
        
        % Abstract method to display component information
        function displayInfo(obj)
            error('displayInfo method must be implemented in derived classes');
        end
        
        % Method to return model name
        function name = getModelName(obj)
            name = obj.Model;
        end
        
        % Abstract method to process fluid
        function fluid = processFluid(obj, fluid)
            error('processFluid method must be implemented in derived classes');
        end
    end
end
