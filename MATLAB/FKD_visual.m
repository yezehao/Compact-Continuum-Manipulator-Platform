clear; clc; close all;
%% Example
% load tdcr_curve_examples.mat
% fig3 = draw_tdcr(foursectdcr,[15 30 45 60],segframe=1,baseframe=1);
%% Visualization
length_mm = 300;
Sr=0.5*length_mm; 
d = 0.015*length_mm;
angle = 90*[1; 1; -1; -1];
rad = deg2rad(angle);
for i = 1:4
    % Define the bending angle alpha
    alpha = rad(i,1);
    theta = 0.1*alpha*ones(10,1);
    % Relative Displacement Calculation
    if sign(alpha) == 0
        Dhorz = 0;
        Dvert = Sr;
        sheet_horz = zeros(10,1);
        sheet_vert = 0.1*Sr*ones(10, 1);
    else
        R = Sr/alpha;
        Dhorz = R*(1-cos(alpha));
        Dvert = R*sin(alpha);
        sheet_horz = R*(1-cos(theta));
        sheet_vert = R*sin(theta);
        % disp(Dhorz);disp(Dvert);
    end

    % Matric structure initialization
    Sheet(1).R = eye(3); % the orientation of origin
    Sheet(1).Rt = eye(3);
    Sheet(1).displacement = [0;0;0]; % the position of origin
    if mod(i, 2) == 1  
        for j = 1:size(theta, 1)
            R = [1 0 0;
                  0 cos(theta(j,1)) sin(theta(j,1));
                  0 -sin(theta(j,1)) cos(theta(j,1))];
            Rt = R';
            n = (size(theta, 1)+1)*(i-1)+j;
            Sheet(n+1).R = Sheet(n).R*R;
            Sheet(n+1).Rt = Rt*Sheet(n).Rt;
            Sheet(n+1).displacement = [0;sheet_horz(j,1);sheet_vert(j,1)];
        end
        Sheet(n+2).R = Sheet(n+1).R;
        Sheet(n+2).Rt = Sheet(n+1).Rt;
        Sheet(n+2).displacement = [0;0;d];
    else
        for j = 1:size(theta, 1)
            R = [cos(theta(j,1)) 0 sin(theta(j,1));
                  0 1 0 
                  -sin(theta(j,1)) 0 cos(theta(j,1))];
            Rt = R';
            n = (size(theta, 1)+1)*(i-1)+j;
            Sheet(n+1).R = Sheet(n).R*R;
            Sheet(n+1).Rt = Rt*Sheet(n).Rt;
            Sheet(n+1).displacement = [sheet_horz(j,1);0;sheet_vert(j,1)];
        end
        Sheet(n+2).R = Sheet(n+1).R;
        Sheet(n+2).Rt = Sheet(n+1).Rt;
        Sheet(n+2).displacement = [0;0;d];
    end
end

clearvars Mt i Dhorz Dvert

position(:,1) = Sheet(1).displacement; % The origin
Homogeneous = reshape(eye(4), 1, []);
for i = 2:(4*(size(theta,1)+1)+1)
    position(:,i) = Sheet(i-1).R*Sheet(i).displacement + position(:,i-1);
    Homogeneous(i,1:16) = reshape([Sheet(i).R, position(:,i); zeros(1, 3), 1], 1, []);
end
clearvars alpha coord_origin i rad symbol

fig3 = draw_tdcr(Homogeneous,[12 23 34 45], 15, 5);
hold on;
% Plot the coordinate
quiver3(0, 0, 0, 200, 0, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 200, 0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
quiver3(0, 0, 0, 0, 0, 200, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,

% Plot the sub-coordinate
for i = [12, 23, 34, 45]
    quiver3(position(1,i),position(2,i),position(3,i), ...
            50*Sheet(i).Rt(1,1),50*Sheet(i).Rt(1,2),50*Sheet(i).Rt(1,3), ...
            'r', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
    quiver3(position(1,i),position(2,i),position(3,i), ...
            50*Sheet(i).Rt(2,1),50*Sheet(i).Rt(2,2),50*Sheet(i).Rt(2,3), ...
            'g', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
    quiver3(position(1,i),position(2,i),position(3,i), ...
            50*Sheet(i).Rt(3,1),50*Sheet(i).Rt(3,2),50*Sheet(i).Rt(3,3), ...
            'b', 'LineWidth', 2, 'MaxHeadSize', 0.1); hold on,
end

%% Save file
% filename = ['result/manipulator_' num2str(angle(1,1)) '_' num2str(angle(2,1)) '_' ,...
%             num2str(angle(3,1)) '_' num2str(angle(4,1)) '.png'];
% saveas(gcf, filename);