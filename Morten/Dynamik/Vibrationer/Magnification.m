%Magnification
close all; clc; clear all

omega_ratio=linspace(0,3,1000);
M=1./(1-(omega_ratio).^2);


figure
plot(omega_ratio,M,'b-','linewidth',4)
hold on
grid
axis square
xlabel('Frequency ratio:  $\frac{\omega}{\omega_n}$','Interpreter','latex','FontSize', 20)
ylabel('Magnification: $\frac{X}{\delta_{st}}$','Interpreter','latex','FontSize', 20)
xlim([0 3])
ylim([-10 10])
set(gca,'Ytick',[ -10 -1 0 1 5 10])

figure
plot(omega_ratio,abs(M),'b-','linewidth',4)
hold on
grid
axis square
xlabel('Frequency ratio:  $\frac{\omega}{\omega_n}$','Interpreter','latex','FontSize', 20)
ylabel('[Magnification]: [$\frac{X}{\delta_{st}}$]','Interpreter','latex','FontSize', 20)
xlim([0 3])
ylim([0 10])
set(gca,'Ytick',[0 1 5 10])