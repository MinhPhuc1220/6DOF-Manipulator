clc; clear all; close all;

d1 = 1;
d2 = 1;
d3 = 3;
d4 = 1;
% x = d2*cos(the1) - d4*(sin(the1)*sin(the3) - cos(the1)*cos(the2)*cos(the3)) + d3*cos(the1)*sin(the2);
% y = d4*(cos(the1)*sin(the3) + cos(the2)*cos(the3)*sin(the1)) + d2*sin(the1) + d3*sin(the1)*sin(the2);
% z = d3*cos(the2) - d4*cos(the3)*sin(the2);
emtry1 = [];
t=0;
for the3 = 0:5:180
    for the2 = 0:5:150
        for the1 = 0:5:170
            t=t+1;
            x = d2*cosd(the1) - d4*(sind(the1)*sind(the3) - cosd(the1)*cosd(the2)*cosd(the3)) + d3*cosd(the1)*sind(the2);
            y = d4*(cosd(the1)*sind(the3) + cosd(the2)*cosd(the3)*sin(the1)) + d2*sind(the1) + d3*sind(the1)*sind(the2);
            z = d3*cosd(the2) - d4*cosd(the3)*sind(the2);
            emtry1(:,t) = [x;y;z];
        end
    end
end
figure(1);
plot3(emtry1(1,:),emtry1(2,:),emtry1(3,:),'b+','MarkerSize',0.5,'linewidth',0.05);
title("Case 1");
grid on;

emtry2 = [];
t=0;
for the3 = 0:-5:-180
    for the2 = 0:-5:-150
        for the1 = 0:5:170
            t=t+1;
            x = d2*cosd(the1) - d4*(sind(the1)*sind(the3) - cosd(the1)*cosd(the2)*cosd(the3)) + d3*cosd(the1)*sind(the2);
            y = d4*(cosd(the1)*sind(the3) + cosd(the2)*cosd(the3)*sin(the1)) + d2*sind(the1) + d3*sind(the1)*sind(the2);
            z = d3*cosd(the2) - d4*cosd(the3)*sind(the2);
            emtry2(:,t) = [x;y;z];
        end
    end
end
figure(2);
plot3(emtry2(1,:),emtry2(2,:),emtry2(3,:),'b+','MarkerSize',0.5,'linewidth',0.05);
title("Case 1");
grid on;

emtry3 = [];
t=0;
for the3 = 0:5:180
    for the2 = 0:5:150
        for the1 = 0:-5:-170
            t=t+1;
            x = d2*cosd(the1) - d4*(sind(the1)*sind(the3) - cosd(the1)*cosd(the2)*cosd(the3)) + d3*cosd(the1)*sind(the2);
            y = d4*(cosd(the1)*sind(the3) + cosd(the2)*cosd(the3)*sin(the1)) + d2*sind(the1) + d3*sind(the1)*sind(the2);
            z = d3*cosd(the2) - d4*cosd(the3)*sind(the2);
            emtry3(:,t) = [x;y;z];
        end
    end
end
figure(3);
plot3(emtry3(1,:),emtry3(2,:),emtry3(3,:),'b+','MarkerSize',0.5,'linewidth',0.05);
title("Case 1");
grid on;

emtry4 = [];
t=0;
for the3 = 0:-5:-180
    for the2 = 0:-5:-150
        for the1 = 0:-5:-170
            t=t+1;
            x = d2*cosd(the1) - d4*(sind(the1)*sind(the3) - cosd(the1)*cosd(the2)*cosd(the3)) + d3*cosd(the1)*sind(the2);
            y = d4*(cosd(the1)*sind(the3) + cosd(the2)*cosd(the3)*sin(the1)) + d2*sind(the1) + d3*sind(the1)*sind(the2);
            z = d3*cosd(the2) - d4*cosd(the3)*sind(the2);
            emtry4(:,t) = [x;y;z];
        end
    end
end
figure(4);
plot3(emtry4(1,:),emtry4(2,:),emtry4(3,:),'b+','MarkerSize',0.5,'linewidth',0.05);
title("Case 1");
grid on;