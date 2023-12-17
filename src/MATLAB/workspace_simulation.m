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
Sr = 150; % The length of section
Ns= 4; % The number of sections 
%% Workspace Simulation
N = [10;10;10;10]; % Number of connectors
r = 0.3*Sr*ones(Ns,1);
d = 0.03*Sr*ones(Ns,1);
angle = [10;10;10;10]; % The bending angle
for i = 1:Ns
    parameter(i).n = N(i,1);
    parameter(i).d = d(i,1);
    parameter(i).r = r(i,1);
    parameter(i).rad = deg2rad(angle(i,1));
    S = parameter(i).n*parameter(i).d;
    parameter(i).R = Sr*parameter(i).r/(Sr-S);
    parameter(i).bend_rad_max = Sr/parameter(i).R; % maximum rad of manipulator
    parameter(i).bend_work = deg2rad(90); % work angle of manipulator
end
clearvars S i d r

for i = 1:100000
    for j = 1:Ns
        parameter(j).rad = parameter(j).bend_rad_max*(-1+2*rand);
    end
    end_max(:,i) = FK_matrix(parameter,Sr);
    for j = 1:Ns
        parameter(j).rad = parameter(j).bend_work*(-1+2*rand);
    end
    end_work(:,i) = FK_matrix(parameter,Sr);
end

%% Result Display
figure;
s = 5;grid on,
% Plot the coordinate
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
scatter3(end_work(1,:),end_work(2,:),end_work(3,:),s,"filled", ...
    'MarkerEdgeColor',[.85 .33 .10], ...
    'MarkerFaceColor',[1 .48 .25]);
title('The workspace with work angle of ± 90 degree');
xlabel('X');
ylabel('Y');
zlabel('Z');

figure,
s = 5;grid on,
% Plot the coordinate
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
scatter3(end_max(1,:),end_max(2,:),end_max(3,:),s,"filled", ...
    'MarkerEdgeColor',[.85 .33 .10], ...
    'MarkerFaceColor',[1 .48 .25]);
title('The workspace with maximum work angle');
xlabel('X');
ylabel('Y');
zlabel('Z');


figure,
grid on,
% Plot the coordinate
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
fitType = 'poly22'; % 选择一个二次多项式曲面
fitModel = fit([end_max(1,:)', end_max(2,:)'], end_max(3,:)', fitType);

% 获取曲面上的拟合值
[xFit, yFit] = meshgrid(min(end_max(1,:)):0.1:max(end_max(1,:)), min(end_max(2,:)):0.1:max(end_max(2,:)));
zFit = feval(fitModel, xFit, yFit);

% 在图中显示拟合曲面
mesh(xFit, yFit, zFit, 'FaceAlpha', 0.5);