classdef DataPlotter
    methods (Static)
        function plotFluidHistory(fluid)
            % Extract data from fluid history
            numEntries = length(fluid.History);
            componentNames = cell(numEntries, 1);
            temperatureChanges = zeros(numEntries, 1);
            currentTemperatures = zeros(numEntries, 1);
            pressureChanges = zeros(numEntries, 1);
            currentPressures = zeros(numEntries, 1);
            flowRateChanges = zeros(numEntries, 1);
            currentFlowRates = zeros(numEntries, 1);
            
            for i = 1:numEntries
                entry = fluid.History{i};
                componentNames{i} = entry.Component;
                changes = entry.Changes;
                currentValues = entry.CurrentValues;
                
                if isfield(changes, 'Temperature')
                    temperatureChanges(i) = changes.Temperature;
                    currentTemperatures(i) = currentValues.Temperature;
                end
                if isfield(changes, 'Pressure')
                    pressureChanges(i) = changes.Pressure;
                    currentPressures(i) = currentValues.Pressure;
                end
                if isfield(changes, 'FlowRate')
                    flowRateChanges(i) = changes.FlowRate;
                    currentFlowRates(i) = currentValues.FlowRate;
                end
            end
            
            % Create a new figure for the plots
            figure;
            
            % Plot temperature changes
            subplot(3, 2, 1);
            bar(temperatureChanges);
            set(gca, 'XTickLabel', componentNames, 'XTick', 1:numEntries);
            xlabel('Component');
            ylabel('Temperature Change');
            title('Temperature Changes by Component');
            
            subplot(3, 2, 2);
            plot(1:numEntries, currentTemperatures, '-o');
            set(gca, 'XTick', 1:numEntries, 'XTickLabel', componentNames);
            xlabel('Component');
            ylabel('Current Temperature');
            title('Current Temperatures by Component');
            
            % Plot pressure changes
            subplot(3, 2, 3);
            bar(pressureChanges);
            set(gca, 'XTickLabel', componentNames, 'XTick', 1:numEntries);
            xlabel('Component');
            ylabel('Pressure Change');
            title('Pressure Changes by Component');
            
            subplot(3, 2, 4);
            plot(1:numEntries, currentPressures, '-o');
            set(gca, 'XTick', 1:numEntries, 'XTickLabel', componentNames);
            xlabel('Component');
            ylabel('Current Pressure');
            title('Current Pressures by Component');
            
            % Plot flow rate changes
            subplot(3, 2, 5);
            bar(flowRateChanges);
            set(gca, 'XTickLabel', componentNames, 'XTick', 1:numEntries);
            xlabel('Component');
            ylabel('Flow Rate Change');
            title('Flow Rate Changes by Component');
            
            subplot(3, 2, 6);
            plot(1:numEntries, currentFlowRates, '-o');
            set(gca, 'XTick', 1:numEntries, 'XTickLabel', componentNames);
            xlabel('Component');
            ylabel('Current Flow Rate');
            title('Current Flow Rates by Component');
        end
    end
end
