clear;clc;
position = [600;1;1];
syms a b c d
angle = [a;b;c;d];
%% Parameter Define
length_mm = 300;
Sr=0.5*length_mm; 
d=0.015*length_mm; 
rad = deg2rad(angle);
for i = 1:4
    % Define the bending angle alpha
    alpha = rad(i,1);
    % Relative Displacement Calculation
    if sign(alpha) == 0
        Dhorz = 0;
        Dvert = Sr+d;
    else
        Alpha = abs(alpha);
        R = Sr/Alpha;
        Dhorz = sign(alpha)*(R*(1-cos(Alpha)) + d*sin(Alpha));
        Dvert = (R*sin(Alpha) + d*cos(Alpha));
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

clearvars Mt i Dhorz Dvert Alpha

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
%% Workspace Simulation
N = [10;10;10;10]; % Number of connectors
r = [50;50;40;40];
d = 0.03*Sr*ones(Nu,1);
for i = 1:Nu
    parameter(i).n = N(i,1);
    parameter(i).d = d(i,1);
    parameter(i).r = r(i,1);
    parameter(i).rad = deg2rad(angle(i,1));
    S = parameter(i).n*parameter(i).d;
    parameter(i).R = Sr*parameter(i).r/(Sr-S);
end
clearvars S i d r

node = FK_matrix(parameter,Sr);