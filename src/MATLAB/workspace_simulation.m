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
% % Plot Figures
% figure;
% subplot(1,2,1);
% for i = 1:1:9
%     plot(E(i).Ea(:,2),E(i).Ea(:,1),'-');
%     hold on;
% end
% xlabel('Number of connectors');
% ylabel('Absolute error(mm)');
% grid on;
% subplot(1,2,2);
% for i = 1:1:9
%     plot(E(i).Er(:,2),E(i).Er(:,1),'-');
%     hold on;
% end
% xlabel('Number of connectors');
% ylabel('Relative error(%)');
% grid on;
%% Workspace Simulation
parameter.n = 10; % Number of connectors
parameter.r1 = 0.21*length_mm;
parameter.d1 = 0.03*length_mm;
parameter.d2 = 0.03*length_mm;
for i = 1:2000
    [C1,C2] = forward_kinematic(parameter);
    coord1(i,:) = C1;
    coord2(i,:) = C2;
end
% figure; %%% The subplots of figure %%%
% s = 0.002*length(coord1(:,1));
% subplot(1,2,1); % subplot1
% scatter3(coord1(:,1),coord1(:,2),coord1(:,3),s,"filled",'MarkerEdgeColor',[.93 .69 .13], 'MarkerFaceColor',[1 .84 .28]);
% grid on;
% subplot(1,2,2); % subplot3
% scatter3(coord2(:,1),coord2(:,2),coord2(:,3),s,"filled",'MarkerEdgeColor',[.85 .33 .10], 'MarkerFaceColor',[1 .48 .25]);
% grid on;
% hold on;

% figure;
% s = 0.002*length(coord1(:,1));grid on;
% scatter3(coord2(:,1),coord2(:,2),coord2(:,3),s,"filled", ...
%     'MarkerEdgeColor',[.85 .33 .10], ...
%     'MarkerFaceColor',[1 .48 .25]);
% hold on;
% scatter3(coord1(:,1),coord1(:,2),coord1(:,3),s,"filled", ...
%     'MarkerEdgeColor',[.93 .69 .13], ...
%     'MarkerFaceColor',[1 .84 .28]);
% hold on;

figure;
s = 0.002*length(coord1(:,1));grid on;
subplot(1,2,1)
scatter(coord2(:,1),coord2(:,2),s,"filled", ...
    'MarkerEdgeColor',[.85 .33 .10], ...
    'MarkerFaceColor',[1 .48 .25]);
grid on;
subplot(1,2,2)
scatter(coord2(:,1),coord2(:,3),s,"filled", ...
    'MarkerEdgeColor',[.85 .33 .10], ...
    'MarkerFaceColor',[1 .48 .25]);
grid on;
hold on;