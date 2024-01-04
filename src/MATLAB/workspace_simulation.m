clear;clc;close all;tic;
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
% Pre-allocate Memory
parameter(Nu).n = [];
parameter(Nu).d = [];
parameter(Nu).r = [];
parameter(Nu).R = [];
parameter(Nu).bend_rad_max = [];
parameter(Nu).bend_work = [];
for i = 1:Nu
    parameter(i).n = N(i,1);
    parameter(i).d = d(i,1);
    parameter(i).r = r(i,1);
    S = parameter(i).n*parameter(i).d;
    parameter(i).R = Sr*parameter(i).r/(Sr-S);
    parameter(i).bend_rad_max = Sr/parameter(i).R; % maximum rad of manipulator
    parameter(i).bend_work = deg2rad(90); % work angle of manipulator
end
clearvars S i d r N

index = 10000;
% Pre-allocate Memory
position = zeros(3, index);
coordinate = zeros(3, index);
for i = 1:index
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
    if mod(i, index/100) == 0
        disp(['Iteration: ', num2str(i)]);
    end
end
clearvars i j

% %% Result Save
% writematrix(position, 'result/maximum_bending_workspace.csv');

%% Result Display
% Plot Entire Workspace
figure;s = 5;grid on,
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
scatter3(position(1,:),position(2,:),position(3,:),s,"filled", ...
    'MarkerEdgeColor',[198,61,47]/255, ...
    'MarkerFaceColor',[255,155,80]/255);
title('The Entire workspace');
xlabel('X');
ylabel('Y');
zlabel('Z');
% Plot Useful Workspace
H = 260;
range = [-150,150;-150,150;H,H+300];
position_u = position(:, ...
    position(1, :) >= range(1,1) & ...
    position(1, :) <= range(1,2) & ...
    position(2, :) >= range(2,1) & ...
    position(2, :) <= range(2,2) & ...
    position(3, :) >= range(3,1) & ...
    position(3, :) <= range(3,2));
figure;s = 5;grid on,
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
scatter3(position_u(1,:),position_u(2,:),position_u(3,:),s,"filled", ...
    'MarkerEdgeColor',[198,61,47]/255, ...
    'MarkerFaceColor',[255,155,80]/255);
title('The Useful Workspace 300x300x300 mm');
xlabel('X');
ylabel('Y');
zlabel('Z');
% Key Points Inspection
KP_vertical = [range(3,1),range(3,1)+100,range(3,1)+200,range(3,1)+300];
element = 150*[-1,0,1];
KP_horizontal = [repelem(element,1,3);repmat(element,1,3)];
KP = [repmat(KP_horizontal,1,4);repelem(KP_vertical,1,9)];
scatter3(KP(1,:),KP(2,:),KP(3,:),20,"filled", ...
    'MarkerEdgeColor',[34,40,49]/255, ...
    'MarkerFaceColor',[255,211,105]/255);
distance = pdist2(position_u', KP');
[distance_min, ~] = min(distance);
disp('Distance to the nearest point:');
for i = 1:4
    disp(['Height:',num2str(range(3,1)+100*(i-1)),' mm'])
    disp(distance_min(1,9*i-8:9*i))
end
clearvars H element distance KP_vertical KP_horizontal i s

%% Execution Time
T = toc;
disp(['The execution time of the programme is', num2str(T), 's']);
disp(['The simulation points per second of the programme is ',num2str(index/T)]);