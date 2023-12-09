function [C1,C2] = forward_kinematic(parameter)
    Sr= parameter.Sr; 
    r = parameter.r; 
    d = parameter.d; 
    d1= parameter.d1;
    d2= parameter.d2;
    n = parameter.n;
    r1= parameter.r1;
    S = n*d;
    R1 = Sr*r1/(Sr-S);
    % Maximum angle of manipulator
    bend_ang_max=Sr/R1;
    alpha1 = bend_ang_max*(-1+2*rand);
    alpha2 = bend_ang_max*(-1+2*rand);
    deltaS1=-r*alpha1; 
    deltaS3=-r*alpha2;
    x1=-Sr*r/deltaS1+(Sr*r/deltaS1)*cos(deltaS1/r)-d1*sin(deltaS1/r)-Sr*r/deltaS3*sin(deltaS1/r)*sin(deltaS3/r)-d2*sin(deltaS1/r)*cos(deltaS3/r);
    y1=-Sr*r/deltaS3+(Sr*r/deltaS3)*cos(deltaS3/r)-d2*sin(deltaS3/r);
    z1=(Sr*r/deltaS1)*sin(deltaS1/r)+d1*cos(deltaS1/r)+(Sr*r/deltaS3)*sin(deltaS3/r)*cos(deltaS1/r)+d2*cos(deltaS1/r)*cos(deltaS3/r);
    C1 = [x1 y1 z1];
    % Working angle of manipulator
    work_ang = pi*60/180;
    alpha1 = work_ang*(-1+2*rand);
    alpha2 = work_ang*(-1+2*rand);
    deltaS1=-r*alpha1; 
    deltaS3=-r*alpha2;
    x2=-Sr*r/deltaS1+(Sr*r/deltaS1)*cos(deltaS1/r)-d1*sin(deltaS1/r)-Sr*r/deltaS3*sin(deltaS1/r)*sin(deltaS3/r)-d2*sin(deltaS1/r)*cos(deltaS3/r);
    y2=-Sr*r/deltaS3+(Sr*r/deltaS3)*cos(deltaS3/r)-d2*sin(deltaS3/r);
    z2=(Sr*r/deltaS1)*sin(deltaS1/r)+d1*cos(deltaS1/r)+(Sr*r/deltaS3)*sin(deltaS3/r)*cos(deltaS1/r)+d2*cos(deltaS1/r)*cos(deltaS3/r);
    C2 = [x2 y2 z2];
end