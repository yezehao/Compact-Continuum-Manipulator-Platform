clear;clc;
%Define the name of parameters used to build the bending model of the
%bioinspired fishbone unit
length_mm=100;
Sr=0.5*length_mm;%The arc length of the bending curve
r=0.14*length_mm;%The distance between the central axis of the cable guiding hole on the connector and the central axis of the connector
d=0.015*length_mm;%the thickness of the cross-shaped sheet
figure;
for n=0:0.01:12 %Assume the number of the connectors is n
    percentage_100=1;
    alpha=60;%The central angle of the bending curve
    alpha1=pi/180*alpha;
    R1=Sr/alpha1;%R1 is the radius of the bending curve
    S1=(R1-r)*alpha1;%The ideal length of the driving cable 1 between the bottom plane of the upper connector and the top plane of the lower connector
    l1=2*(n+1)*(R1-r)*sin(alpha1/(2*(n+1)))-(n+1)*((n*d/(n+1))/sin((pi-alpha1/(n+1))/2)-n*d/(n+1));
    Ea=S1-l1;%define the absolute error
    Er=(Ea/l1)*percentage_100;%define the relative error  
    plot(n,Ea,'bo');
    xlabel('Number of connectors');
    ylabel('Absolute error(mm)');
    grid on;
    figure;
    plot(n,Er,'po');%plot the relative error
    xlabel('Number of connectors');
    ylabel('Relative error(%)');
    grid on;
    hold on;
end

for n=0:0.01:12 %Assume the number of the connectors is n
    percentage_100=1;
    alpha=10;%The central angle of the bending curve
    alpha1=pi/180*alpha;
    R1=Sr/alpha1;%R1 is the radius of the bending curve
    S1=(R1-r)*alpha1;%The ideal length of the driving cable 1 between the bottom plane of the upper connector and the top plane of the lower connector
    l1=2*(n+1)*(R1-r)*sin(alpha1/(2*(n+1)))-(n+1)*((n*d/(n+1))/sin((pi-alpha1/(n+1))/2)-n*d/(n+1));
    Ea=S1-l1;%define the absolute error
    Er=(Ea/l1)*percentage_100;%define the relative error  
    plot(n,Ea,'ro');%plot absolute error against n
    xlabel('Number of connectors');
    ylabel('Absolute error(mm)');
    grid on;
    figure;
    plot(n,Er,'po');
    xlabel('Number of connectors');
    ylabel('Relative error(%)');
    grid on;
    hold on;
end


    