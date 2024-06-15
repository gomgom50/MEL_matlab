classdef System
    properties
        Components
    end
    
    methods
        % Constructor
        function obj = System()
            obj.Components = {};
        end
        
        % Method to add a component
        function obj = addComponent(obj, component)
            obj.Components{end+1} = component;
        end
        
        % Method to list all components
        function listComponents(obj)
            fprintf('Components in the system:\n');
            for i = 1:length(obj.Components)
                fprintf('%d. %s\n', i, obj.Components{i}.getModelName());
            end
        end
        
        % Method to display all components' information
        function displayAllComponents(obj)
            fprintf('Displaying all components information:\n');
            for i = 1:length(obj.Components)
                obj.Components{i}.displayInfo();
                fprintf('\n');
            end
        end
        
        % Method to process a fluid through the system
        function fluid = processFluidThroughSystem(obj, fluid)
            for i = 1:length(obj.Components)
                obj.Components{i}.processFluid(fluid);
            end
        end
    end
end
