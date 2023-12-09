function coordinate = FK_matrix(parameter,Sr)
    for i = 1:4
        alpha = parameter(i).rad;
        symbol = sign(alpha);
        if symbol == 0
            Dhorz(i,1) = 0;
            Dvert(i,1) = Sr;
        else
            R = Sr/abs(alpha);
            if symbol == 1
                Dhorz(i,1) = R*(1-cos(alpha)) + parameter(i).d*cos(alpha);
                Dvert(i,1) = R*sin(alpha) + parameter(i).d*sin(alpha);
            elseif symbol == -1
                Dhorz(i,1) = -R*(1-cos(alpha)) - parameter(i).d*cos(alpha);
                Dvert(i,1) = -R*sin(alpha) - parameter(i).d*sin(alpha);
            end
        end
    end
    rad = [parameter(1).rad; parameter(2).rad; parameter(3).rad; parameter(4).rad];
    M(1).Section = [1 0 0 0; 
                    0 cos(rad(1,1)) sin(rad(1,1)) Dhorz(1,1);
                    0 -sin(rad(1,1)) cos(rad(1,1)) Dvert(1,1);
                    0 0 0 1];
    M(2).Section = [cos(rad(2,1)) 0 sin(rad(2,1)) Dhorz(2,1);
                    0 1 0 0
                    -sin(rad(2,1)) 0 cos(rad(2,1)) Dvert(2,1);
                    0 0 0 1];
    M(3).Section = [1 0 0 0; 
                    0 cos(rad(3,1)) sin(rad(3,1)) Dhorz(3,1);
                    0 -sin(rad(3,1)) cos(rad(3,1)) Dvert(3,1);
                    0 0 0 1];
    M(4).Section  = [cos(rad(4,1)) 0 sin(rad(4,1)) Dhorz(4,1);
                    0 1 0 0
                    -sin(rad(4,1)) 0 cos(rad(4,1)) Dvert(4,1);
                    0 0 0 1];
    
    coord_origin = [0;0;0;1];
    edge_NT = M(1).Section*M(2).Section*M(3).Section*M(4).Section*coord_origin;
    edge = edge_NT';
    coordinate= edge(1:end-1);
end