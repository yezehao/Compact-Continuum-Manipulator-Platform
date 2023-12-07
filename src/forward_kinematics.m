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
% Er: the relative error  
% S1: the ideal length of the driving cable 1
% S2: the ideal length of the driving cable 2 of the first bioinspired
% fishbone unit
% alpha1: the central angle of the bending curve
% alpha2: the central angle of the bending curve of the second unit
% d1 and d2: The thickness of the connecters at the tip of first and second
% units
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
length_mm=100;
Sr=0.5*length_mm; 
r=0.14*length_mm; 
d=0.015*length_mm; 
n=15; % define the nember of connectors is 15
deltaS1=-r*alpha1; % The cable length changes of the first fishbone unit
deltaS2=r*alpha1; %The cabel length changes
deltaS3=-r*alpha2;
deltaS4=r*alpha2;
alpha1=-(deltaS1/r);
alpha2=-(deltaS3/r);
x=-Sr*r/deltaS1+(Sr*r/deltaS1)*cos(deltaS1/r)-d1*sin(deltaS1/r)-Sr*r/deltaS3*sin(deltaS1/r)*sin(deltaS3/r)-d2*sin(deltaS1/r)*cos(deltaS3/r);
y=-Sr*r/deltaS3+(Sr*r/deltaS3)*cos(deltaS3/r)-d2*sin(deltaS3/r);
z=(Sr*r/deltaS1)*sin(deltaS1/r)+d1*cos(deltaS1/r)+(Sr*r/deltaS3)*sin(deltaS3/r)*cos(deltaS1/r)+d2*cos(deltaS1/r)*cos(deltaS3/r);
