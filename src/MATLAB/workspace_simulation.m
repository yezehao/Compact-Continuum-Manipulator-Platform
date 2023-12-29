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
Nu= 4; % The number of units 
%% Workspace Simulation
N = [10;10;10;10]; % Number of connectors
r = [50;50;40;40];
d = 0.03*Sr*ones(Nu,1);
angle = [10;10;10;10]; % The bending angle
for i = 1:Nu
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

for i = 1:50000
    for j = 1:Nu
        parameter(j).rad = parameter(j).bend_rad_max*(-1+2*rand);
    end
    node = FK_matrix(parameter,Sr);
    position(:,i) = node(Nu+1).position;
    coordinate(:,3*i-2:3*i)= node(Nu+1).coordinate;
    % for j = 1:Nu
    %     parameter(j).rad = parameter(j).bend_work*(-1+2*rand);
    % end
    % node = FK_matrix(parameter,Sr);
    % position(:,i) = node(Nu+1).position;
    % coordinate(:,3*i-2:3*i)= node(Nu+1).coordinate;
end

% %% Result Save
% writematrix(position, 'result/maximum_bending_workspace.csv');

%% Result Display
figure;
s = 5;grid on,
% Plot the coordinate
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
scatter3(position(1,:),position(2,:),position(3,:),s,"filled", ...
    'MarkerEdgeColor',[.85 .33 .10], ...
    'MarkerFaceColor',[1 .48 .25]);
title('The workspace with work angle of ± 90 degree');
xlabel('X');
ylabel('Y');
zlabel('Z');