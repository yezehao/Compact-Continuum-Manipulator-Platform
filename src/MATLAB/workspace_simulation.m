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
Sr = 50; % The length of section

%% Workspace Simulation
N = [10;10;10;10]; % Number of connectors
r = 0.3*Sr*ones(4,1);
d = 0.03*Sr*ones(4,1);
angle = [10;10;10;10]; % The bending angle
for i = 1:4
    parameter(i).n = N(i,1);
    parameter(i).d = d(i,1);
    parameter(i).r = r(i,1);
    parameter(i).rad = angle(i,1)*pi/180;
    S = parameter(i).n*parameter(i).d;
    parameter(i).R = Sr*parameter(i).r/(Sr-S);
    parameter(i).bend_rad_max = Sr/parameter(i).R; % maximum rad of manipulator
    parameter(i).bend_work = pi*60/180; % work angle of manipulator
end
clearvars S i d r

for i = 1:5000
    for j = 1:4
        parameter(j).rad = parameter(j).bend_rad_max*(-1+2*rand);
    end
    Edge_max(i,:) = FK_matrix(parameter,Sr);
    for j = 1:4
        parameter(j).rad = parameter(j).bend_work*(-1+2*rand);
    end
    Edge_work(i,:) = FK_matrix(parameter,Sr);
end

% for i = 1:2000
%     [C1,C2] = FK(parameter);
%     coord1(i,:) = C1;
%     coord2(i,:) = C2;
% end

%% Result Display
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

% figure;
% s = 0.002*length(coord1(:,1));grid on;
% subplot(1,2,1)
% scatter(coord2(:,1),coord2(:,2),s,"filled", ...
%     'MarkerEdgeColor',[.85 .33 .10], ...
%     'MarkerFaceColor',[1 .48 .25]);
% grid on;
% subplot(1,2,2)
% scatter(coord2(:,1),coord2(:,3),s,"filled", ...
%     'MarkerEdgeColor',[.85 .33 .10], ...
%     'MarkerFaceColor',[1 .48 .25]);
% grid on;
% hold on;

figure;
s = 5;grid on;
scatter3(Edge_work(:,1),Edge_work(:,2),Edge_work(:,3),s,"filled", ...
    'MarkerEdgeColor',[.85 .33 .10], ...
    'MarkerFaceColor',[1 .48 .25]);
hold on;
% 使用 meshgrid 创建网格
[X, Y] = meshgrid(linspace(min(Edge_work(:,1)), max(Edge_work(:,1)), 100), ...
                   linspace(min(Edge_work(:,2)), max(Edge_work(:,2)), 100));

% 使用 griddata 插值
Z = griddata(Edge_work(:,1), Edge_work(:,2), Edge_work(:,3), X, Y);

% 绘制网格
figure;
grid on,
mesh(X, Y, Z);

% 设置图形标题和标签
title('Scatter Plot with Mesh');
xlabel('X');
ylabel('Y');
zlabel('Z');

% scatter3(Edge_max(:,1),Edge_max(:,2),Edge_max(:,3),s,"filled", ...
%     'MarkerEdgeColor',[.93 .69 .13], ...
%     'MarkerFaceColor',[1 .84 .28]);
% hold on;