classdef Fluid < handle
    properties
        Temperature
        Pressure
        FlowRate
        History  % To store the history of changes
    end
    
    methods
        % Constructor
        function obj = Fluid(temperature, pressure, flowRate)
            obj.Temperature = temperature;
            obj.Pressure = pressure;
            obj.FlowRate = flowRate;
            obj.History = {};
        end
        
        % Method to display fluid properties
        function displayInfo(obj)
            fprintf('Temperature: %.2f\n', obj.Temperature);
            fprintf('Pressure: %.2f\n', obj.Pressure);
            fprintf('FlowRate: %.2f\n', obj.FlowRate);
        end
        
        % Method to record changes
        function recordChange(obj, componentName, changes)
            currentValues = struct('Temperature', obj.Temperature, ...
                                   'Pressure', obj.Pressure, ...
                                   'FlowRate', obj.FlowRate);
            changeRecord = struct('Component', componentName, ...
                                  'Changes', changes, ...
                                  'CurrentValues', currentValues);
            obj.History{end+1} = changeRecord;
        end
        
        % Method to change temperature
        function changeTemperature(obj, componentName, change)
            obj.Temperature = obj.Temperature + change;
            obj.recordChange(componentName, struct('Temperature', change));
        end
        
        % Method to change pressure
        function changePressure(obj, componentName, change)
            obj.Pressure = obj.Pressure + change;
            obj.recordChange(componentName, struct('Pressure', change));
        end
        
        % Method to change flow rate
        function changeFlowRate(obj, componentName, change)
            obj.FlowRate = obj.FlowRate + change;
            obj.recordChange(componentName, struct('FlowRate', change));
        end
        
        % Method to display history
        function displayHistory(obj)
            fprintf('Fluid History:\n');
            for i = 1:length(obj.History)
                fprintf('Component: %s\n', obj.History{i}.Component);
                changes = obj.History{i}.Changes;
                currentValues = obj.History{i}.CurrentValues;
                fields = fieldnames(changes);
                for j = 1:length(fields)
                    fprintf('%s Change: %.2f\n', fields{j}, changes.(fields{j}));
                    fprintf('%s Current: %.2f\n', fields{j}, currentValues.(fields{j}));
                end
                fprintf('\n');
            end
        end
    end
end
