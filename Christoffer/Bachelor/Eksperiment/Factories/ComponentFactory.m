classdef ComponentFactory
    methods (Static)
        function component = createComponent(componentType, modelData)
            switch componentType
                case ComponentType.HeatExchanger
                    component = HeatExchanger(modelData);
                case ComponentType.Valve
                    component = Valve(modelData);
                otherwise
                    error('Unsupported component type');
            end
        end
    end
end
