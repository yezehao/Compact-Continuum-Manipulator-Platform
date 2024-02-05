function node = FK_matrix(parameter,Sr)
    for i = 1:4
        % Define the bending angle alpha
        alpha = parameter(i).rad;
        d = parameter(i).d;
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
            Mt_inv = Mt';
            M(i+1).bend = round(Mt*10^5)/10^5; % round five decimal places
            M(i+1).bend_inv = round(Mt_inv*M(i).bend_inv*10^5)/10^5; % round five decimal places
            % Relative Position Matrices Calculation
            M(i+1).displacement = [0;Dhorz;Dvert];
        else
            % Relative Bending Matrices Calculation 
            Mt = [cos(alpha) 0 sin(alpha);
                  0 1 0 
                  -sin(alpha) 0 cos(alpha)];
            Mt_inv = Mt_inv';
            M(i+1).bend = round(Mt*10^5)/10^5; % round five decimal places 
            M(i+1).bend_inv = round(Mt_inv*M(i).bend_inv*10^5)/10^5; % round five decimal places
            % Relative Position Matrices Calculation
            M(i+1).displacement = [Dhorz;0;Dvert];
        end
    end

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
    node(1).coordinate = M(1).bend_inv;
    for i = 2:5
        position(:,i) = M(i-1).B*M(i).displacement + position(:,i-1);
        node(i).position = position(:,i);
        node(i).coordinate = M(i).bend_inv;
    end
end