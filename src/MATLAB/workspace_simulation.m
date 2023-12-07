clear;clc;
%% Parameter Define
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sr: the arc length of the bending curve                                 %
% r:  the distance between the central axis of the cable guiding hole on  %
%     the connector and the central axis of the connector                 %
% d:  the thickness of the cross-shaped sheet                             %
% R1: the radius of the bending curve                                     %
% l1: the ideal length of the driving cable 1 between the bottom plane    %
%     of the upper connector and the top plane of the lower connector     %
% Ea: the absolute error                                                  %
% Er: the relative error                                                  %
% S1: the ideal length of the driving cable 1                             %
% alpha1: the central angle of the bending curve                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
length_mm=300;
%% Error Calculatoin
[E,parameter] = error_calculation(length_mm);
% Plot Figures
figure;
subplot(1,2,1);
for i = 1:1:9
    plot(E(i).Ea(:,2),E(i).Ea(:,1),'-');
    hold on;
end
xlabel('Number of connectors');
ylabel('Absolute error(mm)');
grid on;
subplot(1,2,2);
for i = 1:1:9
    plot(E(i).Er(:,2),E(i).Er(:,1),'-');
    hold on;
end
xlabel('Number of connectors');
ylabel('Relative error(%)');
grid on;
%% Workspace Simulation
parameter.n = 15; % Number of connectors
parameter.r1 = 0.21*length_mm;
parameter.d1 = 0.03*length_mm;
parameter.d2 = 0.03*length_mm;
for i = 1:5000
    C = forward_kinematic(parameter);
    coordinate(i,:) = C;
end
figure;
for i=1:5000
    plot3(coordinate(i,1),coordinate(i,2),coordinate(i,3),'bo');
    grid on;
    hold on;
end
