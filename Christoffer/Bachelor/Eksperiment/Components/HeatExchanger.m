classdef HeatExchanger < ComponentBase
    properties
        Capacity
        Efficiency
    end
    
    methods
        % Constructor
        function obj = HeatExchanger(data)
            obj@ComponentBase(data);
            obj.Capacity = data.Capacity;
            obj.Efficiency = data.Efficiency;
        end
        
        % Method to display heat exchanger information
        function displayInfo(obj)
            fprintf('Manufacturer: %s\n', obj.Manufacturer);
            fprintf('Model: %s\n', obj.Model);
            fprintf('Capacity: %.2f\n', obj.Capacity);
            fprintf('Efficiency: %.2f%%\n', obj.Efficiency * 100);
        end
        
        % Method to process fluid
        % Method to process fluid
        function fluid = processFluid(obj, fluid)
            % Modify the fluid's temperature
            change = fluid.Temperature * (obj.Efficiency - 1);
            fluid.changeTemperature(obj.Model, change);
        end
    end
end
