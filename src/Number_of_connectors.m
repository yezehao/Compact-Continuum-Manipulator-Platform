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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
length_mm=100;
Sr=0.5*length_mm; 
r=0.14*length_mm; 
d=0.015*length_mm; 
%% Assumption Calculation
for n=1:1:12 % Assume the number of the connectors is n
    for i = 1:1:6
        alpha1=i*10*pi/180;
        R1=Sr/alpha1; 
        S1=(R1-r)*alpha1; 
        l1=2*(n+1)*(R1-r)*sin( ...
            alpha1/(2*(n+1)))-(n+1)*((n*d/(n+1))/sin((pi-alpha1/(n+1))/2 ...
            )-n*d/(n+1));
        % calculate absolute error
        E(i).Ea(n,1) = S1-l1; 
        %E(i).Ea(n,2) = n;
        % calculate relative error 
        E(i).Er(n,1) = (E(i).Ea(n,1)/l1)*100;  
        %E(i).Er(n,2) = n;
    end
end
%% Figure Plot
figure;
subplot(1,2,1);
for i = 1:1:6
    plot(E(i).Ea);
    hold on;
end
xlabel('Number of connectors');
ylabel('Absolute error(mm)');
grid on;
subplot(1,2,2);
for i = 1:1:6
    plot(E(i).Er);
    hold on;
end
xlabel('Number of connectors');
ylabel('Relative error(%)');
grid on;
    