clear;
clc;
close all;
length_mm = 300;
Sr=0.5*length_mm; 
% d=0.02*length_mm; 
d=0;
angle = [90;90;90;90];
rad = deg2rad(angle);
for i = 1:4
    % Define the bending angle alpha
    alpha = rad(i,1);
    % Relative Displacement Calculation
    if sign(alpha) == 0
        Dhorz = 0;
        Dvert = Sr+d;
    else
        R = Sr/alpha;
        Dhorz = R*(1-cos(alpha)) + d*sin(alpha);
        Dvert = R*sin(alpha) + d*cos(alpha);
        % disp(Dhorz);disp(Dvert);
    end

    % Matric structure initialization
    M(1).bend = eye(3); % the orientation of origin
    M(1).bend_inv = eye(3);
    M(1).displacement = [0;0;0]; % the position of origin
    if mod(i, 2) == 1
        % Relative Bending Matrices Calculation 
        Mt = [1 0 0;
              0 cos(alpha) sin(alpha);
              0 -sin(alpha) cos(alpha)];
        Mt_inv = [1 0 0;
              0 cos(alpha) -sin(alpha);
              0 sin(alpha) cos(alpha)];
        M(i+1).bend = round(Mt*10^5)/10^5; % round five decimal places
        M(i+1).bend_inv = round(Mt_inv*M(i).bend_inv*10^5)/10^5; % round five decimal places
        % Relative Position Matrices Calculation
        M(i+1).displacement = [0;Dhorz;Dvert];
    else
        % Relative Bending Matrices Calculation 
        Mt = [cos(alpha) 0 sin(alpha);
              0 1 0 
              -sin(alpha) 0 cos(alpha)];
        Mt_inv = [cos(alpha) 0 -sin(alpha);
              0 1 0 
              sin(alpha) 0 cos(alpha)];
        M(i+1).bend = round(Mt*10^5)/10^5; % round five decimal places 
        M(i+1).bend_inv = round(Mt_inv*M(i).bend_inv*10^5)/10^5; % round five decimal places
        % Relative Position Matrices Calculation
        M(i+1).displacement = [Dhorz;0;Dvert];
    end
end

clearvars Mt i Dhorz Dvert

% There are four units in the manipulator, the base coordinate and end 
% effector coordinate are stored in the matrix "coordinate"
% coordinate(:,i) (i = 1,2,3,4,5).
M(1).B = M(1).bend;
M(2).B = M(1).bend*M(2).bend;
M(3).B = M(1).bend*M(2).bend*M(3).bend;
M(4).B = M(1).bend*M(2).bend*M(3).bend*M(4).bend;
M(5).B = M(1).bend*M(2).bend*M(3).bend*M(4).bend*M(5).bend;
position(:,1) = M(1).displacement; % The origin
node(1).position = position(:,1);
for i = 2:5
    position(:,i) = M(i-1).B*M(i).displacement + position(:,i-1);
    node(i).position = position(:,i);
end
clearvars alpha coord_origin i rad symbol

figure;
s = 50; grid on,
% Plot the coordinate
quiver3(0, 0, 0, 300, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 300, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 300, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,

% Plot the node of manipulator
scatter3(position(1,:),position(2,:),position(3,:),s,"filled", ...
    'MarkerEdgeColor',[40/256 120/256 181/256], ...
    'MarkerFaceColor',[154/256 201/256 219/256]); hold on,
% Plot the line of manipulator
for i = 1:4
    plot3(position(1,i:i+1), position(2,i:i+1), position(3,i:i+1), 'Color', [40/256 120/256 181/256]);
    hold on;
end



% Plot the sub-coordinate
for i = 2:5
quiver3(position(1,i),position(2,i),position(3,i), ...
        50*M(i).bend_inv(1,1),50*M(i).bend_inv(1,2),50*M(i).bend_inv(1,3), ...
        'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(position(1,i),position(2,i),position(3,i), ...
        50*M(i).bend_inv(2,1),50*M(i).bend_inv(2,2),50*M(i).bend_inv(2,3), ...
        'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(position(1,i),position(2,i),position(3,i), ...
        50*M(i).bend_inv(3,1),50*M(i).bend_inv(3,2),50*M(i).bend_inv(3,3), ...
        'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
end

% %% Save file
% filename = ['result/geometry_' num2str(angle(1,1)) '_' num2str(angle(2,1)) '_' ,...
%             num2str(angle(3,1)) '_' num2str(angle(4,1)) '.png'];
% saveas(gcf, filename);