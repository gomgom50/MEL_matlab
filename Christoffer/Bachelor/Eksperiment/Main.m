% Create a System instance
mySystem = System();

% Create and add HeatExchanger instances
heatExchanger1 = ComponentFactory.createComponent(ComponentType.HeatExchanger, HeatExchangerData.HX1000);
heatExchanger2 = ComponentFactory.createComponent(ComponentType.HeatExchanger, HeatExchangerData.HX2000);
mySystem = mySystem.addComponent(heatExchanger1);
mySystem = mySystem.addComponent(heatExchanger2);

% Create and add Valve instances
valve1 = ComponentFactory.createComponent(ComponentType.Valve, ValveData.V100);
valve2 = ComponentFactory.createComponent(ComponentType.Valve, ValveData.V200);
mySystem = mySystem.addComponent(valve1);
mySystem = mySystem.addComponent(valve2);

% List all components in the system
mySystem.listComponents();

% Display information about all components in the system
mySystem.displayAllComponents();

% Create a Fluid instance
fluid = Fluid(100, 10, 5);

% Display initial fluid properties
fprintf('Initial fluid properties:\n');
fluid.displayInfo();

% Process the fluid through the system
mySystem.processFluidThroughSystem(fluid);

% Display fluid properties after processing through the system
fprintf('Fluid properties after processing through the system:\n');
fluid.displayInfo();

% Display the history of changes
fluid.displayHistory();

% Plot the fluid history
DataPlotter.plotFluidHistory(fluid);
