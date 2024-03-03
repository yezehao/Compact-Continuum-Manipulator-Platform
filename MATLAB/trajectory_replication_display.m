clear;clc;close all;
% Read the trajectory coordinate information from txt file
target = dlmread('(UT)_dataset/data_cirlce/target.txt'); 
target_ = dlmread('(UT)_dataset/data_circle/target_.txt'); 
alpha = dlmread("(UT)_dataset/data_circle/alpha.txt");

% Point Plot
figure;
quiver3(0, 0, 0, 500, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 500, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 500, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
% scatter3(target(:,1), target(:,2), target(:,3), 'filled');
scatter3(target_(:,1), target_(:,2), target_(:,3), 20,"filled", ...
    'MarkerEdgeColor',[191,30,46]/255, ...
    'MarkerFaceColor',[239,65,67]/255);
% Line Plot
for i = 1:size(target, 1)-1
    plot3([target(i,1), target(i+1,1)], [target(i,2), target(i+1,2)], [target(i,3), target(i+1,3)], ...
        'Color',[52,88,142]/255, 'LineWidth', 3);
end

for i = 1:size(target_, 1)-1
    plot3([target_(i,1), target_(i+1,1)], [target_(i,2), target_(i+1,2)], [target_(i,3), target_(i+1,3)], ...
        'Color',[239,65,67]/255, 'LineWidth', 2);
end

% xMin = -150;
% xMax = 150;
% yMin = -150;
% yMax = 150;
% zMin = 260;
% zMax = 560;
% 
% patch([xMin, xMax, xMax, xMin], [yMin, yMin, yMax, yMax], [zMin, zMin, zMin, zMin], 'blue', 'FaceAlpha', 0.1);
% patch([xMin, xMax, xMax, xMin], [yMin, yMin, yMax, yMax], [zMax, zMax, zMax, zMax], 'blue', 'FaceAlpha', 0.1);
% patch([xMin, xMin, xMin, xMin], [yMin, yMax, yMax, yMin], [zMin, zMin, zMax, zMax], 'blue', 'FaceAlpha', 0.1);
% patch([xMax, xMax, xMax, xMax], [yMin, yMax, yMax, yMin], [zMin, zMin, zMax, zMax], 'blue', 'FaceAlpha', 0.1);
% patch([xMin, xMax, xMax, xMin], [yMin, yMin, yMin, yMin], [zMin, zMin, zMax, zMax], 'blue', 'FaceAlpha', 0.1);
% patch([xMin, xMax, xMax, xMin], [yMax, yMax, yMax, yMax], [zMin, zMin, zMax, zMax], 'blue', 'FaceAlpha', 0.1);

xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');
grid on;
